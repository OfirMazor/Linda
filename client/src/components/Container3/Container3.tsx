import type { BlockRecord, MetricType } from "../../types";
import type { BlockMetrics } from "../../hooks/useBlockMetrics";
import InfoTooltip from "../common/InfoTooltip";
import OwnershipMetric from "./OwnershipMetric";
import CadastralDiaryMetric from "./CadastralDiaryMetric";
import PAIMetric from "./PAIMetric";
import "./Container3.css";

interface Container3Props {
  block: BlockRecord;
  activeMetric: MetricType;
  onMetricChange: (metric: MetricType) => void;
  metrics: BlockMetrics;
}

const METRIC_OPTIONS: { value: MetricType; label: string; icon: string }[] = [
  { value: "ownership", label: "Ownership", icon: "🏛" },
  { value: "cadastral-diary", label: "Cadastral Diary", icon: "📋" },
  { value: "pai", label: "Parcel Accuracy", icon: "📐" },
];

export default function Container3({
  block,
  activeMetric,
  onMetricChange,
  metrics,
}: Container3Props) {
  return (
    <section className="container3">
      <div className="container3-header">
        <h2>Block {block.BlockNumber}/{block.SubBlockNumber} Analytics</h2>
        <InfoTooltip text="Synchronized chart and map views for the selected block. Switch metrics using the tabs below." />
      </div>

      <nav className="metric-tabs">
        {METRIC_OPTIONS.map((opt) => (
          <button
            key={opt.value}
            className={`metric-tab${activeMetric === opt.value ? " metric-tab--active" : ""}`}
            onClick={() => onMetricChange(opt.value)}
          >
            <span className="metric-tab-icon">{opt.icon}</span>
            <span className="metric-tab-label">{opt.label}</span>
          </button>
        ))}
      </nav>

      <div className="container3-panels">
        {activeMetric === "ownership" && (
          <OwnershipMetric
            data={metrics.ownership.data}
            loading={metrics.ownership.loading}
          />
        )}
        {activeMetric === "cadastral-diary" && (
          <CadastralDiaryMetric
            data={metrics["cadastral-diary"].data}
            loading={metrics["cadastral-diary"].loading}
          />
        )}
        {activeMetric === "pai" && (
          <PAIMetric
            data={metrics.pai.data}
            loading={metrics.pai.loading}
          />
        )}
      </div>
    </section>
  );
}
