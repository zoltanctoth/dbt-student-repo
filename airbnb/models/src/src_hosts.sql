with raw_hosts as(
select *
from {{source('airbnb','hosts')}}
)
SELECT
    id as host_id,
    name AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts