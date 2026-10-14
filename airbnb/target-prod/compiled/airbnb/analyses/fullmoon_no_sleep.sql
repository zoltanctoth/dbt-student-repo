with fullmoon_reviews as (
  select
    *
    from AIRBNB.MART.mart_fullmoon_reviews

)

select is_full_moon,
        review_sentiment,
        count(*) as review_count
from fullmoon_reviews
group by is_full_moon,
         review_sentiment
order by is_full_moon,
         review_sentiment