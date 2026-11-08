# Soldier Management Database

A PostgreSQL database for managing soldiers' records, including their personal details, ranks, and units.

## Files
- 202512523_202513073.sql: database schema
- 202512523_202513073.pgerd.png: ERD diagram

## How to run
`bash
createdb -U postgres soldier_management
psql -U postgres -d soldier_management -f 202512523_202513073.sql
