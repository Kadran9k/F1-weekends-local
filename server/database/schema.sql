-- F1 Weekends Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS f1_weekends;
USE f1_weekends;

-- Seasons table
CREATE TABLE IF NOT EXISTS seasons (
  id INT PRIMARY KEY AUTO_INCREMENT,
  year INT NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Circuits table
CREATE TABLE IF NOT EXISTS circuits (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  country VARCHAR(100) NOT NULL,
  circuit_length DECIMAL(5,3),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Races table
CREATE TABLE IF NOT EXISTS races (
  id INT PRIMARY KEY AUTO_INCREMENT,
  season_id INT NOT NULL,
  circuit_id INT NOT NULL,
  race_name VARCHAR(255) NOT NULL,
  race_date DATE NOT NULL,
  round_number INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (season_id) REFERENCES seasons(id) ON DELETE CASCADE,
  FOREIGN KEY (circuit_id) REFERENCES circuits(id) ON DELETE CASCADE
);

-- Drivers table
CREATE TABLE IF NOT EXISTS drivers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  driver_number INT,
  nationality VARCHAR(100),
  date_of_birth DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Teams table
CREATE TABLE IF NOT EXISTS teams (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  nationality VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Race results table
CREATE TABLE IF NOT EXISTS race_results (
  id INT PRIMARY KEY AUTO_INCREMENT,
  race_id INT NOT NULL,
  driver_id INT NOT NULL,
  team_id INT NOT NULL,
  position INT,
  points DECIMAL(5,2),
  laps_completed INT,
  time VARCHAR(50),
  status VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (race_id) REFERENCES races(id) ON DELETE CASCADE,
  FOREIGN KEY (driver_id) REFERENCES drivers(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

-- Race images table
CREATE TABLE IF NOT EXISTS race_images (
  id INT PRIMARY KEY AUTO_INCREMENT,
  race_id INT NOT NULL,
  image_url VARCHAR(500) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (race_id) REFERENCES races(id) ON DELETE CASCADE
);

-- Indexes for better performance
CREATE INDEX idx_races_season ON races(season_id);
CREATE INDEX idx_races_circuit ON races(circuit_id);
CREATE INDEX idx_races_date ON races(race_date);
CREATE INDEX idx_results_race ON race_results(race_id);
CREATE INDEX idx_results_driver ON race_results(driver_id);
CREATE INDEX idx_results_team ON race_results(team_id);
