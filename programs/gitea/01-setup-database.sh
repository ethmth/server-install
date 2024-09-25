#!/bin/bash

# PostgreSQL connection parameters
PG_HOST="127.0.0.1"
PG_PORT="5432"
PG_USER="postgres"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -c "CREATE ROLE gitea WITH LOGIN PASSWORD 'gitea';"

psql -h $PG_HOST -p $PG_PORT -U $PG_USER -c "CREATE DATABASE giteadb WITH OWNER gitea TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';"