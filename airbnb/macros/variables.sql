{% macro learn_variables() %}

{% set your_name_jinja = "Jeremy" %}
{{log("Hello " ~ your_name_jinja, info=true)}}

{{ log("Hello dbt user " ~ var("user_name", "NO USERNAME SET") ~ "!", info=True) }}


{% endmacro %}