export interface GeoJSONGeometry {
  type: "Polygon" | "MultiPolygon";
  coordinates: number[][][] | number[][][][];
}

export namespace GeoJSON {
  export type Geometry = GeoJSONGeometry | null;
}
