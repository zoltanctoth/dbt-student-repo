{% macro learn_logging() %}
     {# log("Call your mom!", info=True) #} -- THIS IS WORKING!
     -- {{ log("Call your sis!", info=True) }} -- THIS IS NOT WORKING!
     {{ log("Call your bro!", info=True) }}
{% endmacro %}
