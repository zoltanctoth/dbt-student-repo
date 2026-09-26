{% macro apply_hospital_tax(billing_column, tax_rate=0.05) %}
    -- 1. Aplica uma taxa de imposto hospitalar padrão a um valor faturado
    round({{ billing_column }} * (1 + {{ tax_rate }}), 2)
{% endmacro %}

{% macro convert_to_currency(value_column, rate=1.0, precision=2) %}
    -- 2. Converte valores financeiros baseados em uma taxa de câmbio informada
    round({{ value_column }} * {{ rate }}, {{ precision }})
{% endmacro %}

{% macro categorize_billing_tier(billing_column, low=1000, high=5000) %}
    -- 3. Classifica as internações em faixas de custo financeiro para o BI/IA
    case 
        when {{ billing_column }} < {{ low }} then 'BAIXO CUSTO'
        when {{ billing_column }} between {{ low }} and {{ high }} then 'MÉDIO CUSTO'
        when {{ billing_column }} > {{ high }} then 'ALTO CUSTO'
        else 'NÃO AVALIADO'
    end
{% endmacro %}

{% macro calculate_insurance_copay(billing_column, copay_pct=0.20) %}
    -- 4. Calcula a fatia de coparticipação que o paciente deve pagar diretamente
    round({{ billing_column }} * {{ copay_pct }}, 2)
{% endmacro %}

{% macro calculate_net_revenue(billing_column, cost_column) %}
    -- 5. Retorna a receita líquida deduzindo custos de uma operação faturada
    round({{ billing_column }} - {{ cost_column }}, 2)
{% endmacro %}