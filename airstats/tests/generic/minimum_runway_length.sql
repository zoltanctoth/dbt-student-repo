{% test minimum_runway_length(model, min_runway_length , runway_length_column) %}
SELECT
    COUNT(*) as cnt
FROM {{model}}
WHERE {{runway_length_column}} < {{min_runway_length}}
{% endtest %}