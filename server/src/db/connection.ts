import sql from "mssql";

let pool: sql.ConnectionPool | null = null;

export async function connectDB(): Promise<sql.ConnectionPool> {
  if (pool) return pool;
  const config: sql.config = {
    server: process.env.DB_SERVER || "BankalModProd",
    database: process.env.DB_NAME || "MNCDB",
    user: process.env.DB_USER || "",
    password: process.env.DB_PASSWORD || "",
    options: {
      encrypt: false,
      trustServerCertificate: true,
      enableArithAbort: true,
    },
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000,
    },
  };
  pool = await sql.connect(config);
  return pool;
}

export async function getPool(): Promise<sql.ConnectionPool> {
  if (!pool) {
    return connectDB();
  }
  return pool;
}

export { sql };
