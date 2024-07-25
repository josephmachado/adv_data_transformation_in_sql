-- NOTE: Split reused logic into individual CTEs for reusability

WITH supplier_nation_metrics AS
  (SELECT n.n_nationkey,
          SUM(l.l_QUANTITY) AS num_supplied_parts
   FROM lineitem l
   JOIN supplier s ON l.l_suppkey = s.s_suppkey
   JOIN nation n ON s.s_nationkey = n.n_nationkey
   GROUP BY n.n_nationkey),
     buyer_nation_metrics AS
  (SELECT n.n_nationkey,
          SUM(l.l_QUANTITY) AS num_purchased_parts
   FROM lineitem l
   JOIN orders o ON l.l_orderkey = o.o_orderkey
   JOIN customer c ON o.o_custkey = c.c_custkey
   JOIN nation n ON c.c_nationkey = n.n_nationkey
   GROUP BY n.n_nationkey)
SELECT n.n_name AS nation_name,
       s.num_supplied_parts,
       b.num_purchased_parts
FROM nation n
LEFT JOIN supplier_nation_metrics s ON n.n_nationkey = s.n_nationkey
LEFT JOIN buyer_nation_metrics b ON n.n_nationkey = b.n_nationkey;
