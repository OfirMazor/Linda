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

function generateTicks(min: Date, max: Date): { date: Date; label: string }[] {
  const ticks: { date: Date; label: string }[] = [];
  const monthSpan =
    (max.getFullYear() - min.getFullYear()) * 12 +
    (max.getMonth() - min.getMonth());

  const skipFactor = monthSpan > 60 ? 12 : monthSpan > 24 ? 3 : 1;
  const useYearOnly = monthSpan > 60;

  const current = new Date(min.getFullYear(), min.getMonth(), 1);
  let i = 0;
  while (current <= max) {
    if (i % skipFactor === 0) {
      const label = useYearOnly
        ? current.getFullYear().toString()
        : current.toLocaleDateString("he-IL", { month: "short", year: "2-digit" });
      ticks.push({ date: new Date(current), label });
    }
    current.setMonth(current.getMonth() + 1);
    i++;
  }
  return ticks;
}

export default function CadastralTimeline({
  processes,
  undatedProcesses,
}: CadastralTimelineProps) {
  const [hoveredIdx, setHoveredIdx] = useState<number | null>(null);

  const { parsed, minDate, maxDate, ticks, scrollWidth, typeOffsets } = useMemo(() => {
    if (processes.length === 0) {
      return { parsed: [], minDate: new Date(), maxDate: new Date(), ticks: [], scrollWidth: 0, typeOffsets: new Map<string, number>() };
    }

    const sorted = processes
      .map((p) => ({ ...p, date: new Date(p.approvalDate) }))
      .sort((a, b) => a.date.getTime() - b.date.getTime());

    const min = new Date(sorted[0]!.date);
    min.setMonth(min.getMonth() - 1);
    const max = new Date(sorted[sorted.length - 1]!.date);
    max.setMonth(max.getMonth() + 1);

    const monthCount =
      (max.getFullYear() - min.getFullYear()) * 12 +
      (max.getMonth() - min.getMonth());
    const width = Math.max(monthCount * 70, 400);

    const offsets = new Map<string, number>();
    let idx = 0;
    sorted.forEach((p) => {
      if (!offsets.has(p.ProcessType)) {
        offsets.set(p.ProcessType, idx++);
      }
    });

    return {
      parsed: sorted,
      minDate: min,
      maxDate: max,
      ticks: generateTicks(min, max),
      scrollWidth: width,
      typeOffsets: offsets,
    };
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

  const totalMs = maxDate.getTime() - minDate.getTime();
  const getLeft = (date: Date) =>
    totalMs > 0 ? ((date.getTime() - minDate.getTime()) / totalMs) * 100 : 50;

  const getTop = (processType: string) => {
    const i = typeOffsets.get(processType) ?? 0;
    return 20 + (i % 3) * 18;
  };

  return (
    <div className="timeline-section">
      <div className="timeline-container">
        <div
          className="timeline-scroll-area"
          style={{ minWidth: `${scrollWidth}px` }}
        >
          <div className="timeline-axis" />

          {ticks.map((tick, i) => (
            <div
              key={i}
              className="timeline-tick"
              style={{ left: `${getLeft(tick.date)}%` }}
            >
              <div className="timeline-tick-line" />
              <div className="timeline-tick-label">{tick.label}</div>
            </div>
          ))}

          {parsed.map((p, i) => (
            <div
              key={i}
              className="timeline-dot"
              style={{
                left: `${getLeft(p.date)}%`,
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
