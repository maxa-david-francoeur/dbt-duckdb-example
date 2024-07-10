with
int__ as (
  select * from {{ ref('int__activity_line_item_created') }}
),
final as (
  select 
    {{ dbt_utils.generate_surrogate_key([
        'order_id',
        'line_number'
      ]) }} as row_id,
      commit_date as activity_timestamp,
      'tpch' as activity_source,
      'line_item_created' as activity_name,
      1 as activity_id,
      '' as tags,
      '' as lineage,
      to_json({
        'order': to_json({
            'id': order_id
      }),
        'part': to_json({
            'id': part_id
        }),
        'customer': to_json({
            'id': customer_id
        })
        }) as entities,
      to_json({
        'order_id': order_id, 
        'line_number': line_number,
        'part_id': part_id,
        'customer_id': customer_id, 
        'part_name': part_name,
        'quantity': quantity,
        'extended_price': extended_price,
        'part_retail_price': part_retail_price,
        'discount': discount,
        'order_date': order_date,
        'ship_date': ship_date,
        'commit_date': commit_date,
        'receipt_date': receipt_date
      }) as payload,
      to_json({
          'insert_batch_id': '18145b2c-a11f-4e95-9f30-d4dfff67aac6',
          'row_inserted_at': current_timestamp
      }) as metadata,
  from int__
)

select * from final
