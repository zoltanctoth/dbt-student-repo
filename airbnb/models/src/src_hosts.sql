WITH raw_hosts AS (
   SELECT * FROM {{ source('airbnb', 'hosts') }}
)

SELECT
   ID AS HOST_ID,
   Name as HOST_NAME,
   IS_SUPERHOST,
   CREATED_AT,
   UPDATED_AT,
FROM 
   AIRBNB.RAW.RAW_HOSTS