with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select distinct 
        -- ID único consistente
        {{ dbt_utils.generate_surrogate_key(['doctor']) }} as doctor_id,
        
        -- Padronização: Nomes de médicos sempre em MAIÚSCULAS para consistência no BI e IA
        upper(trim(doctor::varchar)) as doctor_name,
        
        -- METADADO DE GOVERNANÇA: Data e hora exata em que o dbt processou este registo
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed