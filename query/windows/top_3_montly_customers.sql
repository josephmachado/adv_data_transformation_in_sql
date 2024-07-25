-- NOTE: Let's look at a simple window function that **gets the 3 top spending customer per month**

SELECT *
FROM
  (SELECT order_month,
          customer_id,
          revenue,
          row_number() over(PARTITION BY order_month
                            ORDER BY revenue DESC) AS row_num
   FROM
     (SELECT strftime(o_orderdate, '%Y-%m') AS order_month,
             o_custkey AS customer_id,
             SUM(o_totalprice) AS revenue
      FROM orders
      GROUP BY 1,
               2))
WHERE row_num <= 3
ORDER BY order_month,
         row_num ;
