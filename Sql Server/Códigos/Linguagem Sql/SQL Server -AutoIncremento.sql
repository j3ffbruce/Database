-- ====================================================================================
-- DBMS: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: AutoIncrement
-- ====================================================================================

DBCC CHECKIDENT ('<table_name>', RESEED, 10);  -- Readjusts the AutoIncrement Index of a Table
SELECT IDENT_CURRENT('<table_name>'); -- Validate Pointer of a Table