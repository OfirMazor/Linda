import { useState, useCallback } from "react";

interface User {
  email: string;
  name: string;
  picture: string;
}

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  login: (credential: string) => Promise<void>;
  logout: () => void;
  error: string | null;
}

export function useAuth(): AuthState {
  const [user, setUser] = useState<User | null>(null);
  const [error, setError] = useState<string | null>(null);

  const login = useCallback(async (credential: string) => {
    try {
      setError(null);
      const response = await fetch("/api/auth/verify", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ credential }),
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.message || "Authentication failed");
      }

      const data = await response.json();
      setUser(data.user);
      localStorage.setItem("auth_token", data.token);
    } catch (err) {
      const message =
        err instanceof Error ? err.message : "Authentication failed";
      setError(message);
      throw err;
    }
  }, []);

  const logout = useCallback(() => {
    setUser(null);
    localStorage.removeItem("auth_token");
  }, []);

  return {
    user,
    isAuthenticated: user !== null,
    login,
    logout,
    error,
  };
}
