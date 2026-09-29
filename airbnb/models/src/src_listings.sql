WITH raw_listings AS (
SELECT * FROM {{ source('airbnb', 'listings') }}
)
SELECT
id as listing_id,
name as listing_name,
listing_url,
room_type,
minimum_nights,
host_id,
price as price_str,
created_at,
updated_at
FROM raw_listings