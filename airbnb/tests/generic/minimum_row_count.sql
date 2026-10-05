{% test test_generic_minimum_row_count(model, min_row_count) %}
{{ config(severity = 'warn') }} -- This changes the Failure to Wrning for any model tested by this custom Generic test!
    SELECT COUNT(*) AS cnt 
    FROM {{ model }}
    HAVING COUNT(*) < {{ min_row_count }}
{% endtest %}
