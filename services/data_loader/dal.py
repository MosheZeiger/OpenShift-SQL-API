import mysql.connector
from mysql.connector import Error
import config

class DataLoader:
    """A class to handle all database interactions."""
    def __init__(self):
        """
        Initializes the connection to the database using variables from the config module.
        """
        try:
            self.connection = mysql.connector.connect(
                host=config.DB_HOST,
                user=config.DB_USER,
                password=config.DB_PASSWORD,
                database=config.DB_NAME
            )
            if self.connection.is_connected():
                print("Successfully connected to the database")
        except Error as e:
            print(f"Error while connecting to MySQL: {e}")
            self.connection = None

    def get_all_data(self):
        """
        Fetches all records from the 'data' table.
        Returns a list of dictionaries or an error message.
        """
        if not self.connection or not self.connection.is_connected():
            return {"error": "Database connection is not available"}
        
        columns_string = ",".join(config.COLUMNS_TO_SELECT)
        

        # Using a dictionary cursor to get results as key-value pairs
        cursor = self.connection.cursor(dictionary=True)
        try:
            cursor.execute(f"SELECT {columns_string} FROM {config.TABLE_NAME}")
            records = cursor.fetchall()
            return records
        except Error as e:
            print(f"Error fetching data: {e}")
            return {"error": str(e)}
        finally:
            cursor.close()

    def close_connection(self):
        """Closes the database connection if it is open."""
        if self.connection and self.connection.is_connected():
            self.connection.close()
            print("Database connection closed.")