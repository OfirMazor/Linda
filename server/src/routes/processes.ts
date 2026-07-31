import { Router } from "express";
import { getPool, sql } from "../db/connection.js";
import { requireAuth } from "../middleware/auth.js";
import { wktToGeoJSON } from "../utils/geometry.js";

const PROCESS_TYPE_NAMES: Record<number, string> = {
  1: "תכנית לצרכי רישום",
  2: "תכנית מרחבית לצרכי רישום",
  3: "פסק דין",
  4: "תשריט תיעוד גבולות",
  5: "קדסטר מבוסס קואורדינטות",
  6: "תיקון הסדר לפי סעיף 97ב",
  7: "תיקון תכנית לצרכי רישום",
  8: "תיקון/עדכון בעקבות פניית ציבור",
  9: "הסדר מקרקעין",
  10: "רישום ראשון בשטח לא מוסדר",
  11: "תכנית לצרכי רישום בשטח לא מסודר",
  12: "תיקון תכנית לצרכי רישום בשטח לא מסודר",
  13: "תיקון רישום שטח וגבולות בשטח לא מוסדר",
  14: "תיקון/עדכון בעקבות פניית ציבור בשטח לא מוסדר",
  15: "תשריט תיעוד גבולות להסדר מקרקעין",
  16: "עריכה חופשית"};

export const processesRouter = Router();
processesRouter.use(requireAuth);

processesRouter.get("/:blockGlobalId", async (req, res) => {
  const { blockGlobalId } = req.params;

  try {
    const pool = await getPool();

    const [result, blockResult] = await Promise.all([
      pool
        .request()
        .input("BlockGlobalID", sql.UniqueIdentifier, blockGlobalId)
        .query(`
          SELECT
            cp.ProcessName,
            cp.ProcessType,
            cp.Shape.STAsText() AS geometryWKT,
            sd.ApprovalDate
          FROM PF.CadasterProcessBorders cp
          LEFT JOIN (
            SELECT CPBUniqueID, MAX(DateStatus) AS ApprovalDate
            FROM PF.CPBStatusAndDates
            WHERE Status IN (5, 6, 13, 103)
            GROUP BY CPBUniqueID
          ) sd ON cp.GlobalID = sd.CPBUniqueID
          WHERE cp.BlockUniqueID = @BlockGlobalID
            AND cp.Status IN (5, 6, 13, 103)
        `),
      pool
        .request()
        .input("BlockGlobalID2", sql.UniqueIdentifier, blockGlobalId)
        .query(`
          SELECT TOP 1 Shape.STAsText() AS geometryWKT
          FROM PF.Blocks
          WHERE GDB_BRANCH_ID = 0 AND GlobalID = @BlockGlobalID2 AND RetiredByRecord IS NULL
          ORDER BY GDB_ARCHIVE_OID DESC
        `),
    ]);

    const blockGeometry = blockResult.recordset[0]?.geometryWKT
      ? wktToGeoJSON(blockResult.recordset[0].geometryWKT)
      : null;

    const processes = result.recordset.map((row: any) => ({
      ProcessName: row.ProcessName,
      ProcessType: PROCESS_TYPE_NAMES[row.ProcessType] ?? String(row.ProcessType),
      geometry: row.geometryWKT ? wktToGeoJSON(row.geometryWKT) : null,
      approvalDate: row.ApprovalDate ? new Date(row.ApprovalDate).toISOString() : null,
    }));

    res.json({ processes, blockGeometry });
  } catch (err) {
    console.error("Error fetching cadastral processes:", err);
    res.status(500).json({ message: "Failed to fetch cadastral processes" });
  }
});

