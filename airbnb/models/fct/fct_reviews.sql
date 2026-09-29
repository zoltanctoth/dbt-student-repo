{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail',
        event_time = "review_date"
    )
}}
WITH src_reviews AS (
    SELECT * from {{ref('src_reviews')}}
)
SELECT
{{dbt_utils.generate_surrogate_key(['listing_id','review_date','reviewer_name','review_text'])}} as review_id,
* 
from src_reviews
WHERE review_text is not null

{% if is_incremental() %}
    {% if var("start_date",False) and var("end_date",False) %}
        {{log('Loading' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date"),info=True)}}
        AND review_date >= '{{ var("start_date")}}'
        AND review_date < '{{ var("end_date")}}'
    {% else %}
        AND review_date > (select max(review_date) from {{this}})
        {{ log('Loading' ~ this ~ ' incrementally (all missing dates)', info=True)}}
    {% endif %}
{% endif %}

/*  Older version for additional conditions for an incremental model
{% if is_incremental() %}
    AND review_date > (SELECT max(review_date) from {{this}})
{% endif %}
*/