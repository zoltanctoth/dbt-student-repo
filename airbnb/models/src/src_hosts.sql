With src_hosts as (
select * from {{source('airbnb', 'hosts')}}
)
select 
id as Host_ID,
name as Host_Name,
is_superhost,
created_at,
updated_at
from src_hosts

-- TEST: GitHub to dbt Cloud