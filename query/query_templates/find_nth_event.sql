-- NOTE: Find the second order customer placed each month and check if it is higher or lower than the first order that month

WITH monthly_orders AS
  (SELECT o_custkey,
          strftime(o_orderdate, '%Y-%m') AS order_month,
          o_orderdate,
          o_totalprice,
          rank() over(PARTITION BY strftime(o_orderdate, '%Y-%m'), o_custkey
                      ORDER BY o_orderdate) AS rnk
   FROM orders),
     compared_orders AS
  (SELECT *,
          LAG(o_totalprice) OVER(PARTITION BY order_month, o_custkey
                                 ORDER BY rnk) AS prev_totalprice_this_month,
   FROM monthly_orders
   WHERE rnk <=2
   ORDER BY o_custkey,
            order_month,
            rnk)
SELECT * ,
       o_totalprice - prev_totalprice_this_month AS diff_in_totalprice
FROM compared_orders
WHERE prev_totalprice_this_month IS NOT NULL
LIMIT 50;
