{% test minimum_row_count(model, min_rows) %}
    SELECT count(*) as row_count
    FROM {{ model }}
    HAVING count(*) < {{ min_rows }}
{% endtest %}