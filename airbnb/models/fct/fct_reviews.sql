

{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )

}}



with src_reviews as (
    select * from {{ref('src_raw_reviews')}}
)

select *  
from src_reviews
where REVIEW_COMMENTS is not null

{% if is_incremental () %}
and REVIEW_DATE > (select max(REVIEW_DATE) from {{ this }})
{% endif %}