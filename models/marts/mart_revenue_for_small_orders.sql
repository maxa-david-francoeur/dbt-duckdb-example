with 
order_stream as (
  select * from {{ ref('order_stream') }}
), 
orders as (
  select * from order_stream where activity_id = 1
), 
total_qty_per_order as (
  select 
    payload.order_date as order_date,
    payload.order_id as order_id,
    payload.part_id as part_id, 
    payload.part_name::string as part_name,  
    sum(payload.extended_price::float) as revenue, 
    sum(payload.quantity::float) as quantity,
  from
    orders 
    group by all 
),
avg_qty_per_command as (
  select 
    part_id,
    avg(quantity) as avg_qty
  from total_qty_per_order
  group by all 
), 
recipe as (
  select 
    tot.*
  from 
    total_qty_per_order as tot 
    left join avg_qty_per_command as avg
      using (part_id)
  where
    tot.quantity < 0.20*avg.avg_qty 

)

select * from recipe
