with silver_runways as (
    select *
    from {{ref('src_runways')}}
)
select  runway_id,
        AIRPORT_IDENT,
        runway_length_ft,
        runway_width_ft,
        nvl(runway_surface , 'UNKNOWN') as runway_surface,
        runway_lighted,
        runway_closed
from silver_runways