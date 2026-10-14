select *
from {{ref('silver_airport_comments')}}
where comment_timestamp >= getdate()