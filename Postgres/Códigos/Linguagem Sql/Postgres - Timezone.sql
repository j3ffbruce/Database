-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Práticas de Timezone no Postgres
-- ====================================================================================

------- Altera o TimeZone da Sessão -------
SET TIMEZONE TO '<region>';

------- Altera o TimeZone na Consulta -------
SELECT <column_01> AT TIME ZONE '<region>';