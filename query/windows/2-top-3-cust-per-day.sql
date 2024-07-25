
-- * Let's look at a simple window function that **gets the 3 top spending customer IDs per day** (aka rank rows based on a value)

SELECT *
FROM
  (SELECT o_orderdate,
          o_totalprice,
          o_custkey,
          rank() over(PARTITION BY o_orderdate
                      ORDER BY o_totalprice DESC) AS rnk
   FROM orders)
WHERE rnk <= 3;
