SELECT
    i.listing_id,
    i.created_at,
    r.review_date
FROM {{ ref('dim_listings_cleansed') }} i
INNER JOIN {{ ref('fct_reviews') }} r
    ON i.listing_id = r.listing_id
WHERE i.created_at > r.review_date