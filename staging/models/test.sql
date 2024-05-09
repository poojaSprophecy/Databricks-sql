WITH customer AS (

  SELECT * 
  
  FROM {{ source('samples.tpch', 'customer') }}

),

orders AS (

  SELECT * 
  
  FROM {{ source('samples.tpch', 'orders') }}

),

customer_order_details AS (

  SELECT 
    in0.c_custkey AS c_custkey,
    in0.c_name AS name,
    in0.c_address AS address,
    in1.o_orderkey AS orderkey,
    in1.o_orderstatus AS orderstatus,
    in1.o_totalprice AS totalprice,
    in1.o_orderdate AS orderdate
  
  FROM customer AS in0
  INNER JOIN orders AS in1
     ON in0.c_custkey = in1.o_custkey

),

customer_summary AS (

  SELECT 
    any_value(name) AS name,
    any_value(address) AS address,
    COUNT(orderkey) AS total_orders,
    SUM(totalprice) AS total_price,
    DATEDIFF(CURRENT_DATE(), MAX(orderdate)) AS days_since_last_order
  
  FROM customer_order_details AS in0
  
  GROUP BY c_custkey

)

SELECT *

FROM customer_summary
