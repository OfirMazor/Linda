import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";
import express from "express";
import cors from "cors";
import { connectDB } from "./db/connection.js";
import { authRouter } from "./routes/auth.js";
import { blocksRouter } from "./routes/blocks.js";
import { parcelsRouter } from "./routes/parcels.js";
import { processesRouter } from "./routes/processes.js";
import { paiRouter } from "./routes/pai.js";
import { ownershipRouter } from "./routes/ownership.js";
import { initOwnershipCache } from "./services/ownership.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(__dirname, ".env") });

const app = express();
const PORT = parseInt(process.env.PORT || "3001", 10);

app.use(cors());
app.use(express.json());

app.use("/api/auth", authRouter);
app.use("/api/blocks", blocksRouter);
app.use("/api/parcels2d", parcelsRouter);
app.use("/api/parcels3d", parcelsRouter);
app.use("/api/parcels", parcelsRouter);
app.use("/api/processes", processesRouter);
app.use("/api/pai", paiRouter);
app.use("/api/ownership", ownershipRouter);

app.get("/api/health", (_req, res) => {
  res.json({ status: "ok" });
});

const clientDist = path.resolve(__dirname, process.env.NODE_ENV === "production" ? "client" : "../client");
app.use(express.static(clientDist));
app.get("*", (_req, res, next) => {
  if (_req.path.startsWith("/api")) return next();
  res.sendFile(path.join(clientDist, "index.html"));
});

async function start() {
  try {
    await connectDB();
    console.log("Database connected successfully");
  } catch (err) {
    console.warn("Database connection failed (running without DB):", (err as Error).message);
  }

  try {
    await initOwnershipCache();
    console.log("Ownership data cached");
  } catch (err) {
    console.warn("Ownership cache init failed:", (err as Error).message);
  }

  app.listen(PORT, () => {
    console.log(`Linda server running on http://localhost:${PORT}`);
  });
}

start();
