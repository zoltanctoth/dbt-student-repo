{{
    config(
        materialized = 'incremental',
        event_time = "date_review",
        begin = "2009-06-20",
        batch_size = "year",
        on_schema_change = 'fail'
    )
}}

with src_reviews as (
    select *
    from {{ref('src_reviews')}}
)

select 
{{dbt_utils.generate_surrogate_key(['listing_id', 'date_review', 'reviewer_name', 'review_text'])}} as review_id,
*
from src_reviews
where review_text is not null

{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND date_review >= '{{ var("start_date") }}'
    AND date_review < '{{ var("end_date") }}'
  {% else %}
    AND date_review > (select max(date_review) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}
{% endif %}