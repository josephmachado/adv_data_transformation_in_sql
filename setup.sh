#!/bin/bash

rm -f duckd*
rm -f tpch.db

# Download duckdb
wget https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip
unzip duckdb_cli-linux-amd64.zip

# setup duckdb and tpch tables
./duckdb tpch.db < "create_tables.sql"

