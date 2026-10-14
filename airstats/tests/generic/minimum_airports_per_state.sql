{% test minimum_airports_per_state(model, min_airports_per_state, state_column) %}
SELECT
    COUNT(*) as cnt
FROM {{model}}
GROUP BY {{state_column}}
Having
    COUNT(*) < {{min_airports_per_state}}
{% endtest %}