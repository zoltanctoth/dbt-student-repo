with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct -- Garante um registro por hospital
        -- ID único gerado a partir do nome do hospital
        {{ dbt_utils.generate_surrogate_key(['hospital']) }} as hospital_id,
        
        -- Padronização do nome
        upper(trim(hospital::varchar)) as hospital_name,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed