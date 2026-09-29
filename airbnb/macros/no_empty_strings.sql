{%- macro no_empty_strings(model) -%}
    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() -%}
            {{col.name}} is not null and {{col.name}} <> ''  AND 
        {% endif -%}        
    {%- endfor -%}
    TRUE 
{%- endmacro -%}

-- way to check dbt compile --inline "SELECT * from {{ref('dim_hosts_cleansed')}} where {{ no_empty_strings(ref('dim_hosts_cleansed')) }}"
-- way to execute dbt show --inline "SELECT * from {{ref('dim_hosts_cleansed')}} where {{ no_empty_strings(ref('dim_hosts_cleansed')) }}"
