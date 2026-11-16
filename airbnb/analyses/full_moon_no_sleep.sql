with mart_fullmoon_reviews as (
    select * from {{ref('mart_fullmoon_reviews')}}
)

select 
    is_full_moon,
    sentiment_review,
    count(*) as reviews
from
    mart_fullmoon_reviews
group by 
    is_full_moon,
    sentiment_review
order by 
    is_full_moon,
    sentiment_review