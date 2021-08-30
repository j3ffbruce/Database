-- ====================================================================================
-- DBMS: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: Logging Message RealTime Execution
-- ====================================================================================

 SET @MSG = 'Step Completed.... Rows = ' + CAST(@COUNT AS VARCHAR) + ' | Result RowCount = ' + CAST(@RWCOUNT AS VARCHAR);
 RAISERROR (@MSG, 0, 1) WITH NOWAIT;
