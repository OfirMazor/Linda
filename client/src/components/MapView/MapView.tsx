import { useEffect, useRef, useState } from "react";
import maplibregl from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";
import "./MapView.css";

interface MapViewProps {
  geojson: GeoJSON.FeatureCollection;
  colorProperty: string;
  labelProperty?: string;
  outlineOnly?: boolean;
}

type BasemapType = "roadmap" | "satellite";

function getStyle(basemap: BasemapType): maplibregl.StyleSpecification {
  if (basemap === "satellite") {
    return {
      version: 8,
      sources: {
        google: {
          type: "raster",
          tiles: [
            "https://mt0.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
            "https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
            "https://mt2.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
            "https://mt3.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
          ],
          tileSize: 256,
          attribution: "&copy; Google Maps",
        },
      },
      layers: [
        {
          id: "google-satellite",
          type: "raster",
          source: "google",
          minzoom: 0,
          maxzoom: 21,
        },
      ],
    };
  }

  return {
    version: 8,
    sources: {
      google: {
        type: "raster",
        tiles: [
          "https://mt0.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
          "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
          "https://mt2.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
          "https://mt3.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
        ],
        tileSize: 256,
        attribution: "&copy; Google Maps",
      },
    },
    layers: [
      {
        id: "google-roadmap",
        type: "raster",
        source: "google",
        minzoom: 0,
        maxzoom: 21,
      },
    ],
  };
}

export default function MapView({
  geojson,
  colorProperty,
  labelProperty,
  outlineOnly,
}: MapViewProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<maplibregl.Map | null>(null);
  const isFirstBasemapRender = useRef(true);
  const [basemap, setBasemap] = useState<BasemapType>("roadmap");
  const [crsTooltipVisible, setCrsTooltipVisible] = useState(false);

  useEffect(() => {
    if (!containerRef.current) return;

    const map = new maplibregl.Map({
      container: containerRef.current,
      style: getStyle(basemap),
      center: [34.85, 31.5],
      zoom: 8,
    });

    map.addControl(new maplibregl.NavigationControl(), "top-right");
    map.addControl(new maplibregl.FullscreenControl(), "top-right");
    mapRef.current = map;

    return () => {
      map.remove();
      mapRef.current = null;
    };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    if (isFirstBasemapRender.current) {
      isFirstBasemapRender.current = false;
      return;
    }
    const map = mapRef.current;
    if (!map) return;

    const currentCenter = map.getCenter();
    const currentZoom = map.getZoom();

    map.setStyle(getStyle(basemap));

    map.once("styledata", () => {
      map.setCenter(currentCenter);
      map.setZoom(currentZoom);
    });
  }, [basemap]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map || !geojson.features.length) return;

    const addLayers = () => {
      if (map.getSource("parcels")) {
        (map.getSource("parcels") as maplibregl.GeoJSONSource).setData(geojson);
      } else {
        map.addSource("parcels", {
          type: "geojson",
          data: geojson,
        });

        if (outlineOnly) {
          map.addLayer({
            id: "parcels-fill",
            type: "fill",
            source: "parcels",
            paint: {
              "fill-color": "transparent",
              "fill-opacity": 0,
            },
          });

          map.addLayer({
            id: "block-halo",
            type: "line",
            source: "parcels",
            filter: ["==", ["get", "_type"], "block"],
            paint: {
              "line-color": "#ffffff",
              "line-width": 5,
            },
          });

          map.addLayer({
            id: "block-border",
            type: "line",
            source: "parcels",
            filter: ["==", ["get", "_type"], "block"],
            paint: {
              "line-color": "#000000",
              "line-width": 2,
            },
          });

          map.addLayer({
            id: "parcels-outline",
            type: "line",
            source: "parcels",
            filter: ["==", ["get", "_type"], "process"],
            paint: {
              "line-color": ["get", colorProperty],
              "line-width": 2,
            },
          });

          map.addLayer({
            id: "process-labels",
            type: "symbol",
            source: "parcels",
            filter: ["==", ["get", "_type"], "process"],
            layout: {
              "text-field": ["get", "ProcessName"],
              "text-size": 12,
              "text-anchor": "center",
              "text-allow-overlap": false,
              "text-ignore-placement": false,
              "text-optional": true,
            },
            paint: {
              "text-color": ["get", colorProperty],
              "text-halo-color": "#ffffff",
              "text-halo-width": 1.5,
            },
          });
        } else {
          map.addLayer({
            id: "parcels-fill",
            type: "fill",
            source: "parcels",
            paint: {
              "fill-color": ["get", colorProperty],
              "fill-opacity": 0.6,
            },
          });

          map.addLayer({
            id: "parcels-outline",
            type: "line",
            source: "parcels",
            paint: {
              "line-color": "#334155",
              "line-width": 1,
            },
          });
        }

        if (labelProperty) {
          map.addLayer({
            id: "parcels-labels",
            type: "symbol",
            source: "parcels",
            layout: {
              "text-field": ["to-string", ["get", labelProperty]],
              "text-size": 11,
              "text-anchor": "center",
            },
            paint: {
              "text-color": "#1e293b",
              "text-halo-color": "#ffffff",
              "text-halo-width": 1.5,
            },
          });
        }
      }

      const bounds = new maplibregl.LngLatBounds();
      geojson.features.forEach((feature) => {
        if (feature.geometry.type === "Polygon") {
          feature.geometry.coordinates[0]!.forEach(([lng, lat]) => {
            bounds.extend([lng!, lat!]);
          });
        } else if (feature.geometry.type === "MultiPolygon") {
          feature.geometry.coordinates.forEach((polygon) => {
            polygon[0]!.forEach(([lng, lat]) => {
              bounds.extend([lng!, lat!]);
            });
          });
        }
      });

      if (!bounds.isEmpty()) {
        map.fitBounds(bounds, { padding: 40, maxZoom: 16 });
      }
    };

    if (map.isStyleLoaded()) {
      addLayers();
    } else {
      map.on("load", addLayers);
    }
  }, [geojson, colorProperty, labelProperty, outlineOnly]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map || !geojson.features.length) return;

    const reAddLayers = () => {
      if (map.getSource("parcels")) return;

      map.addSource("parcels", {
        type: "geojson",
        data: geojson,
      });

      if (outlineOnly) {
        map.addLayer({
          id: "parcels-fill",
          type: "fill",
          source: "parcels",
          paint: { "fill-color": "transparent", "fill-opacity": 0 },
        });
        map.addLayer({
          id: "block-halo",
          type: "line",
          source: "parcels",
          filter: ["==", ["get", "_type"], "block"],
          paint: { "line-color": "#ffffff", "line-width": 5 },
        });
        map.addLayer({
          id: "block-border",
          type: "line",
          source: "parcels",
          filter: ["==", ["get", "_type"], "block"],
          paint: { "line-color": "#000000", "line-width": 2 },
        });
        map.addLayer({
          id: "parcels-outline",
          type: "line",
          source: "parcels",
          filter: ["==", ["get", "_type"], "process"],
          paint: { "line-color": ["get", colorProperty], "line-width": 2 },
        });
        map.addLayer({
          id: "process-labels",
          type: "symbol",
          source: "parcels",
          filter: ["==", ["get", "_type"], "process"],
          layout: {
            "text-field": ["get", "ProcessName"],
            "text-size": 12,
            "text-anchor": "center",
            "text-allow-overlap": false,
            "text-ignore-placement": false,
            "text-optional": true,
          },
          paint: {
            "text-color": ["get", colorProperty],
            "text-halo-color": "#ffffff",
            "text-halo-width": 1.5,
          },
        });
      } else {
        map.addLayer({
          id: "parcels-fill",
          type: "fill",
          source: "parcels",
          paint: { "fill-color": ["get", colorProperty], "fill-opacity": 0.6 },
        });
        map.addLayer({
          id: "parcels-outline",
          type: "line",
          source: "parcels",
          paint: { "line-color": "#334155", "line-width": 1 },
        });
      }

      if (labelProperty) {
        map.addLayer({
          id: "parcels-labels",
          type: "symbol",
          source: "parcels",
          layout: {
            "text-field": ["to-string", ["get", labelProperty]],
            "text-size": 11,
            "text-anchor": "center",
          },
          paint: {
            "text-color": "#1e293b",
            "text-halo-color": "#ffffff",
            "text-halo-width": 1.5,
          },
        });
      }
    };

    map.on("styledata", reAddLayers);
    return () => {
      map.off("styledata", reAddLayers);
    };
  }, [geojson, colorProperty, labelProperty, outlineOnly, basemap]);

  const toggleBasemap = () => {
    setBasemap((prev) => (prev === "roadmap" ? "satellite" : "roadmap"));
  };

  return (
    <div className="map-wrapper">
      <div ref={containerRef} className="map-container" />

      <button
        className="map-basemap-toggle"
        onClick={toggleBasemap}
        title={basemap === "roadmap" ? "Switch to Satellite" : "Switch to Roadmap"}
      >
        {basemap === "roadmap" ? (
          <>
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
              <path d="M1 3l5-2 4 2 5-2v12l-5 2-4-2-5 2V3z" stroke="currentColor" strokeWidth="1.5" fill="none"/>
              <path d="M6 1v12M10 3v12" stroke="currentColor" strokeWidth="1.5"/>
            </svg>
            <span>Satellite</span>
          </>
        ) : (
          <>
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
              <circle cx="8" cy="8" r="7" stroke="currentColor" strokeWidth="1.5" fill="none"/>
              <path d="M1 8h14M8 1c-2 2-2 5 0 7s2 5 0 7M8 1c2 2 2 5 0 7s-2 5 0 7" stroke="currentColor" strokeWidth="1"/>
            </svg>
            <span>Map</span>
          </>
        )}
      </button>

      <div className="map-crs-indicator">
        <button
          className="map-crs-button"
          onClick={() => setCrsTooltipVisible(!crsTooltipVisible)}
          title="Coordinate Reference System Information"
        >
          <svg width="14" height="14" viewBox="0 0 16 16" fill="none">
            <circle cx="8" cy="8" r="7" stroke="currentColor" strokeWidth="1.5" fill="none"/>
            <path d="M8 7v5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/>
            <circle cx="8" cy="4.5" r="0.75" fill="currentColor"/>
          </svg>
          <span>WGS 84</span>
        </button>
        {crsTooltipVisible && (
          <div className="map-crs-tooltip">
            <strong>Coordinate Reference System</strong>
            <p>
              Map displayed in <em>WGS 84 (EPSG:4326)</em> — World Geodetic System.
            </p>
            <p>
              Source cadastral data (ITM, EPSG:2039) is converted on-the-fly
              to the world reference system for display.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
