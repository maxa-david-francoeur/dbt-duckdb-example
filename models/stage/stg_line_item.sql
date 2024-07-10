with 
src as (
  select * from {{ source('tpch_sf1', 'lineitem') }}
),
renamed as (
  select 
    l_orderkey as order_id,
    l_partkey as part_id,
    l_suppkey as supplier_id,
    l_linenumber as line_number,
    l_quantity as quantity,
    l_extendedprice as extended_price,
    l_discount as discount,
    l_tax as tax,
    l_returnflag as has_been_returned,
    l_linestatus as line_status,
    l_shipdate as ship_date,
    l_commitdate as commit_date,
    l_receiptdate as receipt_date,
    l_shipinstruct as shipping_instruction,
    l_shipmode as shipping_mode,
    l_comment as comment,
  from 
    src
)
select * from renamed
