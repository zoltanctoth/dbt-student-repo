

with  __dbt__cte__src_hosts as (
with raw_hosts as 
(
select * from AIRBNB.raw.raw_hosts
)
select 
id as host_id,
name as host_name,
is_superhost,
created_at,
updated_at
from 
raw_hosts
), src_hosts as 
(
    select * from __dbt__cte__src_hosts
)
select 
host_id,
NVL(host_name,'N/A') as host_name,
is_superhost,
created_at,
updated_at
from src_hosts