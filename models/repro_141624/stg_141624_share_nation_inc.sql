{{ config(materialized='incremental', unique_key='n_nationkey', state={"lag_tolerance": "60s"}) }}
select n_nationkey, n_name, n_regionkey from {{ source('repro_141624_share', 'nation') }}
{% if is_incremental() %}
where n_nationkey > (select coalesce(max(n_nationkey), -1) from {{ this }})
{% endif %}
