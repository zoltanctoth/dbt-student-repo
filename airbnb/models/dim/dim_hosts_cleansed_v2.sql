{{
    config(
        materialized='table'
    )
}}

with src_hosts as 
(
    select * from {{ ref ('src_hosts')}}
)
select 
host_id,
NVL(host_name,'N/A') as host_name,
is_superhost,
created_at,
updated_at
from src_hosts