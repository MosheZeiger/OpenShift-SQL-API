from fastapi import FastAPI, Depends
from dal import DataLoader

app = FastAPI()

# Dependency function to create and clean up a DataLoader instance per request
def get_dal():
    """
    Dependency injector that provides a DataLoader instance and ensures
    the database connection is closed after the request is complete.
    """
    dal = DataLoader()
    try:
        yield dal
    finally:
        dal.close_connection()

@app.get("/")
def read_root():
    """Root endpoint for health checks or basic info."""
    return {"message": "Data Loader service is running. Use /data to get information."}

@app.get("/data")
def get_data(dal: DataLoader = Depends(get_dal)):
    """
    Endpoint that returns all information from the 'data' table.
    It uses the get_dal dependency to interact with the database.
    """
    data = dal.get_all_data()
    return data