{% macro no_empty_strings(model) %}
    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() %}
            {{ col.name }} is not null and {{ col.name}} <> '' and
        {%- endif %}
    {%- endfor %}
    TRUE
{% endmacro %}