{{
    config(
        materialized = 'view'
    )
}}


WITH src_hosts AS (
    SELECT * from {{ref('src_hosts')}}
)
SELECT
    host_id,
    NVL(
        host_name,
        'Anonymous'
    ) AS host_name,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM
    src_hosts