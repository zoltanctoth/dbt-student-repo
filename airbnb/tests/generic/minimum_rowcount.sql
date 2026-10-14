{% test minimum_rowcount(model, min_rows) %}   
    select count(*)
    from {{ model }}
    having count(*) < {{ min_rows }}
{% endtest %}