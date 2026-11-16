with raw_reviews as (
select * from {{source('airbnb', 'reviews')}}
)

select 
    listing_id,
    date as date_review,
    reviewer_name,
    comments as review_text,
    sentiment as sentiment_review

from raw_reviews