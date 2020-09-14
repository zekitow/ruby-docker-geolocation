#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ruby_geolocation WITH ENCRYPTED PASSWORD 'secret';
    CREATE DATABASE ruby_geolocation_development;
    CREATE DATABASE ruby_geolocation_test;
    GRANT ALL PRIVILEGES ON DATABASE ruby_geolocation_development TO ruby_geolocation;
    GRANT ALL PRIVILEGES ON DATABASE ruby_geolocation_test TO ruby_geolocation;
EOSQL