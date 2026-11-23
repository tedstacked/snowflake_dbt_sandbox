{{ config(materialized='table', state={"lag_tolerance": "60s"}) }}
select r_regionkey, r_name from {{ source('repro_141624_share', 'region') }}
