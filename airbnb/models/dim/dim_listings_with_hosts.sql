WITH 
listings_cleansed AS (
    SELECT * FROM {{ ref('dim_listings_cleansed') }}
),
hosts_cleansed AS (
    SELECT * FROM {{ ref('dim_hosts_cleansed', v=2) }}
)

SELECT
    listings_cleansed.listing_id,
    listings_cleansed.listing_name,
    listings_cleansed.room_type,
    listings_cleansed.minimum_nights,
    listings_cleansed.price,
    listings_cleansed.host_id,
    listings_cleansed.price_str,
    hosts_cleansed.host_name,
    hosts_cleansed.is_superhost AS host_is_superhost,
    listings_cleansed.created_at,
    GREATEST(listings_cleansed.updated_at, hosts_cleansed.updated_at) AS updated_at
FROM listings_cleansed
LEFT JOIN hosts_cleansed ON (listings_cleansed.host_id = hosts_cleansed.host_id)
