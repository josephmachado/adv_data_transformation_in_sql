# Advanced Data Transformation in SQL Workshop (WIP)

Open in GitHub Codespaces

First setup duckdb and TPCH tables with this command on the terminal.

```bash
./setup.sh
```

Now you can open up duck db with the tpch tables as:

```bash
./duckdb tpch.db
```

```sql
select * from customer limit 4;
.exit
```

## Data Model

## Run SQL Scripts

You can run the SQL scripts in the [./query](./query) folder. See the example below:

```bash
./duckdb tpch.db < ./query/windows/top_3_monthly_customers.sql
```
