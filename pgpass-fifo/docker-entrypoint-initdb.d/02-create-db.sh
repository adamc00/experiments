#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE ROLE example WITH LOGIN PASSWORD 'password';
	CREATE DATABASE example;
	GRANT ALL PRIVILEGES ON DATABASE example TO example IDENTIFIED BY ";
EOSQL