# Data Loader Project - Exam Assignment
# **Solution For Kodkod students**


## Description

This project implements a simple FastAPI-based service that connects to a MySQL database, fetches data from a table named `data`, and returns it to the user via a publicly exposed endpoint.

The entire architecture runs on the OpenShift platform and is managed through YAML configuration files and scripts.

## Technologies Used

*   **Backend:** FastAPI, Python
*   **Database:** MySQL
*   **Platform:** OpenShift / Kubernetes
*   **Containerization:** Docker

## How to Run

1.  **Prerequisites:**
    *   An active connection to an OpenShift Cluster (`oc login`).
    *   Logged into Docker Hub via the CLI (`docker login`).
    *   Update the Docker Hub username placeholder in the `scripts/commands.bat` file.

2.  **Execution:**
    *   Run the `scripts/commands.bat` script from the project's root directory.
    *   The script will perform all necessary actions automatically:
        1.  Create a new project in OpenShift.
        2.  Build the application's Docker image and push it to Docker Hub.
        3.  Deploy all components (database, secrets, backend) to the cluster.
        4.  Initialize the database by creating the table and inserting initial data.
        5.  Expose the service externally using an OpenShift Route.

3.  **Verification:**
    *   Upon completion, the script will print the public URL of the Route.
    *   Access this URL with the `/data` path (e.g., `http://my-route-url/data`) in a browser or using tools like cURL/Postman to see the data in JSON format.