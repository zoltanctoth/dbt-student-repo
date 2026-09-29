{% macro learn_variables() %}

{% set myname = "Gomathi" %}
{{ log(" Hello " ~ myname , info=True ) }}


{{ log("The profile name is " ~ var("profile"," No profile specified") , info=True ) }}
{% endmacro %}

--dbt run-operation learn_variables --vars '{profile: DUMB}'
-- precedence of variable ( highest: command line > dbt_project.yml > default value in macro)

