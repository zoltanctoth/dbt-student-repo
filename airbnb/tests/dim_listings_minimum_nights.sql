SELECT * 
FROM {{ref('dim_listings_minimum_nights')}}
WHERE minimum_nights < 1
LIMIT 10