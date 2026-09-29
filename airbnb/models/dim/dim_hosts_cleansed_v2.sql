{{
    config(
        materialized = 'table'
    )
}}
WITH src_hosts AS (
    SELECT *
    FROM {{ ref('src_hosts') }}
)
SELECT 
    HOST_ID, 
    NVL(HOST_NAME, 'N/A') as HOST_NAME, 
    IS_SUPERHOST, 
    -- IFF(is_superhost = 't', TRUE, FALSE) as IS_SUPERHOST, 
    CREATED_AT, 
    UPDATED_AT
FROM 
    src_hosts
