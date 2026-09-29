

with  __dbt__cte__src_hosts as (
with raw_hosts as(
select *
from AIRBNB.raw.raw_hosts
)
SELECT
    id as host_id,
    name AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts
), src_hosts as(
    select
       *
    from __dbt__cte__src_hosts
)
select 
    host_id,
    nvl(host_name, 'Anonymous') as host_name,
    is_superhost,
    created_at,
    updated_at
from src_hosts