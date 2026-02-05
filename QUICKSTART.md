# Quick Start Guide

## Prerequisites Check

```bash
node --version   # Should be v18 or higher
npm --version    # Should be v9 or higher
mysql --version  # Should show MariaDB 10.6 or higher
```

## Installation (3 minutes)

### Option 1: Automated Setup (Recommended)

```bash
# Clone and setup
git clone https://github.com/Kadran9k/F1-weekends-local.git
cd F1-weekends-local
chmod +x setup.sh
./setup.sh
```

### Option 2: Manual Setup

```bash
# 1. Install dependencies
npm run install:all

# 2. Create environment files
cd server
cp .env.example .env
# Edit .env with your database credentials

cd ../client
cp .env.example .env
# Edit if needed (defaults work for local development)

# 3. Setup database
mysql -u root -p
```

```sql
CREATE DATABASE f1_weekends;
CREATE USER 'f1user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON f1_weekends.* TO 'f1user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

```bash
# Import schema and sample data
mysql -u f1user -p f1_weekends < server/database/schema.sql
mysql -u f1user -p f1_weekends < server/database/seed.sql
```

## Running the Application

### Development Mode

**Option 1: Two Terminals**
```bash
# Terminal 1 - Backend
cd server
npm run dev

# Terminal 2 - Frontend
cd client
npm run dev
```

**Option 2: Docker**
```bash
docker-compose up -d
```

### Access the Application

- Frontend: http://localhost:5173
- Backend API: http://localhost:5000
- Health Check: http://localhost:5000/api/health

## Common Commands

### Development
```bash
# Install all dependencies
npm run install:all

# Start frontend dev server
npm run dev:client

# Start backend dev server
npm run dev:server

# Build frontend for production
npm run build:client

# Start backend in production
npm run start:server
```

### Docker
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild after changes
docker-compose up -d --build
```

### Database
```bash
# Connect to database
mysql -u f1user -p f1_weekends

# Export database
mysqldump -u f1user -p f1_weekends > backup.sql

# Import database
mysql -u f1user -p f1_weekends < backup.sql

# Reset database
mysql -u f1user -p f1_weekends < server/database/schema.sql
mysql -u f1user -p f1_weekends < server/database/seed.sql
```

## Project Structure Overview

```
F1-weekends-local/
├── client/          Frontend React application
├── server/          Backend Node.js API
├── *.md            Documentation files
└── setup.sh        Automated setup script
```

## API Endpoints

```
GET  /api/health              Check server status
GET  /api/races               List all races
GET  /api/races/:id           Get race details
GET  /api/races/:id/results   Get race results
```

## Troubleshooting

### Frontend won't start
```bash
cd client
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### Backend won't start
```bash
cd server
rm -rf node_modules package-lock.json
npm install
# Check .env file has correct database credentials
npm run dev
```

### Database connection fails
1. Check MariaDB is running: `sudo systemctl status mariadb`
2. Verify credentials in `server/.env`
3. Test connection: `mysql -u f1user -p f1_weekends`

### Port already in use
```bash
# Frontend (default 5173)
# Check what's using the port
lsof -i :5173
# Kill the process or change port in vite.config.js

# Backend (default 5000)
lsof -i :5000
# Kill the process or change PORT in server/.env
```

## Next Steps

1. **Explore the code**
   - `client/src/components/RacesList.jsx` - Main component
   - `server/routes/races.js` - API endpoints
   - `server/database/schema.sql` - Database structure

2. **Add features**
   - Create new components
   - Add new API endpoints
   - Extend database schema

3. **Read documentation**
   - `README.md` - Full documentation
   - `ARCHITECTURE.md` - System design
   - `DATABASE.md` - Database setup guide
   - `CONTRIBUTING.md` - Contribution guidelines

## Getting Help

- Check documentation files
- Review code comments
- Open an issue on GitHub
- Read error messages carefully (they usually tell you what's wrong)

## Useful Resources

- React: https://react.dev
- Vite: https://vitejs.dev
- Express: https://expressjs.com
- MariaDB: https://mariadb.org/documentation
- Node.js: https://nodejs.org/docs
