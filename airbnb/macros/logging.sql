{% macro learn_logging() %}
    {{ log("Call your mom!") }}
    {# log("Call your dad!", info=True) #}
{% endmacro %}