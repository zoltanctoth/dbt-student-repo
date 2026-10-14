{{
    config(
        materialized = 'view'
    )

}}


with src_listings as (

    select * from {{ref('src_raw_listings')}}
)

select 

    listing_id,
    listing_name,
	room_type,

    case 
        when minimum_nights = 0 then 1
        else minimum_nights
    end as minimum_nights,

	host_id,
    REPLACE (price_str, '$') :: NUMBER(10,2) as price,
    updated_at,
    created_at


from src_listings
