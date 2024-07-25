with orders as (
select
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp::TIMESTAMP AS order_purchase_timestamp,
        order_approved_at::TIMESTAMP AS order_approved_at,
        order_delivered_carrier_date::TIMESTAMP AS order_delivered_carrier_date,
        order_delivered_customer_date::TIMESTAMP AS order_delivered_customer_date,
        order_estimated_delivery_date::TIMESTAMP AS order_estimated_delivery_date
    from raw_layer.orders
    ),
 stg_customers as (
    select
        customer_id,
        zipcode,
        city,
        state_code,
        datetime_created::TIMESTAMP as datetime_created,
        datetime_updated::TIMESTAMP as datetime_updated,
        dbt_valid_from,
        dbt_valid_to
    from customer_snapshot
),
state as (
select
        state_id::INT as state_id,
        state_code::VARCHAR(2) as state_code,
        state_name::VARCHAR(30) as state_name
    from raw_layer.state
    ),
dim_customers as (
select
    c.customer_id,
    c.zipcode,
    c.city,
    c.state_code,
    s.state_name,
    c.datetime_created,
    c.datetime_updated,
    c.dbt_valid_from::TIMESTAMP as valid_from,
    case
        when c.dbt_valid_to is NULL then '9999-12-31'::TIMESTAMP
        else c.dbt_valid_to::TIMESTAMP
    end as valid_to
from stg_customers as c
inner join state as s on c.state_code = s.state_code
)
select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    c.zipcode as customer_zipcode,
    c.city as customer_city,
    c.state_code as customer_state_code,
    c.state_name as customer_state_name
from orders as o
inner join dim_customers as c on
    o.customer_id = c.customer_id
    and o.order_purchase_timestamp >= c.valid_from
    and o.order_purchase_timestamp <= c.valid_to;
