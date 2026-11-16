with la_helicopter_closed as (
    select * from {{ref('src_airports')}}
)

select *
from la_helicopter_closed
where airport_type = 'closed'