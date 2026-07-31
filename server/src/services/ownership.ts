import fs from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const IS_BUNDLED = path.basename(__dirname) !== "services";
const CACHE_PATH = IS_BUNDLED
  ? path.resolve(__dirname, "data", "tabu-cache.json")
  : path.resolve(__dirname, "..", "..", "data", "tabu-cache.json");

const TABU_API_BASE =
  "https://data.gov.il/api/3/action/datastore_search?resource_id=a1a91496-d692-4420-bc21-3487600b71a5";
const PAGE_SIZE = 50000;

interface TabuRecord {
  parcelKey: string;
  ownershipType: string;
}

let ownershipMap: Map<string, string> = new Map();

export async function initOwnershipCache(): Promise<void> {
  let records: TabuRecord[];
  try {
    records = await fetchFromAPI();
    await saveCache(records);
    console.log(`Ownership cache initialized with ${records.length} records from API`);
  } catch (err) {
    console.warn("Failed to fetch from Tabu API, loading local cache:", err);
    console.log(`Cache path: ${CACHE_PATH}`);
    records = await loadLocalCache();
    console.log(`Ownership cache loaded from file with ${records.length} records`);
  }
  ownershipMap = new Map(records.map((r) => [r.parcelKey, r.ownershipType]));
  console.log("Ownership data cached");
}

export function lookupOwnership(parcelKey: string): string {
  return ownershipMap.get(parcelKey) || "Unknown";
}

export function getOwnershipForParcels(
  parcels: { ParcelNumber: number; BlockNumber: number; SubBlockNumber: number }[]
): { parcelKey: string; ownershipType: string }[] {
  return parcels.map((p) => {
    const key = `${p.ParcelNumber}/${p.BlockNumber}/${p.SubBlockNumber}`;
    return { parcelKey: key, ownershipType: ownershipMap.get(key) || "Unknown" };
  });
}

async function fetchFromAPI(): Promise<TabuRecord[]> {
  const allRecords: TabuRecord[] = [];
  let offset = 0;

  while (true) {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 30000);

    try {
      const url = `${TABU_API_BASE}&limit=${PAGE_SIZE}&offset=${offset}`;
      const response = await fetch(url, { signal: controller.signal });
      if (!response.ok) {
        throw new Error(`Tabu API returned ${response.status}`);
      }

      const json = await response.json();
      const records: any[] = json.result?.records || [];

      if (records.length === 0) break;

      for (const r of records) {
        const block = r["גוש"];
        const parcel = r["חלקה"];
        if (block == null || parcel == null) continue;
        allRecords.push({
          parcelKey: `${parcel}/${block}/${r["תת חלקה"] ?? 0}`,
          ownershipType: classifyOwnership(r["סוג בעלות"] || ""),
        });
      }

      console.log(`Fetched ${allRecords.length} ownership records...`);
      offset += records.length;

      if (records.length < PAGE_SIZE) break;
    } finally {
      clearTimeout(timeout);
    }
  }

  return allRecords;
}

function classifyOwnership(rawType: string): string {
  if (rawType === "מדינה") return "Governmental";
  if (rawType === "פרטית") return "Private";
  if (rawType === "רשות מקומית") return "Other";
  if (rawType === "מעורב") return "Mixed";
  if (rawType === "אחר") return "Other";
  if (!rawType) return "Unknown";
  return "Other";
}

const TYPE_CODES: Record<string, string> = {
  Governmental: "G",
  Private: "P",
  Mixed: "M",
  Other: "O",
  Unknown: "U",
};
const CODE_TO_TYPE: Record<string, string> = Object.fromEntries(
  Object.entries(TYPE_CODES).map(([k, v]) => [v, k])
);

async function saveCache(data: TabuRecord[]): Promise<void> {
  try {
    await fs.mkdir(path.dirname(CACHE_PATH), { recursive: true });
    const compact: Record<string, string> = {};
    for (const r of data) {
      compact[r.parcelKey] = TYPE_CODES[r.ownershipType] || "U";
    }
    await fs.writeFile(CACHE_PATH, JSON.stringify(compact), "utf-8");
  } catch (err) {
    console.warn("Failed to save ownership cache:", err);
  }
}

async function loadLocalCache(): Promise<TabuRecord[]> {
  try {
    const content = await fs.readFile(CACHE_PATH, "utf-8");
    const parsed = JSON.parse(content);

    if (Array.isArray(parsed)) {
      return parsed;
    }

    return Object.entries(parsed).map(([key, code]) => ({
      parcelKey: key,
      ownershipType: CODE_TO_TYPE[code as string] || "Unknown",
    }));
  } catch {
    console.warn("No local ownership cache found, returning empty");
    return [];
  }
}
