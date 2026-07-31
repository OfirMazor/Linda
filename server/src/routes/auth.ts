import { Router } from "express";
import jwt from "jsonwebtoken";

export const authRouter = Router();

const JWT_SECRET = process.env.JWT_SECRET || "linda-secret-key-change-me";
const ALLOWED_DOMAIN = "mapi.gov.il";

authRouter.post("/verify", async (req, res) => {
  const { credential } = req.body;

  if (!credential) {
    res.status(400).json({ message: "Missing credential token" });
    return;
  }

  try {
    const parts = credential.split(".");
    if (parts.length !== 3) {
      res.status(401).json({ message: "Invalid token format" });
      return;
    }

    const payload = JSON.parse(
      Buffer.from(parts[1], "base64url").toString("utf-8")
    );

    if (!payload.email) {
      res.status(401).json({ message: "Invalid token payload" });
      return;
    }

    const emailDomain = payload.email.split("@")[1];
    if (emailDomain !== ALLOWED_DOMAIN) {
      res.status(403).json({
        message: `Access denied. Only @${ALLOWED_DOMAIN} accounts are authorized.`,
      });
      return;
    }

    const user = {
      email: payload.email,
      name: payload.name || payload.email,
      picture: payload.picture || "",
    };

    const token = jwt.sign(
      { email: user.email, name: user.name },
      JWT_SECRET,
      { expiresIn: "8h" }
    );

    res.json({ user, token });
  } catch (err) {
    console.error("Auth verification failed:", err);
    res.status(401).json({ message: "Authentication failed" });
  }
});
