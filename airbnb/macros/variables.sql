{% macro learn_variables() %}

{% set your_name_jinja = "Charan" %}
{{ log ("Hello"~ your_name_jinja, info=True) }}

{{ log("Hello " ~ var("user_name"," No variable set") ~ "!",info=True)}}

{% endmacro %}