-- ====================================================================================
-- SGBD: <SQL Server>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Logging Message RealTime Execution
-- ====================================================================================

 SET @MSG = 'Etapa Concuída .... Rows = ' + CAST(@COUNT AS VARCHAR) + ' | Result RowCount = ' + CAST(@RWCOUNT AS VARCHAR);
 RAISERROR (@MSG, 0, 1) WITH NOWAIT;
