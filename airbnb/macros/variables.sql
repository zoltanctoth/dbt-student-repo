-- We have two types of variables:
-- 1. Jinja variables which are simple and come from the Jinja language
-- 2. dbt variables which can be passed to dbt command line or project descripter file
--    These are also known as project variables and dbt manage them for you!
--    These can be referenced with 'var' keyword!
-- Usually we want to use the second type unless we need to do something very advanced with type 1.

{% macro learn_variables() %}
    {% set your_name_jinja = "Naeim" %}
    {{ log("Hello " ~ your_name_jinja ~ "!", info=True) }}

    {{ log("Hello dbt user: " ~ var("user_name", "NO USERNAME IS SET!") ~ "!", info=True) }}

{% endmacro %}


"""
    Some common codes if you want to experiment: red 31, green 32, yellow 33, 
    blue 34, magenta 35, cyan 36. Add 1; for bold, e.g. \033[1;32m for bold green. 
    Background colors are 40–47.

"""
{% macro learn_variables_with_colors() %}
    {% set green = "\033[32m" %}
    {% set cyan = "\033[36m" %}
    {% set reset = "\033[0m" %}
    {% set your_name_jinja = "Naeim" %}
    {{ log(green ~ "Hello " ~ your_name_jinja ~ "!" ~ reset, info=True) }}

    {{ log(cyan ~ "Hello dbt user: " ~ var("user_name") ~ "!" ~ reset, info=True) }}
{% endmacro %}
