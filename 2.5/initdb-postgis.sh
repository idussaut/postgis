#!/bin/sh
set -e

# Perform all actions as user $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Add postgis and topology extensions.
echo "Loading PostGIS extensions into $PGDATABASE"
psql --dbname="$PGDATABASE" <<-'EOSQL'
  CREATE EXTENSION IF NOT EXISTS postgis;
  CREATE EXTENSION IF NOT EXISTS postgis_topology;
EOSQL
