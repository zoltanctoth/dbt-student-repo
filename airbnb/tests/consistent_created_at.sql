SELECT rev.listing_id, rev.review_date, lis.created_at
FROM {{ ref('fct_reviews') }} rev
LEFT JOIN {{ ref('dim_listings_cleansed') }} lis
    ON rev.listing_id = lis.listing_id
WHERE rev.review_date < lis.created_at