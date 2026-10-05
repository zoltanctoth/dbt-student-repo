{% macro no_empty_string(model) %}
    {% for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() -%}
            {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND
        {% endif -%}
    {% endfor -%}
    TRUE
{% endmacro %}

"""
    If we want to remove the TURE in the script above:
    The issue is that loop.last refers to the last column in the relation, 
    not the last string column. If the last column in your table is not a string, 
    the final string column will still emit an AND.
"""
{% macro no_empty_string2(model) %}
    {%- set string_cols = [] -%}

    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() -%}
            {%- do string_cols.append(col) %}
        {% endif -%}
    {%- endfor %}

    {%- for col in string_cols -%}
        {{ col.name }} IS NOT NULL AND {{ col.name }} <> ''
        {%- if not loop.last %} AND {% endif %}
    {% endfor %}
{% endmacro %}
