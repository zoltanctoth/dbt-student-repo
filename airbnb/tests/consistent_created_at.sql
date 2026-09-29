select * 
from {{ ref('fct_reviews') }} fr
join {{ ref('dim_listings_cleansed') }} dl
on fr.listing_id=dl.listing_id
where review_date<created_at
limit 10