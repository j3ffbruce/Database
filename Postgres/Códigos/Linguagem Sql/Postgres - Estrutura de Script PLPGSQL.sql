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

	RAISE INFO '- Starting Processing';

	DROP TABLE IF EXISTS log_script_execution;
	CREATE TEMPORARY TABLE log_script_execution (json_result json);
		
	RAISE INFO '- Processing completed successfully';
	
END;
	
EXCEPTION WHEN OTHERS THEN 
		
	RAISE WARNING '[ERRO] O processamento gerou uma excecao !';
	GET STACKED DIAGNOSTICS var_err_context := PG_EXCEPTION_CONTEXT;
	RAISE WARNING '[ERRO] Error Name:%',SQLERRM;
	RAISE WARNING '[ERRO] Error State:%', SQLSTATE;
	RAISE WARNING '[ERRO] Error Context:%', CAST(var_err_context AS VARCHAR);
  
END main;
$$ LANGUAGE PLPGSQL;

-- =========================================================================================================================
-- | Consulta: Exibe log dos dados manipulados na Base de Dados pelo script
-- | Parametro: Nenhum
-- | Retorno: Json {"tabela": "", "operacao":"", "data":""}
-- =========================================================================================================================

-- 	SELECT json_agg(log_script_execution.*) "resultSQL" 
-- 	FROM log_script_execution;