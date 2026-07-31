export interface BlockRecord {
  ObjectID: number;
  Name: string;
  BlockNumber: number;
  SubBlockNumber: number;
  LandType: string | null;
  IsTax: boolean | null;
  RetiredByRecord: number | null;
  GlobalID: string;
}

export interface ParcelRecord {
  ObjectID: number;
  ParcelNumber: number;
  BlockNumber: number;
  SubBlockNumber: number;
  RetiredByRecord: number | null;
  geometry: GeoJSON.Geometry | null;
}

export interface Parcel3DRecord {
  ObjectID: number;
  RetiredByRecord: number | null;
}

export interface OwnershipRecord {
  parcelKey: string;
  ownershipType: string;
}

export interface CadastreProcess {
  ProcessName: string;
  ProcessType: string;
  geometry: GeoJSON.Geometry | null;
}

export interface PAIResult {
  ObjectID: number;
  ParcelNumber: number;
  pai: number;
  pointCount: number;
  geometry: GeoJSON.Geometry | null;
}

export interface StatusCounts {
  active: number;
  retired: number;
}

export type OwnershipType =
  | "Governmental"
  | "Private"
  | "Mixed"
  | "Other"
  | "Unknown";

export type MetricType = "ownership" | "cadastral-diary" | "pai";

export interface AppTheme {
  mode: "light" | "dark";
}
