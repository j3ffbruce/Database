-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Validações e Ajustes de Configurações Postgres
-- ====================================================================================

-- Exibe local do arquivo de configuração
SHOW config_file;

-- Exibe Todas as Configurações e Parametros Disponíveis para o Postgres (Resumido) com Descrição
SHOW ALL;

-- Exibe Todas as Configurações e Parametros Disponíveis para o Postgres (Detalhado)
SELECT 
pg_settings.*
FROM pg_settings;

-- Altera Configuração do Postgres (Exemplo: ALTER SYSTEM SET logging_collector TO OFF;)
ALTER SYSTEM SET <name_parameter> TO <value>;

-- Reseta Configurações do Postgres 
ALTER SYSTEM RESET <name_parameter>; -- Reseta apenas 01 (uma) configuração
ALTER SYSTEM RESET ALL; -- Reseta todas as configurações
