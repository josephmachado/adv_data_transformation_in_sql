
* [Advanced Data Transformation in SQL Workshop](#advanced-data-transformation-in-sql-workshop)
    * [Prerequisites](#prerequisites)
    * [Setup](#setup)
    * [Data Model](#data-model)
    * [Run SQL Scripts](#run-sql-scripts)

# Advanced Data Transformation in SQL Workshop

## Prerequisites

1. Go through [SQL Cheatsheet](./sql_cheatsheet.pdf)

## Setup

1. Create [Github codespaces with this link](https://github.com/codespaces/new?skip_quickstart=true&machine=basicLinux32gb&repo=833339774&ref=main&geo=UsEast).
2. Run `./setup.sh` in the terminal.
3. Open duckdb sql ide with `./duckdb tpch.db`.

Now you can run queries as shown below:

```sql
select * from customer limit 4;
.exit
```

## Data Model

The TPC-H data represents a car parts seller’s data warehouse, where we record orders, items that make up that order (lineitem), supplier, customer, part (parts sold), region, nation, and partsupp (parts supplier). 

Note: Have a copy of the data model as you follow along; this will help in understanding the examples provided and in answering exercise questions.

![](./tpch_erd.png)

## Run SQL Scripts

You can run the SQL scripts in the [./query](./query) folder. See the example below:

```bash
./duckdb tpch.db < ./query/windows/top_3_monthly_customers.sql
```
