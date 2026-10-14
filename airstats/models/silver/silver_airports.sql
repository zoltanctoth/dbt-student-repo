with silver_airports as (
    select *
    from {{ ref('src_airports')}}
)

select *
from silver_airports