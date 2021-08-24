-- ====================================================================================
-- SGBD: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: Programming Block T-SQL
-- ====================================================================================

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 

BEGIN TRY
	
	PRINT CHAR(13) + N'#Starting Script' + CHAR(13);

	PRINT N'- Configuring Session';
	SET DATEFORMAT ymd;
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	PRINT N'- Opening transaction ...';
	BEGIN TRAN

	
	-- ;THROW 51000, '- Message ', 1;  
	
	
	PRINT N'- Script Executed Successfully, please commit !';

END TRY
BEGIN CATCH
	PRINT CHAR(13) + N'# Script Run with Error, changes undone - ROLLBACK!';
	THROW;
	IF @@TRANCOUNT > 0 ROLLBACK 
END CATCH	
