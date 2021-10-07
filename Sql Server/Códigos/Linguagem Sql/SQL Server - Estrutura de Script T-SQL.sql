-- ====================================================================================
-- DBMS: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: Programming Block T-SQL
-- Keywords: T-SQL, Block Programing
-- ====================================================================================

-- SQL STRUCTURED QUERY LANGUGAGE) ----------------------------------------------------

-- Runtime (Server\Database): 00m:00s

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 

BEGIN TRY
	
	DECLARE 
	@MSG VARCHAR(MAX),
	@STEP INT = 0;
			
	SET @STEP = @STEP + 1;
	SET @MSG = CHAR(13) + '[Step: ' + CAST(@STEP AS VARCHAR) + ' -' + CONVERT(VARCHAR,GETDATE(),21) + '] Starting Script'
	RAISERROR(@MSG,0,1) WITH NOWAIT;
		
	SET DATEFORMAT ymd;
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	SET @STEP = @STEP + 1;
	SET @MSG = '[Step: ' + CAST(@STEP AS VARCHAR) + ' -' + CONVERT(VARCHAR,GETDATE(),21) + '] Opening Transaction'
	RAISERROR(@MSG,0,1) WITH NOWAIT;
		
	BEGIN TRAN
		
	-- ;THROW 51000, '- Message ', 1;  
	
	SET @STEP = @STEP + 1;
	SET @MSG = '[Step: ' + CAST(@STEP AS VARCHAR) + ' -' + CONVERT(VARCHAR,GETDATE(),21) + '] Script Finished'
	RAISERROR(@MSG,0,1) WITH NOWAIT;
	
	-- COMMIT
	
END TRY
BEGIN CATCH
	PRINT CHAR(13) + N'Error: Script Run with Error, changes undone - ROLLBACK!';
	THROW;
	IF @@TRANCOUNT > 0 ROLLBACK 
END CATCH	
