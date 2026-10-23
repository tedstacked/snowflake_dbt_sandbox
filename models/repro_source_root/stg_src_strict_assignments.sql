-- ZD 138972: same as stg_src_assignments, but its source sets static_analysis: strict
with source as (

    select * from {{ source('repro_src_strict', 'repro_138972_asset_camera_assignments') }}

)

, current_records as (

    select
        asset_camera_id
        , asset_id
        , camera_id
        , date_installed
        , date_uninstalled
    from source

)

select * from current_records
where date_uninstalled is null
