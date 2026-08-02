import { useState, useMemo, useRef } from "react";
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

function parseHebrewDate(dateStr: string): Date {
  const parts = dateStr.match(/(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})/);
  if (parts) {
    const day = parseInt(parts[1]!, 10);
    const month = parseInt(parts[2]!, 10) - 1;
    const year = parseInt(parts[3]!, 10);
    return new Date(year, month, day);
  }
  return new Date(dateStr);
}

function formatFullDate(date: Date): string {
  return date.toLocaleDateString("en-GB", {
    day: "numeric",
    month: "long",
    year: "numeric",
  });
}

export default function CadastralTimeline({
  processes,
  undatedProcesses,
}: CadastralTimelineProps) {
  const [hoveredIdx, setHoveredIdx] = useState<number | null>(null);
  const wrapperRef = useRef<HTMLDivElement>(null);

  const parsed = useMemo(() => {
    if (processes.length === 0) return [];
    return processes
      .map((p) => ({ ...p, date: parseHebrewDate(p.approvalDate) }))
      .sort((a, b) => a.date.getTime() - b.date.getTime());
  }, [processes]);

  if (parsed.length === 0 && undatedProcesses.length === 0) {
    return null;
  }

  if (parsed.length === 0) {
    return (
      <div className="timeline-wrapper">
        <div className="timeline-undated">
          <div className="timeline-undated-title">
            {undatedProcesses.length} processes without approval date:
          </div>
          <ul className="timeline-undated-list">
            {undatedProcesses.map((p, i) => (
              <li key={i} style={{ color: p.color }}>
                {p.ProcessName}
              </li>
            ))}
          </ul>
        </div>
      </div>
    );
  }

  const itemsPerRow = 3;
  const rowCount = Math.ceil(parsed.length / itemsPerRow);

  const rows: (typeof parsed)[] = [];
  for (let r = 0; r < rowCount; r++) {
    const start = r * itemsPerRow;
    const row = parsed.slice(start, start + itemsPerRow);
    if (r % 2 === 1) row.reverse();
    rows.push(row);
  }

  return (
    <div className="timeline-wrapper" ref={wrapperRef}>
      <div className="timeline-snake">
        {rows.map((row, rowIdx) => (
          <div
            key={rowIdx}
            className={`timeline-row ${rowIdx % 2 === 1 ? "timeline-row--reverse" : ""}`}
          >
            {row.map((p, colIdx) => {
              const globalIdx =
                rowIdx % 2 === 1
                  ? rowIdx * itemsPerRow + (row.length - 1 - colIdx)
                  : rowIdx * itemsPerRow + colIdx;
              const isHovered = hoveredIdx === globalIdx;
              return (
                <div
                  key={globalIdx}
                  className={`timeline-node ${isHovered ? "timeline-node--active" : ""}`}
                  onMouseEnter={() => setHoveredIdx(globalIdx)}
                  onMouseLeave={() => setHoveredIdx(null)}
                >
                  <div
                    className="timeline-node-label"
                    style={{ color: p.color }}
                  >
                    {p.ProcessName}
                  </div>
                  <div
                    className="timeline-node-dot"
                    style={{ backgroundColor: p.color }}
                  />
                  {isHovered && (
                    <div className="timeline-node-tooltip">
                      {formatFullDate(p.date)}
                    </div>
                  )}
                </div>
              );
            })}
            {rowIdx < rowCount - 1 && <div className="timeline-row-connector" />}
          </div>
        ))}
      </div>

      {undatedProcesses.length > 0 && (
        <div className="timeline-undated">
          <div className="timeline-undated-title">
            {undatedProcesses.length} processes without approval date:
          </div>
          <ul className="timeline-undated-list">
            {undatedProcesses.map((p, i) => (
              <li key={i} style={{ color: p.color }}>
                {p.ProcessName}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}
