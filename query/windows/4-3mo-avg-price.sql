
-- * Write a query on the `orders` table that has the following output:
-- 	1. o_custkey
-- 	2. order_month: In YYYY-MM format, use `strftime(o_orderdate, '%Y-%m') AS order_month` 
-- 	3. total_price: Sum of o_totalprice for that month
-- 	4. three_mo_total_price_avg: The 3 month (previous, current & next) average of total_price for that customer

SELECT order_month,
       o_custkey,
       total_price,
       ROUND(AVG(total_price) OVER(PARTITION BY o_custkey
                                   ORDER BY order_month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS three_mo_total_price_avg
FROM
  (SELECT strftime(o_orderdate, '%Y-%m') AS order_month,
          o_custkey,
          SUM(o_totalprice) AS total_price
   FROM orders
   GROUP BY 1,
            2)
LIMIT 50;
