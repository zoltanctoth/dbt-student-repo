with h as (
    select * from {{ ref('dim_hosts_cleansed', v=2) }}
),
l as (
    select * from {{ ref('dim_listing_cleansed') }}
)
select 
    l.listing_id,
    l.listing_name,
    l.room_type,
    l.minimum_nights,
    l.price,
    l.price_str,
    h.host_id,
    h.host_name,
    h.is_superhost as host_is_superhost,
    
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) as updated_at
    from l left join h on l.host_id = h.host_id

-- {{ log("Call your mom!") }}