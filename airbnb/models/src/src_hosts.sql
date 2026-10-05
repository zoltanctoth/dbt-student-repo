WITH raw_hosts AS (
    SELECT *
    FROM {{ source('airbnb', 'hosts') }}
)
SELECT 
    ID AS host_id,
	NAME AS host_name,
	IS_SUPERHOST,
	CREATED_AT,
	UPDATED_AT,
FROM raw_hosts
