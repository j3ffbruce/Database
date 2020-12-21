-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Usabilidade da Extensão DBlink
-- ====================================================================================

-- Gera Query Dblink para um Tabela 

SELECT 
E'SELECT * \n' || 
E'FROM dblink(''\n' ||
E'host= \n'||
E'dbname= \n'||
E'user= \n'||
E'password= '',\n'||
E'''SELECT \n' || STRING_AGG( table_name ||'.'|| column_name, E', \n') || 
E'\nFROM ' || table_name || E''')\n' ||
E'link(\n'||
STRING_AGG( column_name || ' ' || data_type, E', \n') || ');'
FROM information_schema.columns
WHERE table_name ='<table_name>'
GROUP BY table_name;
