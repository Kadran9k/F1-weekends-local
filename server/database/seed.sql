-- Sample data for testing

USE f1_weekends;

-- Insert sample season
INSERT INTO seasons (year) VALUES (2024), (2025);

-- Insert sample circuits
INSERT INTO circuits (name, location, country, circuit_length) VALUES
('Bahrain International Circuit', 'Sakhir', 'Bahrain', 5.412),
('Jeddah Corniche Circuit', 'Jeddah', 'Saudi Arabia', 6.174),
('Albert Park Circuit', 'Melbourne', 'Australia', 5.278),
('Autodromo Enzo e Dino Ferrari', 'Imola', 'Italy', 4.909);

-- Insert sample drivers
INSERT INTO drivers (first_name, last_name, driver_number, nationality, date_of_birth) VALUES
('Max', 'Verstappen', 1, 'Dutch', '1997-09-30'),
('Lewis', 'Hamilton', 44, 'British', '1985-01-07'),
('Charles', 'Leclerc', 16, 'Monegasque', '1997-10-16'),
('Lando', 'Norris', 4, 'British', '1999-11-13');

-- Insert sample teams
INSERT INTO teams (name, nationality) VALUES
('Red Bull Racing', 'Austrian'),
('Mercedes-AMG Petronas', 'German'),
('Scuderia Ferrari', 'Italian'),
('McLaren F1 Team', 'British');
