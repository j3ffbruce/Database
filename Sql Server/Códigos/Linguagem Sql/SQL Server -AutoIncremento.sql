-- ====================================================================================
-- SGBD: <SQL Server>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: AutoIncremento
-- ====================================================================================


DBCC CHECKIDENT ('<table_name>', RESEED, 10);  -- Reajusta o Índice do AutoIncremento de uma Tabela
SELECT IDENT_CURRENT('<table_name>'); -- Valida Ponteiro de uma Tabela