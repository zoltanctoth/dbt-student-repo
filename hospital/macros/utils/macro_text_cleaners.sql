{% macro clean_string(column_name) %}
    -- 6. Remove espaços extras nas pontas e força letras maiúsculas (Essencial para IA)
    upper(trim({{ column_name }}::varchar))
{% endmacro %}

{% macro safe_coalesce_text(column_name, fallback='NÃO INFORMADO') %}
    -- 7. Garante que campos nulos textuais ganhem um fallback amigável
    coalesce({{ dbt_hospital.clean_string(column_name) }}, '{{ fallback }}')
{% endmacro %}


{% macro format_blood_type(column_name) %}
    -- 9. Valida e limpa caracteres do tipo sanguíneo (ex: remove espaços neles)
    upper(trim(replace({{ column_name }}, ' ', '')))
{% endmacro %}

{% macro extract_first_name(column_name) %}
    -- 10. Extrai o primeiro nome de um campo completo (útil para comunicações rápidas)
    split_part(trim({{ column_name }}), ' ', 1)
{% endmacro %}