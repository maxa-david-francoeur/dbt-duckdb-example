with 
src as (
  select * from {{ source('tpch_sf1', 'partsupp') }}
),
renamed as (
  select    
    ps_partkey as part_id,
    ps_suppkey as supp_part_id,
    ps_availqty as supp_part_available_quantity,
    ps_supplycost as supp_part_supply_cost,
    ps_comment as supp_part_comment,
  from 
    src 
)
select * from renamed
