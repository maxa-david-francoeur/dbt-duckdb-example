with 
line_item as (
  select * from {{ ref('activity_line_item_created') }}
), 
union_all as (
  select * from line_item
)

select * from union_all
