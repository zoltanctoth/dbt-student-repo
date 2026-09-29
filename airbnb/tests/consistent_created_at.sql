
/* Create a singular test in tests/consistent_created_at.sql 
that checks that there is no review date that is submitted before its listing was created: 
Make sure that every review_date in fct_reviews is more recent than 
the associated created_at in dim_listings_cleansed. */



WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
),
dim_listings_cleansed AS (
    SELECT * FROM {{ ref('dim_listings_cleansed') }}
)
SELECT
    cl.listing_id,
    r.review_date,
    cl.created_at
FROM
    dim_listings_cleansed cl
JOIN fct_reviews  r
ON cl.listing_id = r.listing_id
WHERE r.review_date < cl.created_at  
LIMIT 10

/* Important to remember when we check for condition we must retun "bad" records 
   only. This is way we esentialy must use reverse condition check. */