-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Remoção de Sessão da base de Dados
-- ====================================================================================

-- Finaliza sessões da base de dados

SELECT pg_terminate_backend(pid) 
FROM pg_stat_activity 
WHERE datname ILIKE 'database_name';