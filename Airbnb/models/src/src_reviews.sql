with raw_reviews AS
(
    select  *
    from {{source('airbnb','reviews')}}
)

select  LISTING_ID,
        DATE as REVIEW_DATE,
        REVIEWER_NAME,
        comments as REVIEW_TEXT,
        sentiment as REVIEW_SENTIMENT
    from raw_reviews