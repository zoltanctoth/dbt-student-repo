{% macro mask_sensitive_data(column_name, role_list=['ACCOUNTADMIN', 'SYSADMIN', 'TRANSFORM']) %}
    -- 🎯 OBJETIVO: Mascarar colunas sensíveis (LGPD/GDPR) com base na role do Snowflake.
    case 
        when current_role() in ({% for role in role_list %}'{{ role }}'{% if not loop.last %}, {% endif %}{% endfor %}) then {{ column_name }}
        else 'ACESSO RESTRITO'
    end
{% endmacro %}