{{config(
    materialized = 'view'
)}}
with src_listing as ( 
    select * from {{ ref('src_listings') }}
)

select 
    listing_id, 
    listing_name,
    room_type,
    case when minimum_nights = 0 then 1
     else minimum_nights end as minimum_nights,
    host_id,
    REPLACE(price_str,'$')::NUMERIC(10, 2) as price,
    price_str,
    created_at,
    updated_at
    from src_listing