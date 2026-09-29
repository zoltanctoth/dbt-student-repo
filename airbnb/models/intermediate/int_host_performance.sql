{{ config(
    materialized = 'view'
) }}

with host_data as (
    select
        host_id,
        host_name,
        is_superhost,
        created_at
    from {{ ref('dim_hosts_cleansed') }}
),
listing_data as (
    select
        listing_id,
        host_id,
        price,
        room_type,
        minimum_nights
    from {{ ref('dim_listings_cleansed') }}
),
host_listing_aggregates as (
    select
        host_id,
        count(distinct listing_id) as total_listings,
        avg(price) as avg_listing_price,
        min(price) as min_listing_price,
        max(price) as max_listing_price,
        sum(case when room_type = 'Entire home/apt' then 1 else 0 end) as entire_home_count,
        sum(case when room_type = 'Private room' then 1 else 0 end) as private_room_count,
        sum(case when room_type = 'Shared room' then 1 else 0 end) as shared_room_count,
        sum(case when room_type = 'Hotel room' then 1 else 0 end) as hotel_room_count,
        avg(minimum_nights) as avg_minimum_nights
    from listing_data
    group by host_id
),
host_performance as (
    select
        h.host_id,
        h.host_name,
        coalesce(l.total_listings, 0) as total_listings,
        l.avg_listing_price,
        l.min_listing_price,
        l.max_listing_price,
        coalesce(l.entire_home_count, 0) as entire_home_count,
        coalesce(l.private_room_count, 0) as private_room_count,
        coalesce(l.shared_room_count, 0) as shared_room_count,
        coalesce(l.hotel_room_count, 0) as hotel_room_count,
        l.avg_minimum_nights,
        case
            when coalesce(l.total_listings, 0) = 0 then 'inactive'
            when l.total_listings = 1 then 'single_listing'
            when l.total_listings between 2 and 5 then 'small_portfolio'
            when l.total_listings between 6 and 15 then 'medium_portfolio'
            else 'large_portfolio'
        end as portfolio_size,
        case when h.is_superhost = 't' then 'superhost' else 'standard' end as host_status,
        case
            when h.created_at is null then null
            when datediff('day', h.created_at, current_date()) < 365 then 'new_host'
            when datediff('day', h.created_at, current_date()) < 1095 then 'experienced_host'
            else 'veteran_host'
        end as host_tenure,
        case
            when coalesce(l.entire_home_count, 0) >= coalesce(l.private_room_count, 0)
                and coalesce(l.entire_home_count, 0) >= coalesce(l.shared_room_count, 0)
                and coalesce(l.entire_home_count, 0) >= coalesce(l.hotel_room_count, 0)
                then 'entire_home'
            when coalesce(l.private_room_count, 0) >= coalesce(l.shared_room_count, 0)
                and coalesce(l.private_room_count, 0) >= coalesce(l.hotel_room_count, 0)
                then 'private_room'
            when coalesce(l.shared_room_count, 0) >= coalesce(l.hotel_room_count, 0)
                then 'shared_room'
            else 'hotel_room'
        end as dominant_room_type
    from host_data h
    left join host_listing_aggregates l
        on h.host_id = l.host_id
)

select *
from host_performance
