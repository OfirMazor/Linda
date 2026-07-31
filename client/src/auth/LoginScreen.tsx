import { useState } from "react";
import { GoogleLogin } from "@react-oauth/google";
import ParcelBackground from "./ParcelBackground";
import surveyLogo from "@/assets/survey-of-israel-logo.jpg";
import "./LoginScreen.css";

interface LoginScreenProps {
  onLogin: (credential: string) => Promise<void>;
}

export default function LoginScreen({ onLogin }: LoginScreenProps) {
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleSuccess = async (response: { credential?: string }) => {
    if (!response.credential) return;
    setLoading(true);
    setError(null);
    try {
      await onLogin(response.credential);
    } catch (err) {
      setError(
        err instanceof Error
          ? err.message
          : "Access denied. Only @mapi.gov.il accounts are authorized."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-screen">
      <ParcelBackground />
      <div className="login-logo">
        <h1>Linda</h1>
        <p className="login-subtitle">Land Indicators for Parcel-Driven Insights</p>
        <p className="login-credit">Built by the National Cadaster Dept at the Survey of Israel</p>
      </div>
      <div className="login-card">
        <div className="login-body">
          {error && (
            <div className="login-error">
              <span className="error-icon">⚠</span>
              <p>{error}</p>
            </div>
          )}

          {loading ? (
            <div className="login-loading">
              <div className="spinner" />
              <p>Verifying credentials...</p>
            </div>
          ) : (
            <div className="login-google-btn">
              <GoogleLogin
                onSuccess={handleSuccess}
                onError={() => setError("Google Sign-In failed. Please try again.")}
                theme="outline"
                size="large"
                width="300"
              />
            </div>
          )}

        </div>

        <img src={surveyLogo} alt="Survey of Israel" className="login-card-logo" />
      </div>
    </div>
  );
}
