{{ config(materialized='table') }}

with stg_hospitals as (
    select * from {{ ref('stg_hospitals') }}
)

select
    hospital_id,     -- Chave primária do hospital
    hospital_name,   -- Nome do hospital padronizado em maiúsculas
    _loaded_at       -- Data de carga para auditoria
from stg_hospitals