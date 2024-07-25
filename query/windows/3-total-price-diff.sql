
-- * Write a SQL query using the `orders` table that calculates the following columns:
-- 	1. o_orderdate
-- 	2. o_custkey
-- 	3. o_totalprice
-- 	4. totalprice_diff: The customers current day's o_totalprice - that same customers most recent previous purchase's o_totalprice

SELECT o_orderdate,
       o_custkey,
       o_totalprice,
       o_totalprice - lag(o_totalprice) over(PARTITION BY o_custkey
                                             ORDER BY o_orderdate) AS totalprice_diff
FROM orders
ORDER BY o_custkey,
         o_orderdate
LIMIT 50;
