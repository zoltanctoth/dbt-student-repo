{{
    config(
        materialized='view',
        event_time='created_at'
    )
}}

SELECT
    listing_id,
    listing_name,
    room_type,
    CASE
        WHEN minimum_nights IS NULL OR minimum_nights = 0 THEN 1
        ELSE minimum_nights
    END AS minimum_nights,
    host_id,
    TRY_TO_NUMBER(REPLACE(REPLACE(price_str, '$', ''), ',', ''), 10, 2) AS price,
    created_at,
    updated_at
FROM {{ ref('src_listings') }}