/**
 * Converts Israel Transverse Mercator (ITM, EPSG:2039) coordinates to WGS84 (EPSG:4326).
 *
 * EPSG:2039 uses the Israel 1993 datum (GRS80 ellipsoid) with a 7-parameter Helmert
 * datum shift to WGS84: towgs84 = -48, 55, 52, 0, 0, 0, 0
 *
 * Pipeline: ITM grid coords → inverse TM projection (GRS80) → geodetic on Israel datum
 *           → 3-parameter datum shift → geodetic on WGS84
 */

// GRS80 ellipsoid (used by Israel 1993 datum / EPSG:2039)
const a_grs = 6378137.0;
const f_grs = 1 / 298.257222101;
const b_grs = a_grs * (1 - f_grs);
const e2_grs = 2 * f_grs - f_grs * f_grs;
const ep2_grs = e2_grs / (1 - e2_grs);

// WGS84 ellipsoid
const a_wgs = 6378137.0;
const f_wgs = 1 / 298.257223563;
const b_wgs = a_wgs * (1 - f_wgs);
const e2_wgs = 2 * f_wgs - f_wgs * f_wgs;

// ITM (EPSG:2039) projection parameters
const lat0 = (31 + 44 / 60 + 3.817 / 3600) * Math.PI / 180;
const lon0 = (35 + 12 / 60 + 16.261 / 3600) * Math.PI / 180;
const k0 = 1.0000067;
const falseEasting = 219529.584;
const falseNorthing = 626907.39;

// Datum shift parameters: Israel 1993 -> WGS84 (Bursa-Wolf / Helmert)
// towgs84 = -48, 55, 52, 0, 0, 0, 0 (translation only, no rotation/scale)
const dx = -48;
const dy = 55;
const dz = 52;

function meridianArc(phi: number): number {
  const n = (a_grs - b_grs) / (a_grs + b_grs);
  const n2 = n * n;
  const n3 = n2 * n;
  const n4 = n3 * n;

  const A0 = 1 + n2 / 4 + n4 / 64;
  const A2 = 3 / 2 * (n - n3 / 8);
  const A4 = 15 / 16 * (n2 - n4 / 4);
  const A6 = 35 / 48 * n3;
  const A8 = 315 / 512 * n4;

  return (a_grs / (1 + n)) * (A0 * phi - A2 * Math.sin(2 * phi) + A4 * Math.sin(4 * phi)
    - A6 * Math.sin(6 * phi) + A8 * Math.sin(8 * phi));
}

function footpointLatitude(M: number): number {
  const mu = M / (a_grs * (1 - e2_grs / 4 - 3 * e2_grs * e2_grs / 64 - 5 * e2_grs * e2_grs * e2_grs / 256));

  const e1 = (1 - Math.sqrt(1 - e2_grs)) / (1 + Math.sqrt(1 - e2_grs));
  const e12 = e1 * e1;
  const e13 = e12 * e1;
  const e14 = e13 * e1;

  return mu
    + (3 / 2 * e1 - 27 / 32 * e13) * Math.sin(2 * mu)
    + (21 / 16 * e12 - 55 / 32 * e14) * Math.sin(4 * mu)
    + (151 / 96 * e13) * Math.sin(6 * mu)
    + (1097 / 512 * e14) * Math.sin(8 * mu);
}

const M0 = meridianArc(lat0);

/**
 * Inverse Transverse Mercator: grid (E, N) → geodetic (lat, lon) on GRS80.
 */
function itmToGeodetic(easting: number, northing: number): [number, number] {
  const M = M0 + (northing - falseNorthing) / k0;
  const phi1 = footpointLatitude(M);

  const sinPhi1 = Math.sin(phi1);
  const cosPhi1 = Math.cos(phi1);
  const tanPhi1 = Math.tan(phi1);

  const N1 = a_grs / Math.sqrt(1 - e2_grs * sinPhi1 * sinPhi1);
  const T1 = tanPhi1 * tanPhi1;
  const C1 = ep2_grs * cosPhi1 * cosPhi1;
  const R1 = a_grs * (1 - e2_grs) / Math.pow(1 - e2_grs * sinPhi1 * sinPhi1, 1.5);
  const D = (easting - falseEasting) / (N1 * k0);

  const D2 = D * D;
  const D4 = D2 * D2;
  const D6 = D4 * D2;

  const lat = phi1
    - (N1 * tanPhi1 / R1) * (
      D2 / 2
      - (5 + 3 * T1 + 10 * C1 - 4 * C1 * C1 - 9 * ep2_grs) * D4 / 24
      + (61 + 90 * T1 + 298 * C1 + 45 * T1 * T1 - 252 * ep2_grs - 3 * C1 * C1) * D6 / 720
    );

  const lon = lon0 + (1 / cosPhi1) * (
    D
    - (1 + 2 * T1 + C1) * D2 * D / 6
    + (5 - 2 * C1 + 28 * T1 - 3 * C1 * C1 + 8 * ep2_grs + 24 * T1 * T1) * D4 * D / 120
  );

  return [lon, lat];
}

/**
 * Geodetic (lat, lon) on GRS80 → Cartesian (X, Y, Z)
 */
function geodeticToCartesian(lon: number, lat: number, a: number, e2: number): [number, number, number] {
  const sinLat = Math.sin(lat);
  const cosLat = Math.cos(lat);
  const sinLon = Math.sin(lon);
  const cosLon = Math.cos(lon);
  const N = a / Math.sqrt(1 - e2 * sinLat * sinLat);

  const X = N * cosLat * cosLon;
  const Y = N * cosLat * sinLon;
  const Z = N * (1 - e2) * sinLat;

  return [X, Y, Z];
}

/**
 * Cartesian (X, Y, Z) → Geodetic (lon, lat) on WGS84
 * Uses Bowring's iterative method.
 */
function cartesianToGeodetic(X: number, Y: number, Z: number): [number, number] {
  const lon = Math.atan2(Y, X);

  const p = Math.sqrt(X * X + Y * Y);
  let lat = Math.atan2(Z, p * (1 - e2_wgs));

  for (let i = 0; i < 10; i++) {
    const sinLat = Math.sin(lat);
    const N = a_wgs / Math.sqrt(1 - e2_wgs * sinLat * sinLat);
    lat = Math.atan2(Z + e2_wgs * N * sinLat, p);
  }

  return [lon, lat];
}

export function itmToWgs84(easting: number, northing: number): [number, number] {
  // Step 1: Inverse TM projection → geodetic on Israel 1993 datum (GRS80)
  const [lon_il, lat_il] = itmToGeodetic(easting, northing);

  // Step 2: Geodetic → Cartesian (on GRS80)
  const [X, Y, Z] = geodeticToCartesian(lon_il, lat_il, a_grs, e2_grs);

  // Step 3: Apply 3-parameter datum shift (Israel 1993 → WGS84)
  const X_wgs = X + dx;
  const Y_wgs = Y + dy;
  const Z_wgs = Z + dz;

  // Step 4: Cartesian → Geodetic (on WGS84)
  const [lon_wgs, lat_wgs] = cartesianToGeodetic(X_wgs, Y_wgs, Z_wgs);

  const lonDeg = lon_wgs * 180 / Math.PI;
  const latDeg = lat_wgs * 180 / Math.PI;

  return [lonDeg, latDeg];
}

export function wktToGeoJSON(wkt: string): GeoJSON.Geometry | null {
  try {
    if (wkt.startsWith("POLYGON")) {
      const coordStr = wkt.replace("POLYGON ((", "").replace("))", "");
      const rings = coordStr.split("), (").map((ring) =>
        ring
          .replace(/[()]/g, "")
          .split(", ")
          .map((pair) => {
            const [x, y] = pair.split(" ").map(Number);
            return itmToWgs84(x!, y!);
          })
      );
      return { type: "Polygon", coordinates: rings };
    }
    if (wkt.startsWith("MULTIPOLYGON")) {
      const inner = wkt.slice("MULTIPOLYGON ((".length, -2);
      const polygons = inner.split(")), ((").map((poly) =>
        poly.split("), (").map((ring) =>
          ring
            .replace(/[()]/g, "")
            .split(", ")
            .map((pair) => {
              const [x, y] = pair.split(" ").map(Number);
              return itmToWgs84(x!, y!);
            })
        )
      );
      return { type: "MultiPolygon", coordinates: polygons };
    }
    return null;
  } catch {
    return null;
  }
}
