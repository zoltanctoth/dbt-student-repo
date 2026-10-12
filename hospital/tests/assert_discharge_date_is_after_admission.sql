select
    admission_id,
    admission_date,
    discharge_date
from {{ ref('fct_admissions') }}
where discharge_date < admission_date
-- ⚠️ CRITÉRIO DE FALHA: O teste falha se encontrar qualquer linha onde a alta < entrada.