# Backend with FastAPI Docker Setup Guide

This guide walks you through setting up a FastAPI project with PostgreSQL using Docker and integrating Alembic for database migrations.

## Prerequisites

- Docker installed on your machine
- Python and pip installed

## Step 1: Init and Setup Project

Run the following commands in your terminal:

```bash
$ docker-compose up -d
$ docker-compose down
```

## Step 2: Start PostgreSQL Docker Container
```bash
$ pip install fastapi[all]
$ pip install sqlalchemy psycopg2
```

## Step 3: Start FastAPI Server
```bash
$ uvicorn app.main:app --host localhost --port 8000 --reload
```

Make a GET request to http://localhost:8000/api/healthchecker in Postman or any API testing tool to verify the response:
```bash
{
    "message": "Hello World!"
}
```
## Step 4: Access PostgreSQL Docker Container Shell
```bash
$ docker exec -it <container name> bash
```

Access the running Postgres database with the command:
```bash
$ psql -U admin <database name>
```

## Step 5: Install uuid-ossp Plugin
Execute the following SQL command to display and install the uuid-ossp extension:
```bash
select * from pg_available_extensions;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

## Step 6: Initialize Alembic for Database Migrations
Execute the following SQL command to display and install the uuid-ossp extension:
```bash
$ pip install alembic
$ alembic init alembic
```

## Step 7: Create a Revision File for Database Changes
```bash
$ alembic revision --autogenerate -m "create users table"
```

## Step 8: Apply Database Changes
```bash
$ alembic upgrade head
```

## Step 9: View Documentation
FastAPI automatically generates API documentation complying with OpenAPI standards.
```bash
Visit http://localhost:8000/docs to explore the API documentation.
```