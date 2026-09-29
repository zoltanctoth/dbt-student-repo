{% macro learn_variables() %}

    {% set your_name_jinja = "Zoltam" %}
    {{ log("Hello " ~ your_name_jinja, info=True)}}

{% endmacro %}