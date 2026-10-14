

    select count(*) as rows_count
    from AIRBNB.PROD.dim_listings_cleansed    
    having count(*) < 10000000
