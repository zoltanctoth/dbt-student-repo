with la_heliport_closed as (
    select *
    from {{ref('scd_silver_airports')}}
)
select *
from la_heliport_closed
where airport_ident = '01CN'