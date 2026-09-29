SELECT *
FROM {{ ref('fct_reviews') }} as r
INNER JOIN {{ ref('dim_listings_cleansed') }} as l
USING (listing_id)
WHERE l.created_at > r.review_date
LIMIT 10
