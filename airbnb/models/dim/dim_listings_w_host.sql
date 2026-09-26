with 

listings as (
    select * from {{ref('dim_listings')}}
),

host as (
    select * from {{ref('dim_host')}}
)

select 
    listings.listing_id,
    listings.listing_name,
	listings.room_type,
    listings.minimum_nights,
    listings.price,
    listings.host_id,
    host.host_name,
    host.is_superhost as host_is_superhost,
    listings.created_at,
    GREATEST(listings.updated_at, host.updated_at) as updated_at

from listings

left join host on (host.host_id = listings.listing_id)