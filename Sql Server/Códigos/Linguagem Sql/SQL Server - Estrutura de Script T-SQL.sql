-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descri��o: Bloco de Programa��o T-SQL
-- ====================================================================================

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 

BEGIN TRY
	
	PRINT CHAR(13) + N'#Iniciando Script' + CHAR(13);

	PRINT N'- Configurando sessao para execucao do script ...';
	SET DATEFORMAT ymd;
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	PRINT N'- Abrindo transa��o ...';
	BEGIN TRAN

	
	-- ;THROW 51000, '- Message ', 1;  
	
	
	PRINT N'- Script Executado c/ Sucesso, efetuar o COMMIT !';

END TRY
BEGIN CATCH
	PRINT CHAR(13) + N'#Script Erro - Altera��es Revertidas !';
	THROW;
	IF @@TRANCOUNT > 0 ROLLBACK 
END CATCH	
