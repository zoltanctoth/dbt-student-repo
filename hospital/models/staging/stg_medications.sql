with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct -- Garante um registro por medicamento único
        -- ID único gerado a partir do nome do medicamento
        {{ dbt_utils.generate_surrogate_key(['medication']) }} as medication_id,
        
        -- Padronização do nome do remédio
        upper(trim(medication::varchar)) as medication_name,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed