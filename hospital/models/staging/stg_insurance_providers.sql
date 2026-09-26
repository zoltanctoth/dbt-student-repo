with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct -- Garante um registro por convênio
        -- ID único gerado a partir do nome do plano de saúde
        {{ dbt_utils.generate_surrogate_key(['insurance_provider']) }} as insurance_provider_id,
        
        -- Tratamento de nulos e padronização
        coalesce(upper(trim(insurance_provider::varchar)), 'NÃO INFORMADO') as insurance_provider_name,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed