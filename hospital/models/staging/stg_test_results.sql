with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct -- Garante apenas os status únicos (NORMAL, ABNORMAL, etc.)
        -- ID único gerado a partir do texto do resultado
        {{ dbt_utils.generate_surrogate_key(['test_results']) }} as test_result_id,
        
        -- Padronização do status do exame
        upper(trim(test_results::varchar)) as test_result_status,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed