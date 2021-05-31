-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Bloqueio de Tabela
-- ====================================================================================


-- ACCESS EXCLUSIVE MODE; ----- Bloqueio Total da Tabela (DML's and DDL's)
LOCK TABLE <table_name> 
IN ACCESS EXCLUSIVE MODE 
NOWAIT; -- Especifica que a TABELA LOCK não deve esperar que quaisquer travas conflitantes sejam liberadas


SELECT <column_name> FROM <table_name> FOR UPDATE; ---- Bloqueio a Nivel de Linha;


BEGIN TRANSACTION; -- Abre Transação
SET TRANSACTION ISOLATION LEVEL -- { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
ROLLBACK; -- Retorna Transação
