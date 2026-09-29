with __dbt__cte__src_airport_comments as (

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
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

with silver_airport_comments as(
    select *
    from __dbt__cte__src_airport_comments
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


    AND comment_id > (select max(comment_id) from AIRSTATS.DEV.silver_airport_comments)

--EPHEMERAL-SELECT-WRAPPER-END
)