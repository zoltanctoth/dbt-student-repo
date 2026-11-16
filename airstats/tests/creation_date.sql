select *
from {{ref('silver_airport_comments')}}

where loaded_at < comment_timestamp