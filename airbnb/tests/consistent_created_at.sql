SELECT
    *
FROM
    {{ ref('dim_listings_cleansed') }} dl
inner join {{ ref('fct_reviews') }} fr
   using(listing_id)
WHERE
    dl.created_at > fr.review_date