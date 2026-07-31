import { useMemo } from "react";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import MapView from "../MapView/MapView";
import Spinner from "../common/Spinner";
import type { PAIResult } from "../../types";
import "./PAIMetric.css";

interface PAIMetricProps {
  data: PAIResult[] | null;
  loading: boolean;
}

function paiToColor(pai: number, minPai: number, maxPai: number): string {
  const range = maxPai - minPai || 1;
  const t = (pai - minPai) / range;
  const r = Math.round(t * 220 + (1 - t) * 37);
  const g = Math.round(t * 38 + (1 - t) * 99);
  const b = Math.round(t * 38 + (1 - t) * 235);
  return `rgb(${r}, ${g}, ${b})`;
}

export default function PAIMetric({ data, loading }: PAIMetricProps) {
  const { histogramData, geojson } = useMemo(() => {
    if (!data) return { histogramData: [], geojson: null };

    const validParcels = data.filter((p) => p.pointCount >= 3);

    if (validParcels.length === 0) {
      return { histogramData: [], geojson: null };
    }

    const paiValues = validParcels.map((p) => p.pai);
    const min = Math.min(...paiValues);
    const max = Math.max(...paiValues);
    const binSize = (max - min) / 10 || 0.1;

    const bins = Array.from({ length: 10 }, (_, i) => ({
      range: `${(min + i * binSize).toFixed(1)}-${(min + (i + 1) * binSize).toFixed(1)}`,
      count: 0,
      binStart: min + i * binSize,
      binEnd: min + (i + 1) * binSize,
    }));

    validParcels.forEach((p) => {
      const binIndex = Math.min(Math.floor((p.pai - min) / binSize), 9);
      bins[binIndex]!.count++;
    });

    const features = validParcels
      .filter((p) => p.geometry)
      .map((p) => ({
        type: "Feature" as const,
        properties: {
          parcelNumber: p.ParcelNumber,
          pai: p.pai.toFixed(2),
          pointCount: p.pointCount,
          color: paiToColor(p.pai, min, max),
        },
        geometry: p.geometry!,
      }));

    return {
      histogramData: bins,
      geojson: { type: "FeatureCollection" as const, features },
    };
  }, [data]);

  if (loading || !data) {
    return (
      <>
        <div className="metric-chart-pane">
          <Spinner message="Computing Parcel Accuracy Index (spatial join in progress)..." />
        </div>
        <div className="metric-map-pane">
          <Spinner />
        </div>
      </>
    );
  }

  return (
    <>
      <div className="metric-chart-pane">
        <div className="pai-legend">
          <span className="pai-legend-label">High Accuracy</span>
          <div className="pai-gradient" />
          <span className="pai-legend-label">Low Accuracy</span>
        </div>
        <ResponsiveContainer width="100%" height={320}>
          <BarChart data={histogramData}>
            <CartesianGrid strokeDasharray="3 3" stroke="var(--color-border)" />
            <XAxis
              dataKey="range"
              tick={{ fontSize: 11 }}
              label={{ value: "PAI Range", position: "insideBottom", offset: -5 }}
            />
            <YAxis
              tick={{ fontSize: 11 }}
              label={{
                value: "Parcel Count",
                angle: -90,
                position: "insideLeft",
              }}
            />
            <Tooltip />
            <Bar dataKey="count" fill="var(--color-primary)" radius={[4, 4, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </div>
      <div className="metric-map-pane">
        {geojson ? (
          <MapView
            geojson={geojson}
            colorProperty="color"
            labelProperty="parcelNumber"
          />
        ) : (
          <div className="metric-empty">
            No parcels with sufficient boundary points.
          </div>
        )}
      </div>
    </>
  );
}
