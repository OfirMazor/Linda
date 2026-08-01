import { useState, useMemo } from "react";
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from "recharts";
import MapView from "../MapView/MapView";
import CadastralTimeline from "./CadastralTimeline";
import Spinner from "../common/Spinner";
import InfoTooltip from "../common/InfoTooltip";
import type { ProcessesData } from "../../hooks/useBlockMetrics";
import "./CadastralDiaryMetric.css";

interface CadastralDiaryMetricProps {
  data: ProcessesData | null;
  loading: boolean;
}

const PROCESS_COLORS = [
  "#2563eb",
  "#059669",
  "#d97706",
  "#dc2626",
  "#7c3aed",
  "#0891b2",
  "#be185d",
  "#65a30d",
];

export default function CadastralDiaryMetric({ data, loading }: CadastralDiaryMetricProps) {
  const [hiddenTypes, setHiddenTypes] = useState<Set<string>>(new Set());

  const { chartData, geojson, timelineProcesses, undatedProcesses } = useMemo(() => {
    if (!data) return { chartData: [], geojson: { type: "FeatureCollection" as const, features: [] }, timelineProcesses: [], undatedProcesses: [] };

    const typeCounts = new Map<string, number>();
    data.processes.forEach((p) => {
      typeCounts.set(p.ProcessType, (typeCounts.get(p.ProcessType) || 0) + 1);
    });

    const types = Array.from(typeCounts.keys());
    const colors = new Map<string, string>();
    types.forEach((t, i) => {
      colors.set(t, PROCESS_COLORS[i % PROCESS_COLORS.length]!);
    });

    const chart = types.map((type) => ({
      name: type,
      value: typeCounts.get(type)!,
      color: colors.get(type)!,
    }));

    const features: GeoJSON.Feature[] = [];

    if (data.blockGeometry) {
      features.push({
        type: "Feature",
        properties: {
          _type: "block",
          color: "transparent",
        },
        geometry: data.blockGeometry,
      });
    }

    data.processes
      .filter((p) => p.geometry)
      .forEach((p) => {
        features.push({
          type: "Feature",
          properties: {
            _type: "process",
            processName: p.ProcessName,
            processType: p.ProcessType,
            color: colors.get(p.ProcessType) || "#6b7280",
          },
          geometry: p.geometry!,
        });
      });

    const dated = data.processes
      .filter((p) => p.approvalDate)
      .map((p) => ({
        ProcessName: p.ProcessName,
        ProcessType: p.ProcessType,
        approvalDate: p.approvalDate!,
        color: colors.get(p.ProcessType) || "#6b7280",
      }));

    const undated = data.processes
      .filter((p) => !p.approvalDate)
      .map((p) => ({
        ProcessName: p.ProcessName,
        ProcessType: p.ProcessType,
        color: colors.get(p.ProcessType) || "#6b7280",
      }));

    return {
      chartData: chart,
      geojson: { type: "FeatureCollection" as const, features },
      timelineProcesses: dated,
      undatedProcesses: undated,
    };
  }, [data]);

  const filteredGeojson = useMemo(() => {
    const filtered = geojson.features.filter((f) => {
      if (f.properties?._type === "block") return true;
      return !hiddenTypes.has(f.properties?.processType);
    });
    return { type: "FeatureCollection" as const, features: filtered };
  }, [geojson, hiddenTypes]);

  const toggleType = (type: string) => {
    setHiddenTypes((prev) => {
      const next = new Set(prev);
      if (next.has(type)) {
        next.delete(type);
      } else {
        next.add(type);
      }
      return next;
    });
  };

  if (loading || !data) {
    return (
      <>
        <div className="metric-chart-pane">
          <Spinner message="Loading cadastral processes..." />
        </div>
        <div className="metric-map-pane">
          <Spinner />
        </div>
      </>
    );
  }

  const sortedData = [...chartData].sort((a, b) => a.value - b.value);

  return (
    <>
      <div className="metric-chart-pane">
        <div className="metric-info-header">
          <InfoTooltip text="Cadastral Diary: Displays all registered cadastral processes (subdivisions, consolidations, corrections, etc.) within the selected block. Reveals the block's transformation history — how parcels were created, merged, or modified over time. Use this to understand planning activity, identify areas undergoing frequent changes, and trace the legal history of land boundaries." />
        </div>
        <div className="diary-chart-layout">
          <div className="diary-legend-table-wrapper">
            <table className="diary-legend-table">
              <thead>
                <tr>
                  <th>Process Type</th>
                  <th>Count</th>
                </tr>
              </thead>
              <tbody>
                {sortedData.map((entry) => (
                  <tr key={entry.name}>
                    <td style={{ color: entry.color }}>{entry.name}</td>
                    <td style={{ color: entry.color }}>{entry.value.toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="diary-legend-total">
                  <td>Total</td>
                  <td>{sortedData.reduce((sum, e) => sum + e.value, 0).toLocaleString()}</td>
                </tr>
              </tfoot>
            </table>
          </div>
          <div className="diary-ring-wrapper">
            <ResponsiveContainer width="100%" height={300}>
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
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
        <CadastralTimeline
          processes={timelineProcesses}
          undatedProcesses={undatedProcesses}
        />
      </div>
      <div className="metric-map-pane">
        <MapView geojson={filteredGeojson} colorProperty="color" outlineOnly />
        <div className="diary-layer-control">
          <div className="diary-layer-title">Layers</div>
          {chartData.map((entry) => (
            <label key={entry.name} className="diary-layer-item">
              <input
                type="checkbox"
                checked={!hiddenTypes.has(entry.name)}
                onChange={() => toggleType(entry.name)}
              />
              <span
                className="diary-layer-swatch"
                style={{ background: entry.color }}
              />
              <span className="diary-layer-name">{entry.name}</span>
            </label>
          ))}
        </div>
      </div>
    </>
  );
}
