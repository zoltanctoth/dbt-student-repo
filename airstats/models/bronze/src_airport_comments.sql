WITH airport_comments as (select * from {{ source('airstats', 'comments') }})
select
    id as comment_id,
    airport_ident,
    date as comment_timestamp,
    member_nickname,
    subject as comment_subject,
    body as comment_body
from airport_comments