
    
    

with all_values as (

    select
        review_sentiment as value_field,
        count(*) as n_records

    from AIRBNB.PROD.fct_reviews
    group by review_sentiment

)

select *
from all_values
where value_field not in (
    'positive','neutral','negative'
)


