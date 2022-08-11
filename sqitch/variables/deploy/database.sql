-- Deploy sqitch-variables:database to pg
\set db_name db_:deployment

-- https://stackoverflow.com/questions/18389124/simulate-create-database-if-not-exists-for-postgresql
SELECT format('create database %I', :'db_name')
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = :'db_name'
)\gexec

