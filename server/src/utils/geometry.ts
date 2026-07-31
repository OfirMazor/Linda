/**
 * Converts Israel Transverse Mercator (ITM, EPSG:2039) coordinates to WGS84 (EPSG:4326).
 * Uses iterative inverse projection from the official ITM parameters.
 */

const a = 6378137.0;
const f = 1 / 298.257223563;
const e2 = 2 * f - f * f;
const e = Math.sqrt(e2);
const e4 = e2 * e2;
const e6 = e4 * e2;

const lon0 = (31 + 44 / 60 + 3.8170 / 3600) * Math.PI / 180;
const lat0 = (31 + 44 / 60 + 3.8170 / 3600) * Math.PI / 180;
const k0 = 1.0000067;
const falseEasting = 219529.584;
const falseNorthing = 626907.39;

const n = f / (2 - f);
const n2 = n * n;
const n3 = n2 * n;
const n4 = n3 * n;

const A_ = (a / (1 + n)) * (1 + n2 / 4 + n4 / 64);

const alpha1 = 1 / 2 * n - 2 / 3 * n2 + 5 / 16 * n3 + 41 / 180 * n4;
const alpha2 = 13 / 48 * n2 - 3 / 5 * n3 + 557 / 1440 * n4;
const alpha3 = 61 / 240 * n3 - 103 / 140 * n4;
const alpha4 = 49561 / 161280 * n4;

const beta1 = 1 / 2 * n - 2 / 3 * n2 + 37 / 96 * n3 - 1 / 360 * n4;
const beta2 = 1 / 48 * n2 + 1 / 15 * n3 - 437 / 1440 * n4;
const beta3 = 17 / 480 * n3 - 37 / 840 * n4;
const beta4 = 4397 / 161280 * n4;

const delta1 = 2 * n - 2 / 3 * n2 - 2 * n3 + 116 / 45 * n4;
const delta2 = 7 / 3 * n2 - 8 / 5 * n3 - 227 / 45 * n4;
const delta3 = 56 / 15 * n3 - 136 / 35 * n4;
const delta4 = 4279 / 630 * n4;

function meridianArc(lat: number): number {
  const sinLat = Math.sin(lat);
  const sin2 = Math.sin(2 * lat);
  const sin4 = Math.sin(4 * lat);
  const sin6 = Math.sin(6 * lat);
  const sin8 = Math.sin(8 * lat);
  return A_ * (lat + alpha1 * sin2 + alpha2 * sin4 + alpha3 * sin6 + alpha4 * sin8);
}

const M0 = meridianArc(lat0);

export function itmToWgs84(easting: number, northing: number): [number, number] {
  const xi = (northing - falseNorthing + k0 * M0) / (k0 * A_);
  const eta = (easting - falseEasting) / (k0 * A_);

  const xi1 = xi - (beta1 * Math.sin(2 * xi) * Math.cosh(2 * eta)
    + beta2 * Math.sin(4 * xi) * Math.cosh(4 * eta)
    + beta3 * Math.sin(6 * xi) * Math.cosh(8 * eta)
    + beta4 * Math.sin(8 * xi) * Math.cosh(8 * eta));

  const eta1 = eta - (beta1 * Math.cos(2 * xi) * Math.sinh(2 * eta)
    + beta2 * Math.cos(4 * xi) * Math.sinh(4 * eta)
    + beta3 * Math.cos(6 * xi) * Math.sinh(6 * eta)
    + beta4 * Math.cos(8 * xi) * Math.sinh(8 * eta));

  const chi = Math.asin(Math.sin(xi1) / Math.cosh(eta1));

  const lat = chi
    + delta1 * Math.sin(2 * chi)
    + delta2 * Math.sin(4 * chi)
    + delta3 * Math.sin(6 * chi)
    + delta4 * Math.sin(8 * chi);

  const lon = lon0 + Math.atan2(Math.sinh(eta1), Math.cos(xi1));

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
