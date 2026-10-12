{{ config(materialized='table') }}

with stg_patients as (
    select * from {{ ref('stg_patients') }}
),

deduplicated as (
    select
        patient_id,
        coalesce(patient_name, 'PACIENTE NÃO INFORMADO') as patient_name,
        coalesce(patient_age, 0) as patient_age,
        coalesce(patient_gender, 'NÃO ESPECIFICADO') as patient_gender,
        coalesce(blood_type, 'NÃO TESTADO') as blood_type,
        _loaded_at
    from stg_patients
    
    qualify row_number() over (
        partition by patient_id 
        order by patient_age desc, _loaded_at desc
    ) = 1
)

select
    patient_id,
    patient_name,
    patient_age,
    patient_gender,
    blood_type,
    
    -- Chamando a macro de idade de forma dinâmica
    {{ classify_age_group('patient_age') }} as age_group,
    
    _loaded_at as data_carga_registro

from deduplicated