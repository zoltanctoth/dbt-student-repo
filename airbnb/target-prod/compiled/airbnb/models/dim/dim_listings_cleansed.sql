
with  __dbt__cte__src_listing as (
with raw_listing as 
(
select * from AIRBNB.raw.raw_listings
)
select 
id as listing_id,
listing_url,
name as listing_name,
room_type,
minimum_nights,
host_id,
price as price_str,
created_at,
updated_at
from 
raw_listing
), src_listings as
(
    select * from __dbt__cte__src_listing
)
select 
listing_id,
listing_url,
listing_name,
room_type,
case 
when minimum_nights=0 then 1
else minimum_nights
end as minimum_nights,
host_id,
replace (price_str,'$','')::NUMBER(10,2) as price,
created_at,
updated_at
from src_listings