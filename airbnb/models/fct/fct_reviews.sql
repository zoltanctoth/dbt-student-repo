-- Default is append! -> append, merge, delete+insert, insert_overwrite, microbatch
-- event_time is added for micro-batches
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        event_time = 'review_date', 
        unique_key = 'review_id',
        on_schema_change = 'fail'
    )
}}

WITH src_reviews AS (
    SELECT * 
    FROM {{ ref('src_reviews') }}
),
parent as (
    select listing_id
    from {{ ref('src_listings') }}
)
SELECT 
    {{ dbt_utils.generate_surrogate_key(
            ['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} AS review_id,
    * 
FROM src_reviews
WHERE review_text IS NOT NULL
AND listing_id IN (select listing_id
                    from parent)

-- The implimentation below is naive!
-- In production, the approach below is not enough, usually things go wrong and we need to backfill
-- and reload data based on date-range. So we need a date-range parameter
-- {% if is_incremental() %}
--    AND REVIEW_DATE > (SELECT MAX(REVIEW_DATE) FROM {{ this }})
-- {% endif %}


{% if is_incremental() %}
    {% if var("start_date", False) and var("end_date", False) %}
        AND review_date >= '{{ var("start_date") }}'
        AND review_date < '{{ var("end_date") }}'       
        {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    {% else %}
        AND REVIEW_DATE > (SELECT MAX(REVIEW_DATE) FROM {{ this }})
        {{ log("Loading " ~ this ~ " incrementally (all missing dates)", info=True)}}
    {% endif %}
{% endif %}
