{% test minimum_row_count(model, min_row_count) %}
SELECT
    COUNT(*) as cnt
FROM
    {{model}}
Having
    COUNT(*) < {{min_row_count}}
{% endtest %}