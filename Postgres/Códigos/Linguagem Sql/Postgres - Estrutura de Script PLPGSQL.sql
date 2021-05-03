-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Bloco Seguro de Programação PLGPSQL
-- ====================================================================================

-- Auxiliary Commands
-- 
--  RAISE EXCEPTION 'Variable changed.'
--  RAISE DEBUG
--  RAISE INFO
--  ASSERT counter = -1, 'Expect counter starts with 0';
--  GET STACKED DIAGNOSTICS var_err_context := PG_EXCEPTION_CONTEXT;
--  GET DIAGNOSTICS var_count = ROW_COUNT;
-- 
-- 	Auxiliary Notes
-- 
-- =========================================================================================================================
-- | Consulta: 
-- | Parametro: 
-- | Retorno: 
-- =========================================================================================================================

ROLLBACK; 
BEGIN TRANSACTION;

DO $$ <<main>>

DECLARE
	var_err_context varchar;
	var_count varchar;
	var_count_aux varchar;

BEGIN 

	SET TIMEZONE TO 'America/Sao_Paulo'; 
	SET CONSTRAINTS ALL IMMEDIATE;
	RAISE NOTICE E'Session Settings is done, skipping ...\n';

DECLARE
		
BEGIN 

	RAISE INFO '✔ Starting Processing';

	
		
	RAISE INFO '✔ Processing completed successfully';
	
END;
	
EXCEPTION WHEN OTHERS THEN 
		
	RAISE WARNING '❌ O processamento gerou uma excecao !';
	GET STACKED DIAGNOSTICS var_err_context := PG_EXCEPTION_CONTEXT;
	RAISE WARNING '❌ Error Name:%',SQLERRM;
	RAISE WARNING '❌ Error State:%', SQLSTATE;
	RAISE WARNING '❌ Error Context:%', CAST(var_err_context AS VARCHAR);
  
END main;
$$ LANGUAGE PLPGSQL;