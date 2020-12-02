-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Consulta de Volume de Dados no Postgres 
-- ====================================================================================

-- Consulta de Volume de Bases de Dados da Instância
SELECT
pg_database.datname,
pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database;

-- Consulta de Volume de Tabelas
SELECT
    relname AS "relation",
    pg_size_pretty (
        pg_total_relation_size (C .oid)
    ) AS "total_size"
FROM
    pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C .relnamespace)
WHERE
    nspname NOT IN (
        'pg_catalog',
        'information_schema'
    )
AND C .relkind <> 'i'
AND nspname !~ '^pg_toast'
ORDER BY
    pg_total_relation_size (C .oid) DESC
	
-- Consulta de Volume de Tabelas e Indices

SELECT
    t.schemaname,
    t.tablename,
    indexname,
    c.reltuples AS num_rows,
    pg_size_pretty(pg_relation_size(quote_ident(t.schemaname)::text || '.' || quote_ident(t.tablename)::text)) AS table_size,
    pg_size_pretty(pg_relation_size(quote_ident(t.schemaname)::text || '.' || quote_ident(indexrelname)::text)) AS index_size,
    CASE WHEN indisunique THEN 'Y'
        ELSE 'N'
    END AS UNIQUE,
    number_of_scans,
    tuples_read,
    tuples_fetched
FROM pg_tables t
LEFT OUTER JOIN pg_class c ON t.tablename = c.relname
LEFT OUTER JOIN (
    SELECT
        c.relname AS ctablename,
        ipg.relname AS indexname,
        x.indnatts AS number_of_columns,
        idx_scan AS number_of_scans,
        idx_tup_read AS tuples_read,
        idx_tup_fetch AS tuples_fetched,
        indexrelname,
        indisunique,
        schemaname
    FROM pg_index x
    JOIN pg_class c ON c.oid = x.indrelid
    JOIN pg_class ipg ON ipg.oid = x.indexrelid
    JOIN pg_stat_all_indexes psai ON x.indexrelid = psai.indexrelid
) AS foo ON t.tablename = foo.ctablename AND t.schemaname = foo.schemaname
WHERE t.schemaname NOT IN ('pg_catalog', 'information_schema')


-- Consulta de Volume de Coluna 
SELECT
pg_size_pretty(SUM(pg_column_size(<column_name>))) AS "Tamanho da Coluna",
pg_size_pretty(TRUNC(AVG(pg_column_size(<column_name>)),2)) AS "Valor Médio por Linha",
TRUNC(sum(pg_column_size(<column_name>)) * 100.0 / pg_total_relation_size('<table_name>'),2)::VARCHAR||'%' AS "Percentual de Ocupação da Coluna na Entidade"
FROM <table_name>;






