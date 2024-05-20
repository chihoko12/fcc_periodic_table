psql --username=freecodecamp --dbname=periodic_table
pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
psql -U postgres < periodic_table.sql
