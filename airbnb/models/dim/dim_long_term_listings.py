def model(dbt, session):
    listings = dbt.ref("dim_listings_cleansed")

    return (listings.filter(listings["minimum_nights"] >= 30)
                   .select("listing_id", "listing_name", "price"))