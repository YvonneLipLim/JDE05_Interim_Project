select table_name AS "Table Name",column_name AS "Column Name",
pgd.description AS "Description",udt_name AS "UDT Name",character_maximum_length AS "Max.Length",data_type AS "Data Type",
is_identity AS "Primary Key"
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
