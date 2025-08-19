import os

# Read environment variables for the database connection
# Default values are provided for local development if needed
DB_HOST = os.getenv("DB_HOST", "mysql")
DB_USER = os.getenv("DB_USER", "user")
DB_PASSWORD = os.getenv("DB_PASSWORD", "password")
DB_NAME = os.getenv("DB_NAME", "mydatabase")
COLUMNS_TO_SELECT = ["ID", "first_name", "last_name"]
TABLE_NAME = "data"
