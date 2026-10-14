
with  __dbt__cte__src_reviews as (
with raw_review as 
(
select * from AIRBNB.raw.raw_reviews
)
select 
listing_id,
date as review_date,
reviewer_name,
comments as review_text,
sentiment as review_sentiment
from 
raw_review
), src_reviews as
(
    select * from __dbt__cte__src_reviews
)
select 
md5(cast(coalesce(cast(listing_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(reviewer_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_text as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as review_id,
 *
from src_reviews
where review_text is not null 

    
        And review_date> (select max(review_date) from AIRBNB.DEV.fct_reviews)
        
    
