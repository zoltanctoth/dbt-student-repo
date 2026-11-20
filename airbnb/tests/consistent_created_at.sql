WITH listings_cleansed AS (
    SELECT listing_id, created_at FROM {{ ref('dim_listings_cleansed') }}
)

SELECT listing_id, reviews.review_date, listings.created_at FROM {{ ref('fct_reviews') }} reviews
INNER JOIN listings_cleansed listings
USING (listing_id)
WHERE reviews.review_date < listings.created_at
LIMIT 10