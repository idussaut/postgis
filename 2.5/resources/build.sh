#!/usr/bin/env bash

set -eux

apt-get update 
# Required dependencies
apt-get install -y --no-install-recommends \
  build-essential \
  docbook-xsl \
  docbook-mathml \
  libgdal-dev \
  libjson-c-dev \
  libproj-dev \
  libxml2-dev \
  make \
  wget \
  xsltproc

# Installing PostgreSQL Server Development tools since is required by PostGIS
apt-get install -y --no-install-recommends postgresql-server-dev-$PG_MAJOR

# PostGIS
cd /usr/src/postgis

echo "${POSTGIS_SHA256}" *postgis-${POSTGIS_VERSION}.tar.gz | sha256sum -c -

tar --extract --file postgis-${POSTGIS_VERSION}.tar.gz --gzip --strip-components 1 --verbose 
rm postgis-${POSTGIS_VERSION}.tar.gz
./autogen.sh 
./configure 
make 
make install
rm -fr /usr/src/postgis/*

mkdir -p /docker-entrypoint-initdb.d