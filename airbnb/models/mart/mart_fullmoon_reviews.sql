{{ config(
    materialized = 'incremental', 
    incremental_strategy = 'microbatch',
    event_time = "date_review",
    begin = "2009-06-20",
    batch_size = "year",
    full_refresh = false,
    tags = ['fact'],
    schema='mart'
)}}

with fct_reviews as (
    select * from {{ref('fct_reviews')}}
),
full_moon_dates as (
    select * from {{ref('seed_full_moon_dates')}}
)

select
    r.*,
    case
        when fm.full_moon_date is null then 'not full moon'
        else 'full moon'
    end as is_full_moon
from 
    fct_reviews as r
    left join full_moon_dates as fm
        on (to_date(r.date_review) = dateadd(day,1,fm.full_moon_date))