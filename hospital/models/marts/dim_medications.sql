{{ config(materialized='table') }}

with stg_medications as (
    select * from {{ ref('stg_medications') }}
)

select
    medication_id,   -- Chave primária do medicamento
    medication_name, -- Nome do medicamento padronizado
    _loaded_at       -- Data de carga para auditoria
from stg_medications