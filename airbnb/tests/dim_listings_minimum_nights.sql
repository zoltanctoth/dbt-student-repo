SELECT
    *
FROM
    {{ ref('dim_listing_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10
