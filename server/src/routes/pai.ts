import { Router } from "express";
import { getPool, sql } from "../db/connection.js";
import { requireAuth } from "../middleware/auth.js";
import { wktToGeoJSON } from "../utils/geometry.js";

export const paiRouter = Router();
paiRouter.use(requireAuth);

const CLASS_WEIGHTS: Record<number, number> = {
  1: 1,
  12: 2,
  13: 3,
  24: 4,
};
const DEFAULT_WEIGHT = 4;
const MIN_POINTS = 3;

paiRouter.get("/:blockGlobalId", async (req, res) => {
  const { blockGlobalId } = req.params;

  try {
    const pool = await getPool();
    const result = await pool
      .request()
      .input("BlockGlobalID", sql.UniqueIdentifier, blockGlobalId)
      .query(`
        WITH TheBlock AS (
          SELECT TOP 1 BlockNumber, SubBlockNumber, Shape
          FROM PF.Blocks
          WHERE GDB_BRANCH_ID = 0 AND GlobalID = @BlockGlobalID AND RetiredByRecord IS NULL
          ORDER BY GDB_ARCHIVE_OID DESC
        ),
        BlockParcels AS (
          SELECT p.ObjectID, p.ParcelNumber, p.Shape, p.RetiredByRecord,
            ROW_NUMBER() OVER (PARTITION BY p.ObjectID ORDER BY p.GDB_ARCHIVE_OID DESC) AS rn
          FROM PF.Parcels2D p
          INNER JOIN TheBlock b ON p.BlockNumber = b.BlockNumber AND p.SubBlockNumber = b.SubBlockNumber
          WHERE p.GDB_BRANCH_ID = 0
        ),
        ActiveParcels AS (
          SELECT ObjectID, ParcelNumber, Shape
          FROM BlockParcels
          WHERE rn = 1 AND RetiredByRecord IS NULL
        ),
        BlockPoints AS (
          SELECT bp.ObjectID, bp.Shape, bp.Class, bp.RetiredByRecord,
            ROW_NUMBER() OVER (PARTITION BY bp.ObjectID ORDER BY bp.GDB_ARCHIVE_OID DESC) AS rn
          FROM PF.BorderPoints bp
          INNER JOIN TheBlock b ON bp.Shape.STIntersects(b.Shape) = 1
          WHERE bp.GDB_BRANCH_ID = 0 AND bp.RetiredByRecord IS NULL
        )
        SELECT
          p.ObjectID,
          p.ParcelNumber,
          p.Shape.STAsText() AS geometryWKT,
          bp.Class
        FROM ActiveParcels p
        INNER JOIN BlockPoints bp
          ON bp.Shape.STIntersects(p.Shape) = 1
          AND bp.RetiredByRecord IS NULL
          AND bp.rn = 1
      `);

    const parcelPoints = new Map<
      number,
      { parcelNumber: number; geometryWKT: string; classes: number[] }
    >();

    for (const row of result.recordset) {
      const existing = parcelPoints.get(row.ObjectID);
      const pointClass = row.Class ?? null;
      const weight = pointClass !== null && CLASS_WEIGHTS[pointClass] !== undefined
        ? CLASS_WEIGHTS[pointClass]!
        : DEFAULT_WEIGHT;

      if (existing) {
        existing.classes.push(weight);
      } else {
        parcelPoints.set(row.ObjectID, {
          parcelNumber: row.ParcelNumber,
          geometryWKT: row.geometryWKT,
          classes: [weight],
        });
      }
    }

    const paiResults = Array.from(parcelPoints.entries())
      .filter(([_, data]) => data.classes.length >= MIN_POINTS)
      .map(([objectId, data]) => {
        const n = data.classes.length;
        const sum = data.classes.reduce((a, b) => a + b, 0);
        const pai = sum / n;

        return {
          ObjectID: objectId,
          ParcelNumber: data.parcelNumber,
          pai,
          pointCount: n,
          geometry: data.geometryWKT ? wktToGeoJSON(data.geometryWKT) : null,
        };
      });

    res.json(paiResults);
  } catch (err) {
    console.error("Error computing PAI:", err);
    res.status(500).json({ message: "Failed to compute Parcel Accuracy Index" });
  }
});

