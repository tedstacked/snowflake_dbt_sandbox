{{ config(materialized='table', state={"lag_tolerance": "60s"}) }}
select id, loaded_at from {{ source('repro_141624_ctrl', 'repro_141624_ctrl_src') }}
