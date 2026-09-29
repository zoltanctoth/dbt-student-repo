{% macro learn_logging() %}
    {# {{ log("Call your mom!") }}  add a jinja comment if you want to ignore logging#}
    {{ log("Call your dad!", info=True) }}
{% endmacro %}