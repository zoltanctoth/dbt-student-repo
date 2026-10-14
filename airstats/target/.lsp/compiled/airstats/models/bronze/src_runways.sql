
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