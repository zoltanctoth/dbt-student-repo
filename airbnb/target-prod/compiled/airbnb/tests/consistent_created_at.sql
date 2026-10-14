SELECT
    *
FROM
    AIRBNB.PROD.dim_listings_cleansed dl
inner join AIRBNB.PROD.fct_reviews fr
   using(listing_id)
WHERE
    dl.created_at > fr.review_date