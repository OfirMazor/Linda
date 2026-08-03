import { useState, useCallback } from "react";
import Header from "./components/Header/Header";
import Container1 from "./components/Container1/Container1";
import Container2 from "./components/Container2/Container2";
import Container3 from "./components/Container3/Container3";
import LoginScreen from "./auth/LoginScreen";
import { useAuth } from "./hooks/useAuth";
import { useBlockMetrics } from "./hooks/useBlockMetrics";
import type { BlockRecord, MetricType } from "./types";
import "./App.css";

export default function App() {
  const { user, login, logout, isAuthenticated } = useAuth();
  const [selectedBlock, setSelectedBlock] = useState<BlockRecord | null>(null);
  const [activeMetric, setActiveMetric] = useState<MetricType>("ownership");
  const [theme, setTheme] = useState<"light" | "dark">("light");

  const metrics = useBlockMetrics(selectedBlock?.GlobalID ?? null);

  const toggleTheme = useCallback(() => {
    setTheme((prev) => {
      const next = prev === "light" ? "dark" : "light";
      document.documentElement.setAttribute("data-theme", next);
      return next;
    });
  }, []);

  if (!isAuthenticated) {
    return <LoginScreen onLogin={login} />;
  }

  return (
    <div className="app-layout">
      <Header
        user={user}
        theme={theme}
        onToggleTheme={toggleTheme}
        onLogout={logout}
      />
      <main className="dashboard">
        <Container2
          onBlockSelected={setSelectedBlock}
          selectedBlock={selectedBlock}
        />
        <Container1 selectedBlock={selectedBlock} />
        {selectedBlock && (
          <Container3
            block={selectedBlock}
            activeMetric={activeMetric}
            onMetricChange={setActiveMetric}
            metrics={metrics}
          />
        )}
      </main>
    </div>
  );
}
