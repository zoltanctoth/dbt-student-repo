{% test minimum_row_count(model,min_row_count) %}
select count(*)
from {{model}}
having count(*)< {{min_row_count}}
{% endtest %}