{{
  config(
    materialized = 'view'
  )
}} 

With src_hosts as (
    select * from {{ref('src_hosts')}}
)
select
    HOST_ID,
    NVL(host_name, 'Anonymous') AS host_name,
    is_superhost,
    created_at,
    updated_at
from src_hosts