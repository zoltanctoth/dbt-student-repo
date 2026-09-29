
WITH  __dbt__cte__src_reviews as (
WITH raw_reviews AS (
    SELECT
        *
    FROM
       AIRBNB.raw.raw_reviews
)
SELECT
    listing_id,
    DATE AS review_date,
    reviewer_name,
    comments AS review_text,
    sentiment AS review_sentiment
FROM
    raw_reviews
), src_reviews AS (
  SELECT * FROM __dbt__cte__src_reviews
)
SELECT 
md5(cast(coalesce(cast(listing_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(reviewer_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_text as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS review_id,
* 
FROM src_reviews
WHERE review_text IS NOT NULL

  
    AND review_date > (select max(review_date) from AIRBNB.PROD.fct_reviews)
    
  
-- AND review_date > (SELECT MAX(review_date) FROM AIRBNB.PROD.fct_reviews)
