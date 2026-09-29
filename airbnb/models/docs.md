{% docs dim_listings_cleansed_minimum_nights %}
Minimum number of nights required to rent this property.

Keep in mind that old listings might have `minimum_nights` set
to 0 in the source tables. Our cleansing algorithm updates this to `1`.

{% enddocs %}

{% docs dim_hosts_cleansed_source_code %}
 
WITH src_listings AS (
  SELECT
    *
  FROM
    src_hosts
)
select 
  host_id,
  NVL(host_name, 'Anonymous') AS host_name,
  is_superhost,
  created_at,
  updated_at
  from src_hosts

{% enddocs %}