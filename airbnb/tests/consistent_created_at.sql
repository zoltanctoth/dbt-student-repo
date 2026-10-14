select
    r.listing_id,
    r.review_date,
    l.created_at

from {{ ref('fct_reviews') }} r

join {{ ref('dim_listings_cleansed') }} l
    on r.listing_id = l.listing_id

where r.review_date < l.created_at
limit 10