#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ruby_geolocation WITH ENCRYPTED PASSWORD 'secret';
    CREATE DATABASE ruby_geolocation_$RACK_ENV;
    GRANT ALL PRIVILEGES ON DATABASE ruby_geolocation_$RACK_ENV TO ruby_geolocation;
EOSQL