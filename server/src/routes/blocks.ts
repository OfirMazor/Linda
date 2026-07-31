import { Router } from "express";
import { getPool, sql } from "../db/connection.js";
import { requireAuth } from "../middleware/auth.js";

export const blocksRouter = Router();
blocksRouter.use(requireAuth);

blocksRouter.get("/stats", async (_req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.request().query(`
      WITH LatestBlocks AS (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY ObjectID ORDER BY GDB_ARCHIVE_OID DESC) AS rn
        FROM PF.Blocks
        WHERE GDB_BRANCH_ID = 0
      )
      SELECT
        SUM(CASE WHEN RetiredByRecord IS NULL THEN 1 ELSE 0 END) AS active,
        SUM(CASE WHEN RetiredByRecord IS NOT NULL THEN 1 ELSE 0 END) AS retired
      FROM LatestBlocks
      WHERE rn = 1
    `);
    const row = result.recordset[0];
    res.json({ active: row.active || 0, retired: row.retired || 0 });
  } catch (err) {
    console.error("Error fetching block stats:", err);
    res.status(500).json({ message: "Failed to fetch block statistics" });
  }
});

blocksRouter.get("/search", async (req, res) => {
  const blockNumber = parseInt(req.query.blockNumber as string, 10);
  const subBlockNumber = parseInt(req.query.subBlockNumber as string || "0", 10);

  if (isNaN(blockNumber)) {
    res.status(400).json({ message: "Invalid block number" });
    return;
  }

  try {
    const pool = await getPool();
    const result = await pool
      .request()
      .input("BlockNum", sql.Int, blockNumber)
      .input("SubBlockNum", sql.Int, subBlockNumber)
      .query(`
        WITH LatestBlocks AS (
          SELECT *, ROW_NUMBER() OVER (PARTITION BY ObjectID ORDER BY GDB_ARCHIVE_OID DESC) AS rn
          FROM PF.Blocks
          WHERE GDB_BRANCH_ID = 0
        )
        SELECT ObjectID, Name, BlockNumber, SubBlockNumber, LandType, IsTax, GlobalID
        FROM LatestBlocks
        WHERE (
          (BlockNumber = @BlockNum AND SubBlockNumber = @SubBlockNum)
          OR Name = CONCAT(CAST(@BlockNum AS NVARCHAR), '/', CAST(@SubBlockNum AS NVARCHAR))
        )
        AND RetiredByRecord IS NULL
        AND rn = 1
      `);

    res.json(result.recordset);
  } catch (err) {
    console.error("Error searching blocks:", err);
    res.status(500).json({ message: "Failed to search blocks" });
  }
});
