{{
    config(
        materialized = 'view'
    )

}}


with src_host as (
    select * from {{ref('src_raw_hosts')}}
)

select 
    host_id,
	NVL(host_name, 'Anonymous') as host_name,
	is_superhost,
    created_at,
    updated_at

from src_host