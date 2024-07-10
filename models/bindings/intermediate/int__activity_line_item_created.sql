with 
line_item as (
  select * from {{ ref('stg_line_item') }}
),
parts as (
  select * from {{ ref('stg_parts') }}
),
orders as (
  select * from {{ ref('stg_orders') }}
),
join_dimensions as (
  select 
    li.*,
    o.order_date, 
    o.total_price, 
    o.customer_id,
    p.part_name, 
    p.part_retail_price,
  from 
    line_item as li
      left join orders as o
        using (order_id)
      left join parts as p 
        using (part_id)
),
reshaped as (
    select
        -- ids 
        order_id, 
        line_number,
        part_id,
        customer_id, 
        -- dimensions
        part_name,
        -- measures
        quantity,
        extended_price,
        part_retail_price,
        discount,
        total_price,
        -- date/times 
        order_date,
        ship_date,
        commit_date,
        receipt_date,
    from
      join_dimensions
) 

select * from reshaped
