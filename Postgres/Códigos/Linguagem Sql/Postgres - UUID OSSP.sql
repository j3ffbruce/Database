-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Usabilidade da Extensão UUID-OSSP
-- ====================================================================================

-- Criação da Extensão --
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Geração de UUID -- 
SELECT uuid_generate_v4();