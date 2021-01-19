-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Pg_stat_statements - Instalação, Parametrização e Usabilidade 
-- ====================================================================================

-- Instalação da Extensão

-- Adição do Recurso na biblioteca --
ALTER SYSTEM SET shared_preload_libraries TO 'pg_stat_statments';

-- Instalação Extensão --
CREATE EXTENSION pg_stat_statements;

-- pg_stat_statements.max Parametrização do que será rastreado (Valor Padrão: top) --
-- all: tudo, incluindo instruições alinhadas
-- top: rastrear instruções de nível superior emitdas pelo cliente
-- none:: não rastrear nada.
ALTER SYSTEM SET pg_stat_statements.track  TO 'top';

-- pg_stat_statements.max Parametriza o número max. de instruições rastreadas.
ALTER SYSTEM SET pg_stat_statements.max  TO '1000';

-- pg_stat_statements.track_utility Parametriza se os comandos diferentes de DML serão rastreados
-- Default: true
ALTER SYSTEM SET pg_stat_statements.track_utility TO 'true';

-- Efetuar limpeza da tabela de statments
SELECT pg_stat_statements_reset();

-- Listagem da Tabela de Monitoramento de Execuções efetuadas na base de dados
SELECT 
pg_database.datname,
pg_stat_statements.*
FROM pg_stat_statements
INNER JOIN pg_database ON pg_database.datdba::INT = pg_stat_statements.userid::INT
WHERE pg_database.datname ILIKE '<database_name>'
ORDER BY pg_stat_statements.max_time DESC
LIMIT 10;