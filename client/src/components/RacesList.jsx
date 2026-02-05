import { useState, useEffect } from 'react';
import { racesAPI } from '../services/api';
import './RacesList.css';

function RacesList() {
  const [races, setRaces] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchRaces = async () => {
      try {
        const response = await racesAPI.getAllRaces();
        setRaces(response.data);
        setLoading(false);
      } catch (err) {
        setError('Failed to fetch races: ' + err.message);
        setLoading(false);
      }
    };

    fetchRaces();
  }, []);

  if (loading) return <div className="loading">Loading races...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="races-container">
      <h1>F1 Race Weekends</h1>
      {races.length === 0 ? (
        <p>No races found. Please add races to the database.</p>
      ) : (
        <div className="races-grid">
          {races.map((race) => (
            <div key={race.id} className="race-card">
              <h2>{race.race_name}</h2>
              <p className="race-info">
                <strong>Circuit:</strong> {race.circuit_name}
              </p>
              <p className="race-info">
                <strong>Location:</strong> {race.location}, {race.country}
              </p>
              <p className="race-info">
                <strong>Date:</strong> {new Date(race.race_date).toLocaleDateString('en-US', { 
                  year: 'numeric', 
                  month: 'long', 
                  day: 'numeric' 
                })}
              </p>
              <p className="race-info">
                <strong>Season:</strong> {race.year}
              </p>
              <p className="race-info">
                <strong>Round:</strong> {race.round_number}
              </p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default RacesList;
