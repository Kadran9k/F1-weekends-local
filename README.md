# F1 Weekends Local

Site para listar os fins de semana da Formula 1 com gráficos, dados, resultados e imagens das corridas, com integração com um banco de dados MariaDB.

## 🏎️ Tech Stack

### Frontend
- **React** - UI library
- **Vite** - Build tool and dev server
- **Axios** - HTTP client for API calls
- **CSS** - Styling

### Backend
- **Node.js** - JavaScript runtime
- **Express** - Web framework
- **MariaDB** - Database
- **dotenv** - Environment variable management

## 📁 Project Structure

```
F1-weekends-local/
├── client/                 # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page components
│   │   ├── services/      # API services
│   │   ├── styles/        # CSS files
│   │   ├── utils/         # Utility functions
│   │   ├── App.jsx        # Main App component
│   │   └── main.jsx       # Entry point
│   ├── public/            # Static assets
│   └── package.json
│
├── server/                # Backend API
│   ├── config/           # Configuration files
│   │   └── database.js   # Database connection
│   ├── controllers/      # Route controllers
│   ├── models/           # Data models
│   ├── routes/           # API routes
│   │   └── races.js      # Race routes
│   ├── middleware/       # Custom middleware
│   ├── database/         # Database files
│   │   ├── schema.sql    # Database schema
│   │   └── seed.sql      # Sample data
│   ├── server.js         # Entry point
│   └── package.json
│
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Node.js (v18 or higher)
- MariaDB (v10.6 or higher)
- npm or yarn

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Kadran9k/F1-weekends-local.git
   cd F1-weekends-local
   ```

2. **Install dependencies**
   ```bash
   # Install all dependencies (client + server)
   npm run install:all

   # Or install separately
   npm run install:client
   npm run install:server
   ```

3. **Set up the database**

   Create a MariaDB database and user:
   ```sql
   CREATE DATABASE f1_weekends;
   CREATE USER 'f1user'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON f1_weekends.* TO 'f1user'@'localhost';
   FLUSH PRIVILEGES;
   ```

   Run the schema:
   ```bash
   mysql -u f1user -p f1_weekends < server/database/schema.sql
   ```

   (Optional) Load sample data:
   ```bash
   mysql -u f1user -p f1_weekends < server/database/seed.sql
   ```

4. **Configure environment variables**

   Create `.env` files from the examples:
   
   **Server (.env in server/):**
   ```bash
   cd server
   cp .env.example .env
   ```
   
   Edit `server/.env` with your database credentials:
   ```
   PORT=5000
   NODE_ENV=development
   DB_HOST=localhost
   DB_USER=f1user
   DB_PASSWORD=your_password
   DB_NAME=f1_weekends
   ```

   **Client (.env in client/):**
   ```bash
   cd client
   cp .env.example .env
   ```
   
   Edit `client/.env` if needed (default should work for local development):
   ```
   VITE_API_URL=http://localhost:5000/api
   ```

### Running the Application

**Development Mode:**

Run both frontend and backend:

```bash
# Terminal 1 - Run the backend
cd server
npm run dev

# Terminal 2 - Run the frontend
cd client
npm run dev
```

The application will be available at:
- Frontend: http://localhost:5173
- Backend API: http://localhost:5000

**Production Build:**

```bash
# Build the frontend
npm run build:client

# Start the backend
npm run start:server
```

## 📡 API Endpoints

### Health Check
- `GET /api/health` - Check server and database status

### Races
- `GET /api/races` - Get all races
- `GET /api/races/:id` - Get race by ID
- `GET /api/races/:id/results` - Get race results

## 🗄️ Database Schema

The database includes the following tables:
- `seasons` - F1 seasons
- `circuits` - Race circuits
- `races` - Race events
- `drivers` - F1 drivers
- `teams` - F1 teams
- `race_results` - Race results and standings
- `race_images` - Images associated with races

See `server/database/schema.sql` for the complete schema.

## 🛠️ Development

### Code Structure

**Frontend:**
- Components are located in `client/src/components/`
- API calls are centralized in `client/src/services/api.js`
- Use functional components with React Hooks

**Backend:**
- Routes define API endpoints in `server/routes/`
- Database connection pool is configured in `server/config/database.js`
- All database queries use async/await with proper error handling

### Adding New Features

1. **Add new API endpoint:**
   - Create route in `server/routes/`
   - Import and use in `server/server.js`

2. **Add new component:**
   - Create component in `client/src/components/`
   - Import and use in pages or App.jsx

3. **Update database:**
   - Add migration scripts in `server/database/`
   - Update schema.sql for new installations

## 🐳 Docker Deployment

The project includes Docker configuration for easy deployment.

### Using Docker Compose

1. **Build and run all services:**
   ```bash
   docker-compose up -d
   ```

   This will start:
   - MariaDB database (port 3306)
   - Backend API (port 5000)
   - Frontend (port 80)

2. **Stop services:**
   ```bash
   docker-compose down
   ```

3. **View logs:**
   ```bash
   docker-compose logs -f
   ```

### Manual Docker Build

**Build images:**
```bash
docker build -t f1-server ./server
docker build -t f1-client ./client
```

**Run containers:**
```bash
docker run -d -p 5000:5000 f1-server
docker run -d -p 80:80 f1-client
```

## 📝 License

ISC

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

