{% macro classify_age_group(age_column) %}
    -- 11. Classificação universal de faixa etária do hospital
    case
        when {{ age_column }} < 12 then 'CRIANÇA'
        when {{ age_column }} between 12 and 17 then 'ADOLESCENTE'
        when {{ age_column }} between 18 and 59 then 'ADULTO'
        when {{ age_column }} >= 60 then 'IDOSO'
        else 'IDADE NÃO INFORMADA'
    end
{% endmacro %}

{% macro is_long_stay(admission_date, discharge_date, threshold_days=7) %}
    -- 12. Flag boleana para identificar internações de longa permanência
    case 
        when datediff(day, {{ admission_date }}, {{ discharge_date }}) >= {{ threshold_days }} then true
        else false
    end
{% endmacro %}

{% macro group_medical_specialty(condition_column) %}
    -- 13. Agrupa diagnósticos brutos em alas médicas específicas do hospital
    case
        when {{ condition_column }} in ('CANCER') then 'ONCOLOGIA'
        when {{ condition_column }} in ('HEART DISEASE') then 'CARDIOLOGIA'
        when {{ condition_column }} in ('ASTHMA', 'PNEUMONIA') then 'PULMONAR/RESPIRATÓRIO'
        when {{ condition_column }} in ('DIABETES', 'OBESITY') then 'ENDOCRINOLOGIA'
        else 'CLÍNICA GERAL'
    end
{% endmacro %}

{% macro check_critical_alert(test_result_column, condition_column) %}
    -- 14. Gera uma flag de alerta se exames derem anormais em doenças graves
    case 
        when {{ test_result_column }} = 'ANORMAL' and {{ condition_column }} in ('CANCER', 'HEART DISEASE') then 'CRÍTICO'
        when {{ test_result_column }} = 'ANORMAL' then 'ATENÇÃO'
        else 'ESTÁVEL'
    end
{% endmacro %}