-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Função de Validação de Data
-- ====================================================================================

-->> Validador de Data
CREATE OR REPLACE FUNCTION isdate(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
  PERFORM TO_DATE(s,'YYYYMMDD')::DATE;
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql;
