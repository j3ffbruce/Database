-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Insert Statmanet
-- ====================================================================================

--- Gerador de Insert 
SELECT 
'INSERT INTO ' || table_name || ' (' || STRING_AGG(column_name,', ' ORDER BY NULL) || 
') VALUES ();'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<table_name>'
GROUP BY table_name;

--- Insert com Retorno
DO $$
DECLARE
	var_column_01 varchar;
	
BEGIN
	
	INSERT INTO public."<table_name>"
	SELECT uuid_generate_v4(), column_01, column_02
	FROM public."<table_name>"
	LIMIT 1
	RETURNING column_01
	INTO var_tb_banco;
	RAISE INFO '- Valor da Column_01 %', var_column_01;
	
END;
	
$$ LANGUAGE PLPGSQL;