-- ========================================================
--:: Gerenciamento de Usuário
-- ========================================================

/* 

Opções para Usuário 

SUPERUSER | NOSUPERUSER | CREATEDB | NOCREATEDB  | CREATEROLE | NOCREATEROLE |
CREATEUSER | NOCREATEUSER | INHERIT | NOINHERIT | LOGIN | NOLOGIN | REPLICATION|
NOREPLICATION | BYPASSRLS | NOBYPASSRLS | CONNECTION LIMIT connlimit | 
[ ENCRYPTED | UNENCRYPTED ] PASSWORD 'password' | VALID UNTIL 'timestamp'

*/

-- Criação de Usuário
CREATE USER user_01 WITH 
PASSWORD 'qwop'
INHERIT;

CREATE USER user_02 WITH 
PASSWORD 'qwop'
INHERIT;

-- Criação de Grupo
CREATE ROLE select_group WITH NOLOGIN NOINHERIT;

-- Associação de Usuário ao Grupo
GRANT select_group TO user_01;


--Alteração de Usuário
ALTER USER user_01 WITH PASSWORD 'opqw';
ALTER USER user_03 WITH NOCREATEDB;
ALTER USER user_03 WITH SUPERUSER;
ALTER USER user_03 WITH NOSUPERUSER;

-- Remoção de Usuário
REASSIGN OWNED BY user_01 TO postgres;
DROP OWNED BY user_01;
DROP USER user_01;

-- Querys
SELECT * FROM pg_user;

-- ========================================================
-- DATABASE Permissions
-- ========================================================

-- Concede\Revoga TODAS as Permissões para uma Base de Dados
REVOKE ALL PRIVILEGES ON DATABASE permissao FROM PUBLIC;
GRANT ALL PRIVILEGES ON DATABASE permissao TO PUBLIC;

REVOKE CONNECT, CREATE, TEMPORARY, TEMP ON DATABASE permissao FROM PUBLIC;
GRANT CONNECT, CREATE, TEMPORARY, TEMP ON DATABASE permissao TO PUBLIC;

-- Exibe Privilégio(s) da(s) Database(s) | Filter: Database
SELECT 
db.datname, 
r.rolname, 
has_database_privilege(r.rolname, db.datname, 'connect') AS connect,
has_database_privilege(r.rolname, db.datname, 'create') AS create,
has_database_privilege(r.rolname, db.datname, 'temporary') AS temporary,
has_database_privilege(r.rolname, db.datname, 'temp') AS temp
FROM pg_roles r
CROSS JOIN pg_database db
WHERE r.rolcanlogin
AND db.datallowconn
AND db.datname ILIKE 'permissao'
ORDER BY db.datname, r.rolname;

-- ========================================================
-- SCHEMA Permissions
-- ========================================================

-- Concede\Revoga Permissão de Acesso ao Schema
REVOKE ALL ON SCHEMA PUBLIC FROM PUBLIC;
GRANT ALL ON SCHEMA PUBLIC FROM PUBLIC; 

REVOKE USAGE, CREATE ON SCHEMA PUBLIC FROM PUBLIC;
GRANT USAGE, CREATE ON SCHEMA PUBLIC TO PUBLIC; 

-- Concede\Revoga Permissão para Acesso às Tables no Schema
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM PUBLIC; 
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO PUBLIC; 

-- Querys Schema Acess by Users
SELECT 
schema.schema_name,
usename, 
usesuper, 
usecreatedb,
  pg_catalog.has_schema_privilege(
    usename, schema.schema_name, 'CREATE') AS "schema_create",
  pg_catalog.has_schema_privilege(
    usename, schema.schema_name, 'USAGE') AS "schema_usage"
FROM pg_user,
LATERAL (
	SELECT schema_name 
	FROM information_schema.schemata	
	WHERE schema_name NOT ILIKE 'pg_%' AND schema_name NOT ILIKE 'information_schema'
) AS schema;


-- ========================================================
-- TABLES Permission
-- ========================================================

-- Condece\Regova\Default Permissões à Tabelas
REVOKE SELECT ON TABLE public.postgres_teste1 FROM user_01;
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO user_01;
ALTER DEFAULT PRIVILEGES IN SCHEMA PUBLIC GRANT SELECT ON TABLES TO user_01;
ALTER DEFAULT PRIVILEGES IN SCHEMA PUBLIC REVOKE SELECT ON TABLES FROM user_01;
ALTER TABLE <table_name> OWNER TO <new_owner>;

-- Query de Tabelas com Privilégios Padrão
SELECT 
nspname,         -- schema name
defaclobjtype,   -- object type -- r = relation (table, view), S = sequence, f = function.
defaclacl        -- default access privileges
FROM pg_default_acl a JOIN pg_namespace b ON a.defaclnamespace=b.oid;

-- Exibe Privilégio(s) de Tabela(s) | Filter: Table
SELECT TABLE_NAME, grantee, string_agg(privilege_type, ', ') AS PRIVILEGES
FROM information_schema.role_table_grants 
WHERE TABLE_SCHEMA NOT IN('information_schema','pg_catalog')
GROUP BY grantee, TABLE_NAME;

-- ==================================================================================================
-- Automação
-- ==================================================================================================

-- Redefinição de Permissão de Objetos

CREATE EVENT TRIGGER trg_create_set_owner ON DDL_COMMAND_END
    WHEN TAG IN ('CREATE TABLE', 'CREATE TYPE', 'CREATE SEQUENCE', 'CREATE DOMAIN')
    EXECUTE PROCEDURE public.trg_create_set_owner();
	
CREATE FUNCTION public.trg_create_set_owner()
    RETURNS event_trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
  obj record;
BEGIN
 	IF current_user = '<user_name>' THEN 
 		EXECUTE 'REASSIGN OWNED BY <user_name> TO <role>';
 		RAISE NOTICE '[TIME] %', current_timestamp;
 		RAISE NOTICE '[EVENT-TRIGGERED] trg_create_set_owner';
 		RAISE NOTICE '[DESCRIPTION] DONO DO OBJETO ALTERADO PELO GATILHO';
 		RAISE NOTICE '[EVENT] %',tg_event;
	 	RAISE NOTICE '[COMMAND] %',tg_tag;
	END IF;
END;
$BODY$;

-- Restrição de Comandos

CREATE EVENT TRIGGER abort_command ON DDL_COMMAND_START
WHEN TAG IN ('GRANT', 'REVOKE')
EXECUTE PROCEDURE public.abort_command();
	
CREATE FUNCTION public.abort_command()
    RETURNS event_trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	IF current_user not similar to 'usr_dba%' THEN
	RAISE NOTICE '[TIME] %', current_timestamp;
	RAISE NOTICE '[EVENT-TRIGGERED] abort_command';
	RAISE NOTICE '[DESCRIPTION] COMANDO BLOQUEADO POR GATILHO - USUARIO ATUAL NAO POSSUI AS PERMISSOES NECESSARIAS !';
	RAISE NOTICE '[EVENT] %',tg_event;
	RAISE NOTICE '[COMMAND] %',tg_tag;
	RAISE EXCEPTION '[!] % NAO POSSUI PERMISSOES PARA USAR O COMANDO %', current_user, tg_tag;
	END IF;
END;
$BODY$;

-- ===================================================================================================
-- BENCHMARK DE TESTE para Permissões
-- ===================================================================================================

SELECT * FROM public.postgres_teste1;
CREATE TABLE public.postgres_teste1(teste uuid);
CREATE TABLE public.postgres_teste2(teste uuid);
CREATE TABLE public.postgres_teste3(teste uuid);
CREATE TABLE public.postgres_teste4(teste uuid);
CREATE SCHEMA private;
CREATE TABLE private.teste1(teste uuid);

