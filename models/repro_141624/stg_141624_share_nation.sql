{{ config(materialized='table', state={"lag_tolerance": "60s"}) }}
select n_nationkey, n_name, n_regionkey from {{ source('repro_141624_share', 'nation') }}
