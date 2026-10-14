SELECT fr.review_date, dl.created_at
FROM {{ ref('fct_reviews') }} fr
LEFT JOIN {{ ref('dim_listings_cleansed') }} dl ON fr.listing_id = dl.listing_id
WHERE fr.review_date < dl.created_at