{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}
with silver_airport_comments as(
    select *
    from {{ref('src_airport_comments')}}
)
select comment_id,
        AIRPORT_IDENT,
        comment_timestamp,
        nvl(MEMBER_NICKNAME , 'UNKNOWN') as MEMBER_NICKNAME,
        comment_subject,
        comment_body,
        current_timestamp() as loaded_at
from silver_airport_comments
where comment_body is not null

{% if is_incremental() %}
    AND comment_id > (select max(comment_id) from {{ this }})
{% endif %}