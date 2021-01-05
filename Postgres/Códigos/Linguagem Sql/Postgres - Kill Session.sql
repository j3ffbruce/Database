-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descri��o: Remo��o de Sess�o da base de Dados
-- ====================================================================================

-- Finaliza sess�es da base de dados

SELECT pg_terminate_backend(pid) 
FROM pg_stat_activity 
WHERE datname ILIKE 'database_name';