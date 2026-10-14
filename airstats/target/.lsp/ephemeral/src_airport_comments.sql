__dbt__cte__src_airport_comments as (

with src_airport_comments as(
    select *
    from AIRSTATS.raw.airport_comments
)

select  ID as comment_id,
        AIRPORT_IDENT,
        DATE as comment_timestamp,
        MEMBER_NICKNAME,
        SUBJECT as comment_subject,
        BODY as comment_body
from src_airport_comments
)