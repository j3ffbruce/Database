-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Práticas de Json no Postgres
-- ====================================================================================

------- Convertendo Linhas de Tabelas em Json -------

SELECT row_to_json(pg_database.*)
FROM pg_database;

------- Convertendo Linhas de Tabelas em Json (Colunas Específicas) -------
SELECT json_build_object(
'database_name', datname,
'collation', datcollate
)
FROM pg_database;

------- Agrupando JSONs -------

SELECT 
table_name,
json_agg(json_build_object('coluna',column_name))
FROM information_schema.columns
GROUP BY table_name
