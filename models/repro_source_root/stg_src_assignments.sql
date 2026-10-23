-- ZD 138972: same shape as the customer's stg_equipmentshare__public__silver__asset_camera_assignments
with source as (

    select * from {{ source('repro_src', 'repro_138972_asset_camera_assignments') }}

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
