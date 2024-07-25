-- use * to specify all columns
SELECT * FROM orders limit 5;

-- use column c_names only to read data from those columns
SELECT o_orderkey, o_totalprice FROM orders LIMIT 5;

-- all customer rows that have c_nationkey = 20
SELECT * FROM customer WHERE c_nationkey = 20 LIMIT 10;

-- all customer rows that have c_nationkey = 20 and c_acctbal > 1000
SELECT * FROM customer 
WHERE c_nationkey = 20 AND c_acctbal > 1000 LIMIT 10;

-- all customer rows that have c_nationkey = 20 or c_acctbal > 1000
SELECT * FROM customer 
WHERE c_nationkey = 20 OR c_acctbal > 1000 LIMIT 10;

-- all customer rows that have (c_nationkey = 20 and c_acctbal > 1000) or rows that have c_nationkey = 11
SELECT * FROM customer 
WHERE (c_nationkey = 20 AND c_acctbal > 1000) 
OR c_nationkey = 11 LIMIT 10;

-- all customer rows where the c_name has a 381 in it
SELECT * FROM customer WHERE c_name LIKE '%381%';

-- all customer rows where the c_name ends with a 381
SELECT * FROM customer WHERE c_name LIKE '%381';

-- all customer rows where the c_name starts with a 381
SELECT * FROM customer WHERE c_name LIKE '381%';

-- all customer rows where the c_name has a combination of any character and 9 and 1
SELECT * FROM customer WHERE c_name LIKE '%_91%';

-- all customer rows which have c_nationkey = 10 or c_nationkey = 20
SELECT * FROM customer WHERE c_nationkey IN (10,20);

-- all customer rows which have do not have c_nationkey as 10 or 20
SELECT * FROM customer WHERE c_nationkey NOT IN (10,20);

SELECT COUNT(*) FROM customer; 
SELECT COUNT(*) FROM lineitem;

-- Will show the first ten customer records with the lowest custkey
-- rows are ordered in ASC order by default
SELECT * FROM orders ORDER BY o_custkey LIMIT 10; 

-- Will show the first ten customer's records with the highest custkey
SELECT * FROM orders ORDER BY o_custkey DESC LIMIT 10; 

-- not based on real tables
SELECT
    a.*
FROM
    table_a a -- LEFT table a
    JOIN table_b b -- RIGHT table b
    ON a.id = b.id

SELECT
    o.o_orderkey,
    l.l_orderkey
FROM
    orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY
LIMIT
    100;

SELECT
    COUNT(o.o_orderkey) AS order_rows_count,
    COUNT(l.l_orderkey) AS lineitem_rows_count
FROM
    orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY;

SELECT
    o.o_orderkey,
    l.l_orderkey
FROM
    orders o
    LEFT JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY
LIMIT
    100;

SELECT
    COUNT(o.o_orderkey) AS order_rows_count,
    COUNT(l.l_orderkey) AS lineitem_rows_count
FROM
    orders o
    LEFT JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY;

SELECT
    o.o_orderkey,
    l.l_orderkey
FROM
    orders o
    LEFT JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY
LIMIT
    100;

SELECT
    COUNT(o.o_orderkey) AS order_rows_count,
    COUNT(l.l_orderkey) AS lineitem_rows_count
FROM
    orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY;

SELECT
    o.o_orderkey,
    l.l_orderkey
FROM
    orders o
    LEFT JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY
LIMIT
    100;

SELECT
    COUNT(o.o_orderkey) AS order_rows_count,
    COUNT(l.l_orderkey) AS lineitem_rows_count
FROM
    orders o
    FULL OUTER JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    AND o.o_orderdate BETWEEN l.l_shipdate - INTERVAL '5' DAY
    AND l.l_shipdate + INTERVAL '5' DAY;

SELECT
    n.n_name AS nation_c_name,
    r.r_name AS region_c_name
FROM
    nation n
    CROSS JOIN region r;

SELECT
    o1.o_custkey
FROM
    orders o1
    JOIN orders o2 ON o1.o_custkey = o2.o_custkey
    AND year(o1.o_orderdate) = year(o2.o_orderdate)
    AND week(o1.o_orderdate) = week(o2.o_orderdate)
WHERE
    o1.o_orderkey != o2.o_orderkey;

SELECT
    o_orderpriority,
    count(*) AS num_orders
FROM
    orders
GROUP BY
    o_orderpriority;

SELECT
    n.n_name AS nation_c_name,
    s.quantity AS supplied_items_quantity,
    c.quantity AS purchased_items_quantity
FROM
    nation n
    LEFT JOIN (
        SELECT
            n.n_nationkey,
            sum(l.l_quantity) AS quantity
        FROM
            lineitem l
            JOIN supplier s ON l.l_suppkey = s.s_suppkey
            JOIN nation n ON s.s_nationkey = n.n_nationkey
        GROUP BY
            n.n_nationkey
    ) s ON n.n_nationkey = s.n_nationkey
    LEFT JOIN (
        SELECT
            n.n_nationkey,
            sum(l.l_quantity) AS quantity
        FROM
            lineitem l
            JOIN orders o ON l.l_orderkey = o.o_orderkey
            JOIN customer c ON o.o_custkey = c.c_custkey
            JOIN nation n ON c.c_nationkey = n.n_nationkey
        GROUP BY
            n.n_nationkey
    ) c ON n.n_nationkey = c.n_nationkey;

SELECT
    o_orderkey,
    o_totalprice,
    CASE
        WHEN o_totalprice > 100000 THEN 'high'
        WHEN o_totalprice BETWEEN 25000
        AND 100000 THEN 'medium'
        ELSE 'low'
    END AS order_price_bucket
FROM
    orders;
