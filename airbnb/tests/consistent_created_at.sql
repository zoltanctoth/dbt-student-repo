select *
from {{ref('fct_reviews')}} as fr
left join {{ref('dim_listings_cleansed')}} as dlc
    using(listing_id)

where fr.date_review < dlc.created_at