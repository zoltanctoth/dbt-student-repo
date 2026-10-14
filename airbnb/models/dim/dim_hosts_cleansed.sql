{{
  config(
    materialized = 'table',
    event_time='created_at'
  )
}} WITH src_hosts AS (
    SELECT * FROM {{ref('src_hosts')}}
)
SELECT
    host_id,
    CASE 
        WHEN host_name IS NULL THEN 'Anonymous' 
        ELSE host_name 
    END AS host_name,
    is_superhost,
    created_at,
    updated_at,
FROM
    src_hosts
