import { useEffect, useState } from "react";
import { PieChart, Pie, Cell, Legend, Tooltip, ResponsiveContainer } from "recharts";
import { getBlocksStats, getParcels2DStats, getParcels3DStats } from "../../api/client";
import InfoTooltip from "../common/InfoTooltip";
import Spinner from "../common/Spinner";
import type { StatusCounts, BlockRecord } from "../../types";
import "./Container1.css";

interface Container1Props {
  selectedBlock: BlockRecord | null;
}

const COLORS_RAW = ["#2563eb", "#6b7280"];

function DonutChart({
  title,
  data,
  tooltip,
}: {
  title: string;
  data: StatusCounts | null;
  tooltip: string;
}) {
  if (!data) return <Spinner size={32} />;

  const chartData = [
    { name: "Active", value: data.active },
    { name: "Retired", value: data.retired },
  ];

  return (
    <div className="donut-card">
      <div className="donut-header">
        <h3>{title}</h3>
        <InfoTooltip text={tooltip} />
      </div>
      <ResponsiveContainer width="100%" height={200}>
        <PieChart>
          <Pie
            data={chartData}
            cx="50%"
            cy="50%"
            innerRadius={50}
            outerRadius={75}
            dataKey="value"
            stroke="none"
          >
            {chartData.map((_, index) => (
              <Cell key={index} fill={COLORS_RAW[index]} />
            ))}
          </Pie>
          <Tooltip formatter={(value: number) => value.toLocaleString()} />
          <Legend formatter={(value, entry) => `${value}: ${((entry.payload as any)?.value ?? 0).toLocaleString()}`} />
        </PieChart>
      </ResponsiveContainer>
      <div className="donut-total">
        Total: {(data.active + data.retired).toLocaleString()}
      </div>
    </div>
  );
}

export default function Container1({ selectedBlock }: Container1Props) {
  const [blocksStats, setBlocksStats] = useState<StatusCounts | null>(null);
  const [parcels2DStats, setParcels2DStats] = useState<StatusCounts | null>(null);
  const [parcels3DStats, setParcels3DStats] = useState<StatusCounts | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchStats() {
      setLoading(true);
      try {
        const blockNum = selectedBlock?.BlockNumber;
        const subBlockNum = selectedBlock?.SubBlockNumber;
        const [blocks, parcels2d, parcels3d] = await Promise.all([
          getBlocksStats(),
          getParcels2DStats(blockNum, subBlockNum),
          getParcels3DStats(blockNum, subBlockNum),
        ]);
        setBlocksStats(blocks);
        setParcels2DStats(parcels2d);
        setParcels3DStats(parcels3d);
      } catch (err) {
        console.error("Failed to load stats:", err);
      } finally {
        setLoading(false);
      }
    }
    fetchStats();
  }, [selectedBlock]);

  if (loading) {
    return (
      <section className="container1">
        <Spinner message="Loading feature statistics..." />
      </section>
    );
  }

  const show3D =
    parcels3DStats && (parcels3DStats.active + parcels3DStats.retired) > 0;

  return (
    <section className="container1">
      <div className="donut-grid">
        {!selectedBlock && (
          <DonutChart
            title="Blocks Status"
            data={blocksStats}
            tooltip="Compares active vs. retired block features nationwide. Hidden when a specific block is filtered."
          />
        )}
        <DonutChart
          title="2D Parcels Status"
          data={parcels2DStats}
          tooltip="Compares active vs. retired 2D parcel features. Always visible."
        />
        {show3D && (
          <DonutChart
            title="3D Parcels Status"
            data={parcels3DStats}
            tooltip="Compares active vs. retired 3D parcel features. Hidden if total count is 0."
          />
        )}
      </div>
    </section>
  );
}
