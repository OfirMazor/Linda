import "./Header.css";

interface HeaderProps {
  user: { email: string; name: string; picture: string } | null;
  theme: "light" | "dark";
  onToggleTheme: () => void;
  onLogout: () => void;
}

export default function Header({
  user,
  theme,
  onToggleTheme,
  onLogout,
}: HeaderProps) {
  return (
    <header className="app-header">
      <div className="header-brand">
        <h1 className="header-title">Linda</h1>
        <span className="header-tagline">Land Indicators for Parcel-Driven Insights</span>
      </div>

      <div className="header-actions">
        <button
          className={`theme-toggle ${theme}`}
          onClick={onToggleTheme}
          title={`Switch to ${theme === "light" ? "dark" : "light"} mode`}
          aria-label={`Switch to ${theme === "light" ? "dark" : "light"} mode`}
        >
          <span className="toggle-label">
            {theme === "light" ? "LIGHT" : "DARK"}
          </span>
          <span className="toggle-knob">
            {theme === "light" ? (
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <circle cx="12" cy="12" r="5"/>
                <line x1="12" y1="1" x2="12" y2="3"/>
                <line x1="12" y1="21" x2="12" y2="23"/>
                <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"/>
                <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"/>
                <line x1="1" y1="12" x2="3" y2="12"/>
                <line x1="21" y1="12" x2="23" y2="12"/>
                <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"/>
                <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"/>
              </svg>
            ) : (
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
                <circle cx="19" cy="5" r="1" fill="currentColor" stroke="none"/>
                <circle cx="17" cy="9" r="0.5" fill="currentColor" stroke="none"/>
              </svg>
            )}
          </span>
        </button>

        {user && (
          <div className="header-user">
            {user.picture ? (
              <img
                src={user.picture}
                alt={user.name}
                className="user-avatar"
                onError={(e) => {
                  (e.target as HTMLImageElement).style.display = "none";
                  (e.target as HTMLImageElement).nextElementSibling?.classList.remove("hidden");
                }}
              />
            ) : null}
            <span
              className={`user-avatar-fallback${user.picture ? " hidden" : ""}`}
              aria-hidden="true"
            >
              {user.name.split(" ").map((n) => n[0]).join("").slice(0, 2).toUpperCase()}
            </span>
            <span className="user-name">{user.name}</span>
            <button className="logout-btn" onClick={onLogout}>
              Sign Out
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
