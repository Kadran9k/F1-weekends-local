import mariadb from 'mariadb';
import dotenv from 'dotenv';

dotenv.config();

// Create connection pool
export const pool = mariadb.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'f1_weekends',
  connectionLimit: 5,
  connectTimeout: 10000
});

// Test database connection
export const testConnection = async () => {
  let conn;
  try {
    conn = await pool.getConnection();
    console.log('Database connection successful');
    return true;
  } catch (err) {
    console.error('Database connection failed:', err);
    return false;
  } finally {
    if (conn) conn.release();
  }
};
