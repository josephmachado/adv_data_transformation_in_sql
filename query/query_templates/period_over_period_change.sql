-- * Exercise: Create a SQL query that gives me the following columns:
--
-- 1. ordermonth (in YYYY-MM format)
-- 2. Revenue: Sum of totalprice for that month
-- 3. revenue_MOM_change: The current month's revenue - previous month's revenue
--

SELECT order_month,
       revenue,
       revenue - lag(revenue) OVER (
                                    ORDER BY order_month) AS revenue_MOM_change,
       ROUND((revenue - lag(revenue) OVER (
                                           ORDER BY order_month)) / revenue, 2) AS perc_revenue_MOM_change
FROM
  (SELECT strftime(o_orderdate, '%Y-%m') AS order_month,
          SUM(o_totalprice) AS revenue
   FROM orders
   GROUP BY 1)
ORDER BY 1 ;

