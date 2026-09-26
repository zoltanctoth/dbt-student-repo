with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct 
        -- ID único baseado nos dados demográficos fixos
        {{ dbt_utils.generate_surrogate_key(['name', 'gender', 'blood_type']) }} as patient_id,
        
        -- Padronização de texto para os analistas e IA
        upper(trim(name::varchar)) as patient_name,
        
        -- CORREÇÃO AQUI: Lemos 'age' da tabela bruta e renomeamos para 'patient_age'
        age::int as patient_age,
        
        upper(trim(gender::varchar)) as patient_gender,
        upper(trim(blood_type::varchar)) as blood_type,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed