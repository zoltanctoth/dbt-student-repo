{{
  config(
    materialized = 'view',  
    )
}} 

WITH src_hosts AS(
    SELECT * FROM {{ref('src_hosts')}}
)
SELECT 
    HOST_ID, 
    NVL(HOST_NAME,'Anonymous') AS HOST_NAME,
    IS_SUPERHOST, 
    CREATED_AT, 
    UPDATED_AT
FROM 
    src_hosts