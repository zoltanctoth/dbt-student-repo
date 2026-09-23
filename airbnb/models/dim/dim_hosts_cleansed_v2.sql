{{
    config(
        materialized = 'table'
    )
}}
WITH src_hosts AS(
    SELECT *
    FROM {{ ref('src_hosts') }}
)
SELECT 
    host_id,
    CASE 
        WHEN HOST_NAME IS NULL THEN 'N/A'
        ELSE HOST_NAME
    END HOST_NAME,
    IS_SUPERHOST,
    -- IFF(IS_SUPERHOST = 't', TRUE, FALSE) AS IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM src_hosts
