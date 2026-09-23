WITH l AS (
    SELECT *
    FROM {{ ref('dim_listings_cleansed') }}
),
h AS (
    SELECT *
    FROM {{ ref('dim_hosts_cleansed', v=2) }}
)
SELECT 
    l.LISTING_ID,
    l.LISTING_NAME,
    l.ROOM_TYPE,
    l.minimum_nights,
    l.price,
    l.price_str,
    l.host_id,
    h.host_name,
    h.is_superhost AS host_is_superhost,
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) AS updated_at
FROM l 
LEFT JOIN h ON (l.host_id = h.host_id)
