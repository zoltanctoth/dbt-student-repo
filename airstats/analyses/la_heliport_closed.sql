
--IF you wanted to get all closed heliports in Los Angeles, you could do something like this:
WITH scd as (
    select * from {{ ref('scd_silver_airports') }}
)
SELECT
    scd.*
FROM scd
WHERE scd.AIRPORT_NAME like '%Los Angeles%' AND scd.AIRPORT_NAME like '%Heliport%' AND scd.AIRPORT_TYPE = 'closed'

/* For specificly Airport with Ident: 01CN
WITH scd as (
    select * from AIRSTATS.DEV.scd_silver_airports
)
SELECT
    scd.*
FROM scd
WHERE AIRPORT_IDENT = '01CN'
*/