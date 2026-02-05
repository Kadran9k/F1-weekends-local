# Database Setup Guide

## Initial Setup

### 1. Install MariaDB

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

**macOS (using Homebrew):**
```bash
brew install mariadb
brew services start mariadb
```

**Windows:**
Download and install from [MariaDB Downloads](https://mariadb.org/download/)

### 2. Secure MariaDB Installation

```bash
sudo mysql_secure_installation
```

Follow the prompts to:
- Set root password
- Remove anonymous users
- Disallow root login remotely
- Remove test database
- Reload privilege tables

### 3. Create Database and User

Login to MariaDB:
```bash
mysql -u root -p
```

Run these commands:
```sql
-- Create database
CREATE DATABASE f1_weekends;

-- Create user
CREATE USER 'f1user'@'localhost' IDENTIFIED BY 'your_secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON f1_weekends.* TO 'f1user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- Exit
EXIT;
```

### 4. Import Schema

```bash
mysql -u f1user -p f1_weekends < server/database/schema.sql
```

### 5. (Optional) Load Sample Data

```bash
mysql -u f1user -p f1_weekends < server/database/seed.sql
```

## Verify Installation

Test the database connection:
```bash
mysql -u f1user -p f1_weekends
```

Run a test query:
```sql
SHOW TABLES;
SELECT * FROM seasons;
```

## Troubleshooting

### Can't connect to database

1. Check if MariaDB is running:
   ```bash
   sudo systemctl status mariadb
   ```

2. Verify user privileges:
   ```sql
   SHOW GRANTS FOR 'f1user'@'localhost';
   ```

3. Check the `.env` file has correct credentials

### Reset Database

To start fresh:
```bash
mysql -u root -p
```

```sql
DROP DATABASE f1_weekends;
CREATE DATABASE f1_weekends;
```

Then re-import the schema and seed data.

## Backup and Restore

### Backup
```bash
mysqldump -u f1user -p f1_weekends > backup.sql
```

### Restore
```bash
mysql -u f1user -p f1_weekends < backup.sql
```
