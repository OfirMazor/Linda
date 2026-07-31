import { useMemo } from "react";
import { PieChart, Pie, Cell, Legend, Tooltip, ResponsiveContainer } from "recharts";
import MapView from "../MapView/MapView";
import Spinner from "../common/Spinner";
import type { OwnershipType } from "../../types";
import type { OwnershipData } from "../../hooks/useBlockMetrics";

interface OwnershipMetricProps {
  data: OwnershipData | null;
  loading: boolean;
}

const OWNERSHIP_COLORS: Record<OwnershipType, string> = {
  Governmental: "#1e40af",
  Private: "#059669",
  Mixed: "#d97706",
  Other: "#7c3aed",
  Unknown: "#9ca3af",
};

export default function OwnershipMetric({ data, loading }: OwnershipMetricProps) {
  const { chartData, geoJsonFeatures } = useMemo(() => {
    if (!data) return { chartData: [], geoJsonFeatures: [] };

    const ownershipMap = new Map(data.ownership.map((o) => [o.parcelKey, o.ownershipType]));
    const counts: Record<OwnershipType, number> = {
      Governmental: 0,
      Private: 0,
      Mixed: 0,
      Other: 0,
      Unknown: 0,
    };

    const features = data.parcels
      .filter((p) => p.geometry)
      .map((p) => {
        const key = `${p.ParcelNumber}/${p.BlockNumber}/${p.SubBlockNumber}`;
        const rawType = ownershipMap.get(key) || "Unknown";
        const ownerType = (
          Object.keys(OWNERSHIP_COLORS).includes(rawType) ? rawType : "Unknown"
        ) as OwnershipType;
        counts[ownerType]++;
        return {
          type: "Feature" as const,
          properties: {
            parcelNumber: p.ParcelNumber,
            ownershipType: ownerType,
            color: OWNERSHIP_COLORS[ownerType],
          },
          geometry: p.geometry!,
        };
      });

    const chart = Object.entries(counts)
      .filter(([_, v]) => v > 0)
      .map(([name, value]) => ({
        name,
        value,
        color: OWNERSHIP_COLORS[name as OwnershipType],
      }));

    return { chartData: chart, geoJsonFeatures: features };
  }, [data]);

  if (loading || !data) {
    return (
      <>
        <div className="metric-chart-pane">
          <Spinner message="Loading ownership data..." />
        </div>
        <div className="metric-map-pane">
          <Spinner />
        </div>
      </>
    );
  }

  const geojson: GeoJSON.FeatureCollection = {
    type: "FeatureCollection",
    features: geoJsonFeatures,
  };

  return (
    <>
      <div className="metric-chart-pane">
        <ResponsiveContainer width="100%" height={350}>
          <PieChart>
            <Pie
              data={chartData}
              cx="50%"
              cy="50%"
              innerRadius={60}
              outerRadius={100}
              dataKey="value"
              stroke="none"
            >
              {chartData.map((entry, index) => (
                <Cell key={index} fill={entry.color} />
              ))}
            </Pie>
            <Tooltip formatter={(value: number) => value.toLocaleString()} />
            <Legend />
          </PieChart>
        </ResponsiveContainer>
      </div>
      <div className="metric-map-pane">
        <MapView
          geojson={geojson}
          colorProperty="color"
          labelProperty="parcelNumber"
        />
      </div>
    </>
  );
}
