{# ZD 141624 repro helpers #}
{% macro repro_141624_probe() %}
  {% set q %}
    select table_catalog, table_schema, table_name, table_type, table_owner, last_altered
    from snowflake_sample_data.information_schema.tables
    where table_schema = 'TPCH_SF1' and table_name in ('NATION', 'REGION')
  {% endset %}
  {% for r in run_query(q).rows %}{{ log('PROBE ' ~ r | join(' | '), info=True) }}{% endfor %}
  {% for r in run_query("show shares like 'SAMPLE_DATA'").rows %}{{ log('SHARE ' ~ r | join(' | '), info=True) }}{% endfor %}
  {% for r in run_query("select current_role(), current_database(), current_schema()").rows %}{{ log('CTX ' ~ r | join(' | '), info=True) }}{% endfor %}
{% endmacro %}

{% macro repro_141624_create_ctrl() %}
  {% set q %}
    create table if not exists {{ target.database }}.{{ target.schema }}.repro_141624_ctrl_src as
    select 1 as id, '2020-01-01'::timestamp_ntz as loaded_at
  {% endset %}
  {% do run_query(q) %}
  {{ log('CTRL created/exists: ' ~ target.database ~ '.' ~ target.schema ~ '.repro_141624_ctrl_src', info=True) }}
{% endmacro %}

{% macro repro_141624_find_views() %}
  {% set q %}
    select table_schema, table_name, is_secure
    from snowflake_sample_data.information_schema.views
    where table_schema <> 'INFORMATION_SCHEMA'
    order by 1, 2 limit 20
  {% endset %}
  {% set rows = run_query(q).rows %}
  {{ log('VIEWCOUNT ' ~ rows | length, info=True) }}
  {% for r in rows %}{{ log('VIEW ' ~ r | join(' | '), info=True) }}{% endfor %}
{% endmacro %}
