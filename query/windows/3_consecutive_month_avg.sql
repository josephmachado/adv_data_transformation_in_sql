-- NOTE: Find the 3 month running average for month m and user u, note that this should only include consecutive months.

SELECT order_month,
       o_custkey,
       total_price,
       ROUND(AVG(total_price) OVER(PARTITION BY o_custkey
                                   ORDER BY cast(order_month AS DATE) RANGE BETWEEN INTERVAL '1' MONTH PRECEDING AND INTERVAL '1' MONTH FOLLOWING), 2) AS consecutive_three_mo_total_price_avg,
       ROUND(AVG(total_price) OVER(PARTITION BY o_custkey
                                   ORDER BY order_month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS three_mo_total_price_avg
FROM
  (SELECT strftime(o_orderdate, '%Y-%m-01') AS order_month,
          o_custkey,
          SUM(o_totalprice) AS total_price
   FROM orders
   GROUP BY 1,
            2)
ORDER BY o_custkey,
         order_month
LIMIT 50;
