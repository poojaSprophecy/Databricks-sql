WITH prophecy_sample_orders_demo AS (

  SELECT * 
  
  FROM {{ source('main.default', 'prophecy_sample_orders_demo') }}

),

prophecy_sample_customers_demo AS (

  SELECT * 
  
  FROM {{ source('main.default', 'prophecy_sample_customers_demo') }}

),

by_customer_id AS (

  SELECT 
    prophecy_sample_orders_demo.order_id AS order_id,
    prophecy_sample_orders_demo.order_status AS order_status,
    prophecy_sample_orders_demo.order_category AS order_category,
    prophecy_sample_orders_demo.order_date AS order_date,
    prophecy_sample_orders_demo.amount AS amount,
    prophecy_sample_customers_demo.account_flags AS account_flags,
    prophecy_sample_customers_demo.country_code AS country_code,
    prophecy_sample_customers_demo.phone AS phone,
    prophecy_sample_customers_demo.account_open_date AS account_open_date,
    prophecy_sample_customers_demo.first_name AS first_name,
    prophecy_sample_customers_demo.last_name AS last_name,
    prophecy_sample_customers_demo.customer_id AS customer_id,
    prophecy_sample_customers_demo.email AS email
  
  FROM prophecy_sample_customers_demo
  INNER JOIN prophecy_sample_orders_demo
     ON prophecy_sample_customers_demo.customer_id = prophecy_sample_orders_demo.customer_id

),

order_summary_by_customer AS (

  SELECT 
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_amount,
    any_value(first_name) AS first_name,
    any_value(last_name) AS last_name,
    any_value(customer_id) AS customer_id,
    any_value(email) AS email
  
  FROM by_customer_id AS in0
  
  GROUP BY customer_id

),

Reformat_1 AS (

  SELECT 
    total_orders AS total_orders,
    ROUND(total_amount, 2) AS total_amount_rounded,
    customer_id AS customer_id,
    email AS email,
    CONCAT(first_name, ' ', last_name) AS full_name
  
  FROM order_summary_by_customer AS in0

)

SELECT *

FROM Reformat_1
