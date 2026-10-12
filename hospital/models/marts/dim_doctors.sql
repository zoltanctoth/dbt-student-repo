{{ config(materialized='table') }}

with stg_doctors as (
    select * from {{ ref('stg_doctors') }}
)

select
    doctor_id,
    
    -- Se o nome do médico vier nulo por erro do sistema, a IA saberá tratar
    coalesce(doctor_name, 'MÉDICO PLANTONISTA GENÉRICO') as doctor_name,
    
    _loaded_at as data_carga_registro
from stg_doctors

-- Testando o disparo automatizado do Slim CI no GitHub Actions