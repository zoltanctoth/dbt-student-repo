{% macro generate_load_timestamp() %}
    -- 15. Padroniza a zona de tempo para registro de cargas do dbt (Metadado de auditoria)
    convert_timezone('UTC', current_timestamp()::timestamp_ntz)
{% endmacro %}

{% macro filter_incremental_data(date_column) %}
    -- 16. Atalho  para aplicar filtros incrementais nas tabelas fatos
    {% if is_incremental() %}
    where {{ date_column }} >= (select max({{ date_column }}) from {{ this }})
    {% endif %}
{% endmacro %}

{% macro get_table_row_count(model_name) %}
    -- 17. Macro auxiliar para checar volumetria rápida de tabelas (usada em testes)
    select count(*) from {{ ref(model_name) }}
{% endmacro %}