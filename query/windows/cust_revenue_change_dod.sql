
SELECT o_orderdate,
       o_custkey,
       o_totalprice,
       o_totalprice - lag(o_totalprice) over(PARTITION BY o_custkey
                                             ORDER BY o_orderdate) AS totalprice_diff
FROM orders
ORDER BY o_custkey,
         o_orderdate
LIMIT 50;
