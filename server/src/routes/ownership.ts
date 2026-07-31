import { Router } from "express";
import { getPool, sql } from "../db/connection.js";
import { getOwnershipForParcels } from "../services/ownership.js";
import { requireAuth } from "../middleware/auth.js";

export const ownershipRouter = Router();
ownershipRouter.use(requireAuth);

ownershipRouter.get("/:blockGlobalId", async (req, res) => {
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
          SELECT p.ParcelNumber, p.BlockNumber, p.SubBlockNumber, p.RetiredByRecord,
            ROW_NUMBER() OVER (PARTITION BY p.ObjectID ORDER BY p.GDB_ARCHIVE_OID DESC) AS rn
          FROM PF.Parcels2D p
          INNER JOIN TheBlock b ON p.BlockNumber = b.BlockNumber AND p.SubBlockNumber = b.SubBlockNumber
          WHERE p.GDB_BRANCH_ID = 0
        )
        SELECT ParcelNumber, BlockNumber, SubBlockNumber
        FROM LatestParcels
        WHERE rn = 1 AND RetiredByRecord IS NULL
      `);

    const parcels = result.recordset as { ParcelNumber: number; BlockNumber: number; SubBlockNumber: number }[];
    const ownership = getOwnershipForParcels(parcels);
    res.json(ownership);
  } catch (err) {
    console.error("Error fetching ownership for block:", err);
    res.status(500).json({ message: "Failed to fetch ownership data" });
  }
});
