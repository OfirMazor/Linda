import type {
  StatusCounts,
  BlockRecord,
  ParcelRecord,
  CadastreProcess,
  PAIResult,
  OwnershipRecord,
} from "../types";

const BASE = "/api";

async function fetchJson<T>(url: string): Promise<T> {
  const token = localStorage.getItem("auth_token");
  const res = await fetch(url, {
    headers: token ? { Authorization: `Bearer ${token}` } : {},
  });
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(
      (body as { message?: string }).message || `Request failed: ${res.status}`
    );
  }
  return res.json();
}

export async function getBlocksStats(): Promise<StatusCounts> {
  return fetchJson(`${BASE}/blocks/stats`);
}

export async function getParcels2DStats(
  blockNumber?: number,
  subBlockNumber?: number
): Promise<StatusCounts> {
  const params = blockNumber != null
    ? `?blockNumber=${blockNumber}&subBlockNumber=${subBlockNumber ?? 0}`
    : "";
  return fetchJson(`${BASE}/parcels2d/stats${params}`);
}

export async function getParcels3DStats(
  blockNumber?: number,
  subBlockNumber?: number
): Promise<StatusCounts> {
  const params = blockNumber != null
    ? `?blockNumber=${blockNumber}&subBlockNumber=${subBlockNumber ?? 0}`
    : "";
  return fetchJson(`${BASE}/parcels3d/stats${params}`);
}

export async function searchBlocks(
  blockNumber: number,
  subBlockNumber: number
): Promise<BlockRecord[]> {
  return fetchJson(
    `${BASE}/blocks/search?blockNumber=${blockNumber}&subBlockNumber=${subBlockNumber}`
  );
}

export async function getParcelsForBlock(
  blockGlobalId: string
): Promise<ParcelRecord[]> {
  return fetchJson(`${BASE}/parcels/${encodeURIComponent(blockGlobalId)}`);
}

export async function getProcessesForBlock(
  blockGlobalId: string
): Promise<{ processes: CadastreProcess[]; blockGeometry: GeoJSON.Geometry | null }> {
  return fetchJson(`${BASE}/processes/${encodeURIComponent(blockGlobalId)}`);
}

export async function getPAIForBlock(
  blockGlobalId: string
): Promise<PAIResult[]> {
  return fetchJson(`${BASE}/pai/${encodeURIComponent(blockGlobalId)}`);
}

export async function getOwnershipForBlock(
  blockGlobalId: string
): Promise<OwnershipRecord[]> {
  return fetchJson(`${BASE}/ownership/${encodeURIComponent(blockGlobalId)}`);
}
