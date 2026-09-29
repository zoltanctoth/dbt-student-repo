with raw_reviews as ( 
    select * from {{ source('airbnb', 'reviews') }} )

select 

listing_id,
date as review_date,
reviewer_name,
comments as review_comment, 
sentiment as review_sentiment

from raw_reviews