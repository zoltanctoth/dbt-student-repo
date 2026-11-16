{{
    config(
        materialized = 'incremental',
        unique_key = 'comment_id',
        on_schema_change = 'fail'
    )
}}

select
    comment_id,
    airport_ident,
    comment_timestamp,
    coalesce(member_nickname, '__UNKNOWN__') as member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() as loaded_at
from {{ ref('src_airport_comments') }}
where comment_body is not null

{% if is_incremental() %}
    and comment_id > (select max(comment_id) from {{ this }})
{% endif %}