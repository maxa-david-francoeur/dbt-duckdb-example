with src as (
      select * from {{ source('tpch_sf1', 'orders') }}
),
renamed as (
    select
        o_orderkey as order_id, 
        o_custkey as customer_id,
        o_orderstatus as order_status, 
        o_totalprice as total_price, 
        o_orderdate as order_date, 
        o_orderpriority as order_priority, 
        o_clerk as clerk, 
        o_shippriority as shipping_priority, 
        o_comment as comment, 

    from src
)
select * from renamed
  