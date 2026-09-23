With
l as(
     select * from {{ref('dim_listings_cleansed')}}   
),
h as(
     select * from {{ref('dim_hosts_cleansed')}}   
)
select 
    l.listing_id,
    l.listing_name,
    l.room_type,
    l.minimum_nights,
    l.price,
    l.host_id,
    h.host_name,
    h.is_superhost AS host_is_superhost,
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) AS updated_at
 from l
left join h on l.host_id = h.host_id   

