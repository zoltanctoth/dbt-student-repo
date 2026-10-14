{% test minimum_row_count(model, column_name, min_row_count) %}
{{config(
    severity = 'warn'
)}}

SELECT count(*) as cnt
FROM {{ model }} 
HAVING 
Count(*) < {{ min_row_count }}
{% endtest %}