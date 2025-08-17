-- Creates the 'data' table if it does not already exist.
-- This script is idempotent and can be run multiple times without causing errors.
CREATE TABLE IF NOT EXISTS data (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);