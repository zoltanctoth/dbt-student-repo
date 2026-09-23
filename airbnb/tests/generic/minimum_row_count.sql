--Video:48 customn generic tests with parameters
--Below data Tests are as part of customn tests with parameters to check minimum row count ,used this paramter in schema.yml file .The code except line no 5
{% test minimum_row_count(model, min_row_count) %}
--video:49 Setting test severity : warn or error ---below line number 5 is used to set severity='warn' in minimum_row_count.sql file but we can also configure severity='warn' in schema.yml file.     
{{ config(severity='warn') }}
SELECT
    COUNT(*) AS cnt
FROM
    {{ model }}
HAVING
    COUNT(*) < {{ min_row_count }}
{% endtest %}
