import os
import duckdb
import sqlite3


def clean_up(file):
    # Remove the file if it exists
    if os.path.exists(file):
        os.remove(file)
    else:
        print(f"The file {file} does not exist.")


def create_tpch_data(data_size=0.01):
    con = duckdb.connect(
        "tpch.db"
    )  # Define a .db file to persist the generated tpch data
    con.sql(
        f"INSTALL tpch;LOAD tpch;CALL dbgen(sf = {data_size});"
    )  # generate a 100MB TPCH dataset
    con.commit()
    con.close()  # close connection, since duckdb only allows one connection to tpch.db


if __name__ == "__main__":
    print("Cleaning up (if any existing) tpch db file")
    clean_up("tpch.db")
    print("Creating TPCH input data")
    create_tpch_data()