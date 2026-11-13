{% snapshot repro_cameras_snapshot %}

{{
    config(
        unique_key='asset_camera_id',
        strategy='check',
        check_cols=['camera_id', 'date_uninstalled'],
    )
}}

-- ZD 138972 repro: stands in for the customer's es_companies_snapshot
select
    asset_camera_id,
    asset_id,
    camera_id,
    date_installed,
    date_uninstalled
from {{ source('repro_src_plain', 'repro_seed_strict') }}

{% endsnapshot %}
