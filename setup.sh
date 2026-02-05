#!/bin/bash

# F1 Weekends Local - Development Setup Script

echo "🏎️  F1 Weekends Local - Development Setup"
echo "=========================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v18 or higher."
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo ""

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm."
    exit 1
fi

echo "✅ npm version: $(npm --version)"
echo ""

# Install client dependencies
echo "📦 Installing client dependencies..."
cd client
npm install
if [ $? -eq 0 ]; then
    echo "✅ Client dependencies installed successfully"
else
    echo "❌ Failed to install client dependencies"
    exit 1
fi
cd ..
echo ""

# Install server dependencies
echo "📦 Installing server dependencies..."
cd server
npm install
if [ $? -eq 0 ]; then
    echo "✅ Server dependencies installed successfully"
else
    echo "❌ Failed to install server dependencies"
    exit 1
fi
cd ..
echo ""

# Create .env files if they don't exist
echo "🔧 Setting up environment files..."

if [ ! -f "server/.env" ]; then
    cp server/.env.example server/.env
    echo "✅ Created server/.env from example"
    echo "⚠️  Please edit server/.env with your database credentials"
else
    echo "ℹ️  server/.env already exists"
fi

if [ ! -f "client/.env" ]; then
    cp client/.env.example client/.env
    echo "✅ Created client/.env from example"
else
    echo "ℹ️  client/.env already exists"
fi
echo ""

# Check if MariaDB is available
echo "🗄️  Checking MariaDB connection..."
if command -v mysql &> /dev/null; then
    echo "✅ MySQL/MariaDB client is installed"
    echo "ℹ️  You can import the database schema using:"
    echo "   mysql -u f1user -p f1_weekends < server/database/schema.sql"
else
    echo "⚠️  MySQL/MariaDB client not found. Please install MariaDB to use the database."
fi
echo ""

echo "=========================================="
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit server/.env with your database credentials"
echo "2. Create the database and import the schema"
echo "3. Run 'cd server && npm run dev' to start the backend"
echo "4. Run 'cd client && npm run dev' to start the frontend"
echo ""
echo "Or use Docker:"
echo "  docker-compose up -d"
echo ""
echo "Happy coding! 🏁"
