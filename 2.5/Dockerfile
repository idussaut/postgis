FROM postgres:11.4

LABEL maintainer="Ignacio Fernandez Dussaut <Ignacio.Dussaut@Cartesian.com>" \
  version="0.02" \
  os="debian:stretch-slim" \
  tools="PostgreSQL=11.4, PostGIS=2.5.2" \
  description="Based images for PostgreSQL Database with PostGIS extension"

ENV POSTGIS_MAJOR 2.5
ENV POSTGIS_VERSION 2.5.2

RUN apt-get update \
  # Required dependencies
  && apt-get install -y --no-install-recommends \
    build-essential \
    docbook-xsl \
    docbook-mathml \
    libgdal-dev \
    libjson-c-dev \ 
    libproj-dev \
    libxml2-dev \
    make \
    wget \
    xsltproc \
  && apt-get install -y --no-install-recommends postgresql-server-dev-$PG_MAJOR \
  # PostGIS
  && [ -d /usr/local/bin/postgis ] || mkdir -p /usr/local/bin/postgis \ 
  && wget -P /usr/local/bin/postgis/ "http://download.osgeo.org/postgis/source/postgis-$POSTGIS_VERSION.tar.gz" \
  && cd /usr/local/bin/postgis \
  && tar xvzf postgis-$POSTGIS_VERSION.tar.gz \
  && cd postgis-$POSTGIS_VERSION \
  && ./configure && make && make install \
  && rm -fr /usr/local/bin/postgis

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
