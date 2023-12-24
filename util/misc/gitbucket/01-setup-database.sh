#!/bin/bash

# Set the PostgreSQL credentials and database name
DB_NAME="gitbucket"
DB_USER="gitbucket_user"
DB_PASSWORD="password"

# PostgreSQL connection parameters
PG_HOST="127.0.0.1"
PG_PORT="5432"
PG_USER="postgres"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -c "CREATE DATABASE $DB_NAME;"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $DB_NAME -c "CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $DB_NAME -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $DB_NAME -c "GRANT CONNECT ON DATABASE $DB_NAME TO $DB_USER;"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $DB_NAME -c "GRANT CREATE ON SCHEMA public TO $DB_USER;"