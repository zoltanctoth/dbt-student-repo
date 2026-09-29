with l as
(
    select * from {{ ref('dim_listings_cleansed')}}
),
h as 
(
    select * from {{ ref('dim_hosts_cleansed', v=2) }}
)
select 
l.listing_id,
l.listing_name,
l.room_type,
l.minimum_nights,
l.price as price_usd,
l.price_str,
l.host_id,
h.host_name,
h.is_superhost as host_is_superhost,
l.created_at,
greatest(l.updated_at,h.updated_at) as updated_at
from l
left join h 
on h.host_id=l.host_id