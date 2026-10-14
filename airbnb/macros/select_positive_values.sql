{% macro select_positive_values(model_name, column_name) %}
SELECT *
FROM {{model_name}}
WHERE {{column_name}} > 0
{% endmacro %}
