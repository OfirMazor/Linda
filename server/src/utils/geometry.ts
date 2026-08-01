/**
 * Converts Israel Transverse Mercator (ITM, EPSG:2039) coordinates to WGS84 (EPSG:4326).
 * Uses the standard Redfearn/EPSG method 9807 (Transverse Mercator) inverse formulae.
 */

const a = 6378137.0; // WGS84 semi-major axis
const f = 1 / 298.257223563; // WGS84 flattening
const b = a * (1 - f); // semi-minor axis
const e2 = 2 * f - f * f; // first eccentricity squared
const e = Math.sqrt(e2);
const ep2 = e2 / (1 - e2); // second eccentricity squared

// ITM (EPSG:2039) projection parameters
const lat0 = (31 + 44 / 60 + 3.817 / 3600) * Math.PI / 180; // latitude of origin
const lon0 = (35 + 12 / 60 + 16.261 / 3600) * Math.PI / 180; // central meridian
const k0 = 1.0000067; // scale factor
const falseEasting = 219529.584;
const falseNorthing = 626907.39;

/**
 * Compute meridian arc distance from equator to latitude phi.
 */
function meridianArc(phi: number): number {
  const n = (a - b) / (a + b);
  const n2 = n * n;
  const n3 = n2 * n;
  const n4 = n3 * n;

  const A0 = 1 + n2 / 4 + n4 / 64;
  const A2 = 3 / 2 * (n - n3 / 8);
  const A4 = 15 / 16 * (n2 - n4 / 4);
  const A6 = 35 / 48 * n3;
  const A8 = 315 / 512 * n4;

  return (a / (1 + n)) * (A0 * phi - A2 * Math.sin(2 * phi) + A4 * Math.sin(4 * phi)
    - A6 * Math.sin(6 * phi) + A8 * Math.sin(8 * phi));
}

/**
 * Compute footpoint latitude from meridian arc distance M.
 * Uses iterative Newton-Raphson method.
 */
function footpointLatitude(M: number): number {
  const mu = M / (a * (1 - e2 / 4 - 3 * e2 * e2 / 64 - 5 * e2 * e2 * e2 / 256));

  const e1 = (1 - Math.sqrt(1 - e2)) / (1 + Math.sqrt(1 - e2));
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

export function itmToWgs84(easting: number, northing: number): [number, number] {
  const M = M0 + (northing - falseNorthing) / k0;
  const phi1 = footpointLatitude(M);

  const sinPhi1 = Math.sin(phi1);
  const cosPhi1 = Math.cos(phi1);
  const tanPhi1 = Math.tan(phi1);

  const N1 = a / Math.sqrt(1 - e2 * sinPhi1 * sinPhi1);
  const T1 = tanPhi1 * tanPhi1;
  const C1 = ep2 * cosPhi1 * cosPhi1;
  const R1 = a * (1 - e2) / Math.pow(1 - e2 * sinPhi1 * sinPhi1, 1.5);
  const D = (easting - falseEasting) / (N1 * k0);

  const D2 = D * D;
  const D4 = D2 * D2;
  const D6 = D4 * D2;

  const lat = phi1
    - (N1 * tanPhi1 / R1) * (
      D2 / 2
      - (5 + 3 * T1 + 10 * C1 - 4 * C1 * C1 - 9 * ep2) * D4 / 24
      + (61 + 90 * T1 + 298 * C1 + 45 * T1 * T1 - 252 * ep2 - 3 * C1 * C1) * D6 / 720
    );

  const lon = lon0 + (1 / cosPhi1) * (
    D
    - (1 + 2 * T1 + C1) * D2 * D / 6
    + (5 - 2 * C1 + 28 * T1 - 3 * C1 * C1 + 8 * ep2 + 24 * T1 * T1) * D4 * D / 120
  );

  const latDeg = lat * 180 / Math.PI;
  const lonDeg = lon * 180 / Math.PI;

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
