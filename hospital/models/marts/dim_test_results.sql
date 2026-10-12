{{ config(materialized='table') }}

with stg_test_results as (
    select * from {{ ref('stg_test_results') }}
)

select
    test_result_id,     -- Chave primária do status do exame
    test_result_status, -- Status (NORMAL, ABNORMAL, INCONCLUSIVE)
    _loaded_at          -- Data de carga para auditoria
from stg_test_results