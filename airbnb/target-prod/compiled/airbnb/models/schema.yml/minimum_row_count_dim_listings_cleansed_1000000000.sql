
select count(*)
from AIRBNB.DEV.dim_listings_cleansed
having count(*)< 1000000000
