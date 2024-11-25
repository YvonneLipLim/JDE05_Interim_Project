select table_name,column_name,pgd.description,udt_name,character_maximum_length,data_type
from pg_catalog.pg_statio_all_tables as st
inner join pg_catalog.pg_description pgd on (
    pgd.objoid = st.relid
)
inner join information_schema.columns c on (
    pgd.objsubid   = c.ordinal_position and
    c.table_schema = st.schemaname and
    c.table_name   = st.relname
)
where table_schema='public'
order by table_name,ordinal_position;