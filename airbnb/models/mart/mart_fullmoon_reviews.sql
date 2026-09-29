{{
    config(
        materialized='incremental',
        incremental_strategy = 'microbatch',
        event_time="review_date",
        begin="2009-06-20",
        batch_size="year",
        full_refresh=false,
        tags = ['fact'],
        schema='mart'
    )
}}
with fact_reviews as 
(
    select * from {{ ref('fct_reviews') }}
),
full_moon_dates as 
(
    select * from {{ ref('seed_full_moon_dates') }}
)
select 
r.*,
case when fm.full_moon_date is null then 'Not Full Moon'
else 'Full Moon'
end as is_full_moon
from 
fact_reviews r 
left join full_moon_dates fm
on To_DATE(r.review_date)=dateadd(day,1,fm.full_moon_date)