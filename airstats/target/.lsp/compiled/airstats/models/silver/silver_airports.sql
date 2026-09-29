with __dbt__cte__src_airports as (

with src_airports as (
    select *
    from AIRSTATS.RAW.AIRPORTS
)
select ID,
	IDENT as airport_ident,
	TYPE as airport_type,
	NAME as airport_name,
	LATITUDE_DEG as airport_lat,
	LONGITUDE_DEG as airport_long,
	CONTINENT,
	ISO_COUNTRY,
	ISO_REGION
from src_airports
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (
with silver_airports as (
    select *
    from __dbt__cte__src_airports
)

select *
from silver_airports
--EPHEMERAL-SELECT-WRAPPER-END
)