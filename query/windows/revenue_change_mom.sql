-- NOTE: Let's consider a slightly advanced example, from the `orders` table, Calculate the revenue per month and see how much it has changed compared to the prior months.

SELECT order_month,
       revenue,
       revenue - lag(revenue) OVER (
                                    ORDER BY order_month) AS revenue_change,
       ROUND((revenue - lag(revenue) OVER (
                                           ORDER BY order_month)) / revenue, 2) AS perc_revenue_change
FROM
  (SELECT strftime(o_orderdate, '%Y-%m') AS order_month,
          SUM(o_totalprice) AS revenue
   FROM orders
   GROUP BY 1)
ORDER BY 1 ;

