-- ZD 141212: the customer-facing SQL, pointed at this sandbox warehouse and the last 4 hours.
{{ config(materialized='view', static_analysis='off') }}
select
    regexp_substr(query_text, '"dbt_cloud_job_id": "([0-9]+)"', 1, 1, 'e', 1) as dbt_cloud_job_id,
    user_name,
    query_type,
    count(*) as queries,
    round(sum(execution_time) / 1000) as execution_s,
    round(sum(queued_overload_time) / 1000) as queued_overload_s
from snowflake.account_usage.query_history
where warehouse_name = current_warehouse()
  and start_time >= dateadd('hour', -4, current_timestamp())
group by 1, 2, 3
order by execution_s desc
