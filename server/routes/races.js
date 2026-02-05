import express from 'express';
import { pool } from '../config/database.js';

const router = express.Router();

// Get all races
router.get('/', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const races = await conn.query(`
      SELECT r.*, s.year, c.name as circuit_name, c.location, c.country
      FROM races r
      JOIN seasons s ON r.season_id = s.id
      JOIN circuits c ON r.circuit_id = c.id
      ORDER BY r.race_date DESC
    `);
    conn.release();
    res.json(races);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get race by ID
router.get('/:id', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const race = await conn.query(`
      SELECT r.*, s.year, c.name as circuit_name, c.location, c.country
      FROM races r
      JOIN seasons s ON r.season_id = s.id
      JOIN circuits c ON r.circuit_id = c.id
      WHERE r.id = ?
    `, [req.params.id]);
    conn.release();
    
    if (race.length === 0) {
      return res.status(404).json({ error: 'Race not found' });
    }
    
    res.json(race[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get race results
router.get('/:id/results', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const results = await conn.query(`
      SELECT rr.*, 
             d.first_name, d.last_name, d.driver_number,
             t.name as team_name
      FROM race_results rr
      JOIN drivers d ON rr.driver_id = d.id
      JOIN teams t ON rr.team_id = t.id
      WHERE rr.race_id = ?
      ORDER BY rr.position ASC
    `, [req.params.id]);
    conn.release();
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
