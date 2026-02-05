# Project Architecture

## Overview

F1 Weekends Local is a full-stack web application built with React frontend and Node.js backend, using MariaDB for data persistence.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                          Client                              │
│  ┌────────────────────────────────────────────────────┐     │
│  │                    React App                        │     │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────┐     │     │
│  │  │Components│  │  Pages   │  │   Services   │     │     │
│  │  │          │  │          │  │   (API calls)│     │     │
│  │  └──────────┘  └──────────┘  └──────────────┘     │     │
│  └────────────────────────────────────────────────────┘     │
│                          │                                   │
│                   HTTP Requests                              │
│                          │                                   │
└──────────────────────────┼───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    Backend Server                            │
│  ┌────────────────────────────────────────────────────┐     │
│  │              Express.js Server                      │     │
│  │  ┌──────────┐  ┌──────────┐  ┌────────────────┐   │     │
│  │  │  Routes  │→ │Controller│→ │     Models      │   │     │
│  │  └──────────┘  └──────────┘  └────────────────┘   │     │
│  │       │                              │              │     │
│  │       │                              │              │     │
│  │  ┌────▼──────────────────────────────▼───────┐    │     │
│  │  │         Database Connection Pool           │    │     │
│  │  └────────────────────────────────────────────┘    │     │
│  └────────────────────────────────────────────────────┘     │
│                          │                                   │
│                    SQL Queries                               │
│                          │                                   │
└──────────────────────────┼───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                      MariaDB                                 │
│  ┌────────────────────────────────────────────────────┐     │
│  │  Tables: seasons, circuits, races, drivers,        │     │
│  │          teams, race_results, race_images          │     │
│  └────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Technology Stack Details

### Frontend (Client)
- **React 19.2** - UI library with hooks
- **Vite 7.2** - Fast build tool and dev server
- **Axios 1.6** - Promise-based HTTP client
- **CSS3** - Styling without frameworks for simplicity

#### Key Frontend Components:
- `RacesList.jsx` - Displays all F1 races in a grid
- `api.js` - Centralized API service layer
- Future: Individual race details, charts, and images

### Backend (Server)
- **Node.js 18+** - JavaScript runtime
- **Express 4.18** - Web framework
- **MariaDB driver 3.2** - Database connectivity
- **dotenv 16.3** - Environment configuration
- **CORS** - Cross-origin resource sharing

#### API Structure:
```
/api/health          - Health check endpoint
/api/races           - Race endpoints
  GET /              - List all races
  GET /:id           - Get race by ID
  GET /:id/results   - Get race results
```

### Database (MariaDB)
- **MariaDB 10.6+** - Relational database
- **Connection pooling** - Optimized for concurrent requests

#### Database Schema:
- **seasons** - F1 seasons (year)
- **circuits** - Racing circuits (name, location, country)
- **races** - Race events (links to season and circuit)
- **drivers** - F1 drivers (name, number, nationality)
- **teams** - F1 teams (name, nationality)
- **race_results** - Race results (position, points, time)
- **race_images** - Images for each race

## Data Flow

### Reading Race Data (Example)

1. **User visits the application**
   - Browser loads React app from Vite dev server

2. **React component mounts**
   - `RacesList.jsx` component calls `useEffect`
   - Invokes `racesAPI.getAllRaces()` from `api.js`

3. **API request sent**
   - Axios sends GET request to `http://localhost:5000/api/races`

4. **Backend receives request**
   - Express router matches `/api/races`
   - Routes to handler in `routes/races.js`

5. **Database query**
   - Handler gets connection from pool
   - Executes SQL JOIN query across races, seasons, circuits
   - Returns results

6. **Response sent**
   - Express sends JSON response to client
   - Includes race data with circuit and season info

7. **React updates UI**
   - Component receives data
   - Updates state with `setRaces()`
   - Re-renders to display race cards

## Security Considerations

1. **Environment Variables**
   - Sensitive data (DB credentials) stored in `.env` files
   - `.env` files are gitignored
   - `.env.example` files provided as templates

2. **CORS**
   - Configured to allow frontend-backend communication
   - Should be restricted in production

3. **SQL Injection Prevention**
   - Using parameterized queries with MariaDB driver
   - All user inputs are properly escaped

4. **Connection Pooling**
   - Prevents database connection exhaustion
   - Limits concurrent connections

## Scalability

### Current Design:
- Single server instance
- Connection pooling for database
- Suitable for local/small deployments

### Future Improvements:
- Add caching layer (Redis)
- Load balancing for multiple server instances
- CDN for static assets
- Database read replicas
- Containerization with Docker (already configured)

## Development Workflow

1. **Local Development**
   ```
   Terminal 1: cd server && npm run dev    (Port 5000)
   Terminal 2: cd client && npm run dev    (Port 5173)
   ```

2. **Docker Development**
   ```
   docker-compose up -d
   ```

3. **Production Build**
   ```
   cd client && npm run build    (Creates dist/)
   cd server && npm start        (Production mode)
   ```

## File Structure Explained

### Client Directory
```
client/
├── src/
│   ├── components/      # Reusable UI components
│   ├── pages/          # Page-level components (future)
│   ├── services/       # API and external service calls
│   ├── styles/         # Global styles (future)
│   ├── utils/          # Helper functions (future)
│   ├── App.jsx         # Main application component
│   └── main.jsx        # Application entry point
├── public/             # Static assets (images, fonts)
└── Dockerfile          # Container build instructions
```

### Server Directory
```
server/
├── config/            # Configuration files
│   └── database.js    # Database connection setup
├── controllers/       # Business logic (future)
├── routes/            # API endpoint definitions
│   └── races.js       # Race-related endpoints
├── models/            # Data models (future)
├── middleware/        # Custom middleware (future)
├── database/          # Database scripts
│   ├── schema.sql     # Table definitions
│   └── seed.sql       # Sample data
└── server.js          # Application entry point
```

## Extension Points

The architecture is designed to be easily extended:

1. **New API Endpoints**: Add files in `server/routes/`
2. **New Components**: Add files in `client/src/components/`
3. **New Database Tables**: Update `server/database/schema.sql`
4. **Middleware**: Add to `server/middleware/`
5. **Authentication**: Can be added as middleware
6. **Real-time Updates**: WebSocket support can be added

## Testing Strategy (Future)

### Frontend
- Jest for unit tests
- React Testing Library for component tests
- Cypress/Playwright for E2E tests

### Backend
- Jest/Mocha for unit tests
- Supertest for API integration tests
- Database testing with test database

### Database
- Migration testing
- Query performance testing
