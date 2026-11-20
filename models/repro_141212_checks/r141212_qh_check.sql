-- ZD 141212: check that Fusion's dbt query comment survives in Snowflake QUERY_TEXT and that the job-id regex works.
{{ config(materialized='view', static_analysis='off') }}
select
    query_type,
    warehouse_name,
    regexp_substr(query_text, '"dbt_cloud_job_id": "([0-9]+)"', 1, 1, 'e', 1) as dbt_cloud_job_id,
    charindex('/* {"app": "dbt"', query_text) as comment_pos,
    length(query_text) as text_len
from table(information_schema.query_history(
    end_time_range_start => dateadd('hour', -4, current_timestamp()),
    result_limit => 10000))
where query_text ilike '%r141212_control_wait%'
order by start_time desc
