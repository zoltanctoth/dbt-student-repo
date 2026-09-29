select *
from {{ref('silver_runways')}}
where runway_closed > 1