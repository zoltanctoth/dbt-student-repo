{{
  config(
    materialized = 'view'
  )
}}
WITH src_hosts AS (
  SELECT
    *
  FROM
    {{ ref('src_hosts') }}
)
select 
  host_id,
  NVL(host_name, 'Anonymous') AS host_name,
  is_superhost,
  created_at,
  updated_at
  from src_hosts