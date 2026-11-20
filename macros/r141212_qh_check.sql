{# ZD 141212: verify the dbt query comment survives in Snowflake QUERY_TEXT and test the customer-facing SQL. #}
{% macro r141212_log_rows(res) %}
  {% do log('COLUMNS: ' ~ (res.column_names | join(' | ')), info=True) %}
  {% for row in res.rows %}
    {% do log('ROW: ' ~ (row | list | join(' | ')), info=True) %}
  {% endfor %}
  {% do log('ROWCOUNT: ' ~ (res.rows | length), info=True) %}
{% endmacro %}

{% macro r141212_qh_check_is() %}
  {% set q %}
select
    query_type,
    warehouse_name,
    regexp_substr(query_text, '"dbt_cloud_job_id": "([0-9]+)"', 1, 1, 'e', 1) as dbt_cloud_job_id,
    charindex('/* {"app": "dbt"', query_text) as comment_pos,
    length(query_text) as text_len,
    left(query_text, 60) as text_start
from table(information_schema.query_history(
    end_time_range_start => dateadd('hour', -4, current_timestamp()),
    result_limit => 10000))
where query_text ilike '%r141212_control_wait%'
  and query_text not ilike '%information_schema.query_history%'
order by start_time desc
limit 20
  {% endset %}
  {% do r141212_log_rows(run_query(q)) %}
{% endmacro %}

{% macro r141212_qh_check_au() %}
  {% set q %}
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
limit 20
  {% endset %}
  {% do r141212_log_rows(run_query(q)) %}
{% endmacro %}
