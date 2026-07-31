import "./Spinner.css";

interface SpinnerProps {
  size?: number;
  message?: string;
}

export default function Spinner({ size = 40, message }: SpinnerProps) {
  return (
    <div className="spinner-container">
      <div
        className="spinner"
        style={{ width: size, height: size }}
      />
      {message && <p className="spinner-message">{message}</p>}
    </div>
  );
}
