import { Router } from "express";
import { getPool, sql } from "../db/connection.js";
import { requireAuth } from "../middleware/auth.js";
import { wktToGeoJSON } from "../utils/geometry.js";

export const parcelsRouter = Router();
parcelsRouter.use(requireAuth);

parcelsRouter.get("/stats", async (req, res) => {
  const tableName = req.baseUrl.includes("3d") ? "PF.Parcels3D" : "PF.Parcels2D";
  const { blockNumber, subBlockNumber } = req.query;

  try {
    const pool = await getPool();
    const request = pool.request();
    let blockFilter = "";

    if (blockNumber) {
      request.input("BlockNumber", sql.Int, parseInt(blockNumber as string, 10));
      request.input("SubBlockNumber", sql.Int, parseInt((subBlockNumber as string) || "0", 10));
      blockFilter = " AND BlockNumber = @BlockNumber AND SubBlockNumber = @SubBlockNumber";
    }

    const result = await request.query(`
      WITH Latest AS (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY ObjectID ORDER BY GDB_ARCHIVE_OID DESC) AS rn
        FROM ${tableName}
        WHERE GDB_BRANCH_ID = 0${blockFilter}
      )
      SELECT
        SUM(CASE WHEN RetiredByRecord IS NULL THEN 1 ELSE 0 END) AS active,
        SUM(CASE WHEN RetiredByRecord IS NOT NULL THEN 1 ELSE 0 END) AS retired
      FROM Latest
      WHERE rn = 1
    `);
    const row = result.recordset[0];
    res.json({ active: row.active || 0, retired: row.retired || 0 });
  } catch (err) {
    console.error("Error fetching parcel stats:", err);
    res.status(500).json({ message: "Failed to fetch parcel statistics" });
  }
});

parcelsRouter.get("/:blockGlobalId", async (req, res) => {
  const { blockGlobalId } = req.params;

  try {
    const pool = await getPool();
    const result = await pool
      .request()
      .input("BlockGlobalID", sql.UniqueIdentifier, blockGlobalId)
      .query(`
        WITH TheBlock AS (
          SELECT TOP 1 BlockNumber, SubBlockNumber
          FROM PF.Blocks
          WHERE GDB_BRANCH_ID = 0 AND GlobalID = @BlockGlobalID AND RetiredByRecord IS NULL
          ORDER BY GDB_ARCHIVE_OID DESC
        ),
        LatestParcels AS (
          SELECT p.ObjectID, p.ParcelNumber, p.BlockNumber, p.SubBlockNumber, p.Shape, p.RetiredByRecord,
            ROW_NUMBER() OVER (PARTITION BY p.ObjectID ORDER BY p.GDB_ARCHIVE_OID DESC) AS rn
          FROM PF.Parcels2D p
          INNER JOIN TheBlock b ON p.BlockNumber = b.BlockNumber AND p.SubBlockNumber = b.SubBlockNumber
          WHERE p.GDB_BRANCH_ID = 0
        )
        SELECT
          ObjectID,
          ParcelNumber,
          BlockNumber,
          SubBlockNumber,
          Shape.STAsText() AS geometryWKT
        FROM LatestParcels
        WHERE rn = 1 AND RetiredByRecord IS NULL
      `);

    const parcels = result.recordset.map((row: any) => ({
      ObjectID: row.ObjectID,
      ParcelNumber: row.ParcelNumber,
      BlockNumber: row.BlockNumber,
      SubBlockNumber: row.SubBlockNumber,
      geometry: row.geometryWKT ? wktToGeoJSON(row.geometryWKT) : null,
    }));

    res.json(parcels);
  } catch (err) {
    console.error("Error fetching parcels for block:", err);
    res.status(500).json({ message: "Failed to fetch parcels" });
  }
});

