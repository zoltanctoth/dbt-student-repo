select * from {{ref('dim_listings')}}
where minimun_nights < 1
limit 10