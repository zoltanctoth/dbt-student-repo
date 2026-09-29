with __dbt__cte__src_runways as (

with src_runways as (
    select *
    from AIRSTATS.RAW.RUNWAYS
)
select ID as runway_id,
AIRPORT_IDENT,
LENGTH_FT as runway_length_ft,
WIDTH_FT as runway_width_ft,
SURFACE as runway_surface,
LIGHTED as runway_lighted,
CLOSED as runway_closed
from src_runways
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (
with silver_runways as (
    select *
    from __dbt__cte__src_runways
)
select  runway_id,
        AIRPORT_IDENT,
        runway_length_ft,
        runway_width_ft,
        nvl(runway_surface , 'UNKNOWN') as runway_surface,
        runway_lighted,
        runway_closed
from silver_runways
--EPHEMERAL-SELECT-WRAPPER-END
)