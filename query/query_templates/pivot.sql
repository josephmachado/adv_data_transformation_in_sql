-- Create a pivot of order_month as rows, o_orderpriority as columns, and o_totalprice as value

SELECT strftime(o_orderdate, '%Y-%m') AS ordermonth,
       ROUND(AVG(CASE
                     WHEN o_orderpriority = '1-URGENT' THEN o_totalprice
                     ELSE NULL
                 END), 2) AS urgent_order_avg_price,
       ROUND(AVG(CASE
                     WHEN o_orderpriority = '2-HIGH' THEN o_totalprice
                     ELSE NULL
                 END), 2) AS high_order_avg_price,
       ROUND(AVG(CASE
                     WHEN o_orderpriority = '3-MEDIUM' THEN o_totalprice
                     ELSE NULL
                 END), 2) AS medium_order_avg_price,
       ROUND(AVG(CASE
                     WHEN o_orderpriority = '4-NOT SPECIFIED' THEN o_totalprice
                     ELSE NULL
                 END), 2) AS not_specified_order_avg_price,
       ROUND(AVG(CASE
                     WHEN o_orderpriority = '5-LOW' THEN o_totalprice
                     ELSE NULL
                 END), 2) AS low_order_avg_price
FROM orders
GROUP BY strftime(o_orderdate, '%Y-%m');

-- Using DuckDBs PIVOT function
PIVOT
  (SELECT *,
          strftime(o_orderdate, '%Y-%m') AS order_month
   FROM orders) ON o_orderpriority USING AVG(o_totalprice)
GROUP BY order_month
LIMIT 10;
