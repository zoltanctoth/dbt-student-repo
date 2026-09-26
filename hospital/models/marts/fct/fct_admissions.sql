{{
    config(
        materialized='incremental',
        unique_key='admission_id',
        on_schema_change='fail'
    )
}}

with stg_admissions as (
    select * from {{ ref('stg_admissions') }}
    
    --  Usando a Macro 16: Controla o filtro incremental automaticamente
    {{ filter_incremental_data('admission_date') }}
)

select
    --  CHAVES
    admission_id,
    patient_id,
    doctor_id,
    hospital_id,
    insurance_provider_id,
    medication_id,
    test_result_id,
    
    --  DATAS
    admission_date,
    discharge_date,
    
    --  MÉTRICAS CALCULADAS VIA MACROS
    datediff(day, admission_date, discharge_date) as length_of_stay_days, 
    
    --  Usando a Macro 12: Identifica internações muito longas (mais de 10 dias)
    {{ is_long_stay('admission_date', 'discharge_date', threshold_days=10) }} as is_critical_long_stay,

    --  Mantendo a métrica de valor bruto original para passar no teste do schema.yml
    coalesce(billing_amount, 0.00) as billing_amount,

  --  Usando a Macro 1 + Variável Global: Aplica imposto de forma dinâmica e parametrizada
    {{ apply_hospital_tax('billing_amount', tax_rate=var('hospital_tax_rate')) }} as billing_amount_with_tax,
    
    --  Usando a Macro 3: Gera categoria financeira sem encher o código com CASE WHEN
    {{ categorize_billing_tier('billing_amount') }} as financial_tier,

    room_number,
    medical_condition,
    
    --  Usando a Macro 13: Classifica a ala médica com base na doença
    {{ group_medical_specialty('medical_condition') }} as medical_department,
    
    admission_type,
    
    -- Metadado de auditoria padronizado (Macro 15)
    {{ generate_load_timestamp() }} as data_carga_fato

from stg_admissions

qualify row_number() over (
    partition by admission_id 
    order by _loaded_at desc
) = 1