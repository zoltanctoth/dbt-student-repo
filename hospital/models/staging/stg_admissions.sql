with source_data as (
    select * from {{ source('kaggle_healthcare', 'RAW_HEALTHCARE_DATA') }}
),

renamed as (
    select
        --  CHAVES SUBSTITUTAS (IDs) ÚNICAS GERADAS VIA HASH MD5
        {{ dbt_utils.generate_surrogate_key([
            'name', 
            'date_of_admission', 
            'medical_condition', 
            'billing_amount', 
            'room_number'
        ]) }} as admission_id,
        
        {{ dbt_utils.generate_surrogate_key(['name', 'gender', 'blood_type']) }} as patient_id,
        {{ dbt_utils.generate_surrogate_key(['doctor']) }} as doctor_id,
        {{ dbt_utils.generate_surrogate_key(['hospital']) }} as hospital_id,
        {{ dbt_utils.generate_surrogate_key(['insurance_provider']) }} as insurance_provider_id,
        {{ dbt_utils.generate_surrogate_key(['medication']) }} as medication_id,
        {{ dbt_utils.generate_surrogate_key(['test_results']) }} as test_result_id,
        
        -- Conversão de datas
        date_of_admission::date as admission_date,
        discharge_date::date as discharge_date,
        
        -- Padronização de textos e limpeza
        upper(trim(medical_condition::varchar)) as medical_condition,
        upper(trim(admission_type::varchar)) as admission_type,
        upper(trim(hospital::varchar)) as hospital_name,
        
        -- Tratamento de nulos na operadora de saúde
        coalesce(upper(trim(insurance_provider::varchar)), 'NÃO INFORMADO') as insurance_provider,
        
        -- Tipagem numérica e financeira
        billing_amount::decimal(10,2) as billing_amount,
        room_number::int as room_number,
        
        -- Metadado de auditoria
        current_timestamp() as _loaded_at
        
    from source_data
)

select * from renamed