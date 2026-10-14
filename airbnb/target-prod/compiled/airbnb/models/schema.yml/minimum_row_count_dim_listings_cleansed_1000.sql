


SELECT
    COUNT(*) as cnt
FROM
    AIRBNB.PROD.dim_listings_cleansed
HAVING
    COUNT(*) < 1000
