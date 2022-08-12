-- Deploy sqitch-variables:database to pg

\set ON_ERROR_STOP 1
\set db_name db_:deployment

-- Create a boolean for use in \if
-- https://www.postgresql.org/message-id/CAOBaU_ZeHj6FWJQiOMOKoxoe7DXLshoaCoLL0w1b3hpg%2B%2BVJRQ%40mail.gmail.com
SELECT :'deployment' = 'development' AS is_development \gset
\if :is_development
    create database :db_name;
\endif



