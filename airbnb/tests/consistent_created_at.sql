select *
from {{ref('dim_listing_cleansed')}} L 
left join {{ref('fct_reviews')}} R on L.LISTING_ID=R.LISTING_ID
where 
L.CREATED_AT > R.REVIEW_DATE