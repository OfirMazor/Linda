import { useState, useMemo } from "react";
import "./CadastralTimeline.css";

interface TimelineProcess {
  ProcessName: string;
  ProcessType: string;
  approvalDate: string;
  color: string;
}

interface UndatedProcess {
  ProcessName: string;
  ProcessType: string;
  color: string;
}

interface CadastralTimelineProps {
  processes: TimelineProcess[];
  undatedProcesses: UndatedProcess[];
}

export default function CadastralTimeline({
  processes,
  undatedProcesses,
}: CadastralTimelineProps) {
  const [hoveredIdx, setHoveredIdx] = useState<number | null>(null);

  const { parsed, typeOffsets } = useMemo(() => {
    if (processes.length === 0) {
      return { parsed: [], typeOffsets: new Map<string, number>() };
    }

    const sorted = processes
      .map((p) => ({ ...p, date: new Date(p.approvalDate) }))
      .sort((a, b) => a.date.getTime() - b.date.getTime());

    const offsets = new Map<string, number>();
    let idx = 0;
    sorted.forEach((p) => {
      if (!offsets.has(p.ProcessType)) {
        offsets.set(p.ProcessType, idx++);
      }
    });

    return { parsed: sorted, typeOffsets: offsets };
  }, [processes]);

  if (processes.length === 0 && undatedProcesses.length === 0) {
    return null;
  }

  if (processes.length === 0) {
    return (
      <div className="timeline-section">
        <div className="timeline-undated">
          {undatedProcesses.length} תהליכים ללא תאריך אישור:{" "}
          {undatedProcesses.map((p) => p.ProcessName).join(", ")}
        </div>
      </div>
    );
  }

  const padding = 8;
  const getLeft = (index: number) => {
    if (parsed.length === 1) return 50;
    return padding + (index / (parsed.length - 1)) * (100 - padding * 2);
  };

  const getTop = (processType: string) => {
    const i = typeOffsets.get(processType) ?? 0;
    return 20 + (i % 3) * 18;
  };

  return (
    <div className="timeline-section">
      <div className="timeline-container">
        <div className="timeline-scroll-area">
          <div className="timeline-axis" />

          {parsed.map((p, i) => (
            <div
              key={i}
              className="timeline-dot"
              style={{
                left: `${getLeft(i)}%`,
                top: `${getTop(p.ProcessType)}px`,
                backgroundColor: p.color,
              }}
              onMouseEnter={() => setHoveredIdx(i)}
              onMouseLeave={() => setHoveredIdx(null)}
            >
              {hoveredIdx === i && (
                <div className="timeline-tooltip">
                  <strong>{p.ProcessName}</strong>
                  {p.ProcessType}
                  <br />
                  {p.date.toLocaleDateString("he-IL", {
                    month: "long",
                    year: "numeric",
                  })}
                </div>
              )}
            </div>
          ))}

          {parsed.map((p, i) => (
            <div
              key={`label-${i}`}
              className="timeline-date-label"
              style={{ left: `${getLeft(i)}%` }}
            >
              {p.date.toLocaleDateString("he-IL", {
                month: "short",
                year: "2-digit",
              })}
            </div>
          ))}
        </div>
      </div>

      {undatedProcesses.length > 0 && (
        <div className="timeline-undated">
          {undatedProcesses.length} תהליכים ללא תאריך אישור:{" "}
          {undatedProcesses.map((p) => p.ProcessName).join(", ")}
        </div>
      )}
    </div>
  );
}
