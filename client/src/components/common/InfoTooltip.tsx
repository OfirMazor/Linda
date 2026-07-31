import { useState, useRef } from "react";
import "./InfoTooltip.css";

interface InfoTooltipProps {
  text: string;
}

export default function InfoTooltip({ text }: InfoTooltipProps) {
  const [visible, setVisible] = useState(false);
  const [pos, setPos] = useState<{ top: number; left: number }>({ top: 0, left: 0 });
  const iconRef = useRef<HTMLSpanElement>(null);

  const show = () => {
    if (iconRef.current) {
      const rect = iconRef.current.getBoundingClientRect();
      setPos({ top: rect.bottom + 6, left: rect.left + rect.width / 2 });
    }
    setVisible(true);
  };

  return (
    <span
      className="info-tooltip-wrapper"
      onMouseEnter={show}
      onMouseLeave={() => setVisible(false)}
    >
      <span className="info-icon" ref={iconRef}>
        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <circle cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="2.5" fill="none"/>
          <line x1="12" y1="11" x2="12" y2="17" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round"/>
          <circle cx="12" cy="7.5" r="1.5" fill="currentColor"/>
        </svg>
      </span>
      {visible && (
        <div
          className="info-tooltip-popup"
          style={{ top: pos.top, left: pos.left, transform: "translateX(-50%)" }}
        >
          <p>{text}</p>
        </div>
      )}
    </span>
  );
}
