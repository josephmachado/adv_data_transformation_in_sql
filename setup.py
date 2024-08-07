
import duckdb
import os
from pathlib import Path

print('Remove existing tpch.db file')
# Get the current working directory
cwd = Path(__file__).resolve().parent

db_path = str(cwd / 'tpch.db')
# Remove the file if it exists
if os.path.exists(db_path):
    os.remove(db_path)
# Connect to the DuckDB database file
print('Establishing connection to tpch.db db file')
con = duckdb.connect(database=db_path)


# Read the create_tables.sql script
print('Reading in the table creation script')
with open(str(cwd / 'create_tables.sql'), 'r') as file:
    create_tables_sql = file.read()

print('Executing table creation')
# Execute the SQL script to create tables
con.execute(create_tables_sql)

print('Committing and closing connection')
con.commit()
con.close()

print('Setup Done!!!')
