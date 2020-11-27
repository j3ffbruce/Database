-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Gerador de Insert
-- ====================================================================================


SELECT 
'INSERT INTO ' || table_name || ' (' || STRING_AGG(column_name,', ' ORDER BY NULL) || 
') VALUES ();'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<table_name>'
GROUP BY table_name;

