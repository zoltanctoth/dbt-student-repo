{{
  config(
    materialized = 'ephemeral'
    )
}}
with src_airport_comments as(
    select *
    from {{source('airstats', 'comments')}}
)

select  ID as comment_id,
        AIRPORT_IDENT,
        DATE as comment_timestamp,
        MEMBER_NICKNAME,
        SUBJECT as comment_subject,
        BODY as comment_body
from src_airport_comments