WITH customer AS (

  SELECT * 
  
  FROM {{ source('samples.tpch', 'customer') }}

),

orders AS (

  SELECT * 
  
  FROM {{ source('samples.tpch', 'orders') }}

),

customer_orders AS (

  SELECT 
    customer.c_name AS c_name,
    orders.o_orderstatus AS o_orderstatus,
    orders.o_totalprice AS o_totalprice,
    orders.o_orderdate AS o_orderdate,
    orders.o_orderkey AS o_orderkey
  
  FROM customer
  INNER JOIN orders
     ON customer.c_custkey = orders.o_custkey

),

Aggregate_1 AS (

  SELECT 
    any_value(o_totalprice) AS o_totalprice,
    first_value(o_orderdate) AS o_orderdate,
    count(o_orderkey) AS o_orderkey,
    any_value(c_name) AS c_name
  
  FROM customer_orders AS in0
  
  GROUP BY c_name

)

SELECT *

FROM Aggregate_1
