-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Aplicação de Operação DML INSERT com Retorno
-- ====================================================================================

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