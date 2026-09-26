{{ config(materialized='table') }}

with stg_insurance_providers as (
    select * from {{ ref('stg_insurance_providers') }}
)

select
    insurance_provider_id,   -- Chave primária do plano de saúde
    insurance_provider_name, -- Nome do plano (com tratamento de nulos)
    _loaded_at               -- Data de carga para auditoria
from stg_insurance_providers