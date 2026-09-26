
WITH RAW_LISTINGS as (
    select * from {{ source ('airbnb','listings')}}
)

select 
	ID as listing_id,
	LISTING_URL,
	NAME as listing_name,
	ROOM_TYPE ,
	MINIMUM_NIGHTS,
	HOST_ID,
	PRICE as PRICE_STR,
	CREATED_AT,
	UPDATED_AT
from raw_listings