{{
    config(
        materialized='view'
    )
}}

with src_hosts as (
    select * from {{ref('src_hosts')}}
)
SELECT
    host_id,
    coalesce(host_name,'Anonymous') as host_name,
    is_superhost,
    created_at,
    updated_at
FROM src_hosts

