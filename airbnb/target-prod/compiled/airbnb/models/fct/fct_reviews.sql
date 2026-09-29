
WITH  __dbt__cte__src_reviews as (
WITH raw_reviews AS (
    SELECT
        *
    FROM
        AIRBNB.raw.raw_reviews
)
SELECT
    listing_id,
    date AS review_date,
    reviewer_name,
    comments AS review_text,
    sentiment AS review_sentiment
FROM
    raw_reviews
), src_reviews AS (
  SELECT * FROM __dbt__cte__src_reviews
)
SELECT 
md5(cast(coalesce(cast(LISTING_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(REVIEW_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(REVIEWER_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(REVIEW_TEXT as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as review_id
,*
FROM src_reviews
WHERE review_text is not null


  
    AND review_date > (select max(review_date) from AIRBNB.PROD.fct_reviews)
    
  
