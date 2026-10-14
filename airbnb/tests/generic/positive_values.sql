{% test positive_values(model, column_name) %}
SELECT * from {{model}} where {{ column_name }} <= 0
{% endtest %}