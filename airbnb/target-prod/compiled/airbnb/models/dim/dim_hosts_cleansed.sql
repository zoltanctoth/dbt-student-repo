
WITH  __dbt__cte__src_hosts as (
WITH raw_hosts AS (
    SELECT  *
    FROM AIRBNB.raw.raw_hosts
)
select 
  id AS host_id,
  name AS host_name,
  is_superhost,
  created_at,
  updated_at
from raw_hosts
), src_hosts AS (
  SELECT
    *
  FROM
    __dbt__cte__src_hosts
)
select 
  host_id,
  NVL(host_name, 'Anonymous') AS host_name,
  is_superhost,
  created_at,
  updated_at
  from src_hosts