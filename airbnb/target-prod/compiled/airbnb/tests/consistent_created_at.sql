select * 
from AIRBNB.DEV.fct_reviews fr
join AIRBNB.DEV.dim_listings_cleansed dl
on fr.listing_id=dl.listing_id
where review_date<created_at
limit 10