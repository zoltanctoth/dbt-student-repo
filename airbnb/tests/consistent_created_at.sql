with dim_listings_cleansed as (
    select *
    from {{ref('dim_listings_cleansed')}}
), fct_reviews as (
    select *
    from {{ref('fct_reviews')}}
)
select r.*
from dim_listings_cleansed l
inner join fct_reviews r
on l.listing_id = r.listing_id
where l.created_at > r.review_date