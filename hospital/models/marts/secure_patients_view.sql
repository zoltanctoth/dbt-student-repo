/*******************************************************************************
📌 MODELO: secure_patients_view | MATERIALIZAÇÃO: View ou Tabela Segura
*******************************************************************************/

with dim_patients as (
    select * from {{ ref('dim_patients') }}
)

select
    patient_id,
    patient_name,
    patient_age,
    patient_gender,
    
    -- MACRO: Governança absoluta via macro 
    {{ mask_sensitive_data('blood_type') }} as blood_type,
    
    age_group

from dim_patients