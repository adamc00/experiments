-- Deploy sqitch-variables:database to pg
\set db_name db_:deployment

-- https://stackoverflow.com/questions/18389124/simulate-create-database-if-not-exists-for-postgresql
select format('create database %I', :'db_name')
where not exists (
    select from pg_database where datname = :'db_name'
)\gexec

