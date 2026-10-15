-- ZD 138972: same shape as the customer's dim_cameras.current_assignment_start_date
-- (qualify row_number + coalesce to a date sentinel cast to timestamp_tz)
with
    cameras as (

        select camera_id, device_serial as camera_serial
        from {{ ref('repro_138972_cameras') }}

    )

    , current_asset as (

        select
            camera_id
            , asset_id as current_asset_id
            , date_installed as current_assignment_start_date
        from {{ ref('stg_repro_138972__asset_camera_assignments') }}
        where
            camera_id is not null
            and asset_id is not null
            and date_uninstalled is null
        qualify row_number() over (
            partition by camera_id
            order by date_installed desc nulls last, asset_camera_id desc
        ) = 1

    )

select
    cameras.camera_id
    , cameras.camera_serial
    , coalesce(current_asset.current_asset_id, -1) as current_asset_id
    , coalesce(
        current_asset.current_assignment_start_date, cast(cast('0001-01-01' as date) as timestamp_tz)
    ) as current_assignment_start_date
from cameras
left join current_asset
    on cameras.camera_id = current_asset.camera_id
