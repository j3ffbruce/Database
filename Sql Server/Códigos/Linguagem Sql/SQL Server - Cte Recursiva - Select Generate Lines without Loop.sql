
-- ================================================ ====================================
-- DBMS: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: CteRecursive
-- ==================================================================================== 


-- EXAMPLE:

-- X3 CONTRACTS
-- X6 PLOTS EACH
-- X18 LINES



DECLARE  @QTD_LINHAS INT, @QTD_CONTRATO INT, @QTD_PARCELA INT;


SET @QTD_CONTRATO = 10;
SET @QTD_PARCELA = 10;
SET @QTD_LINHAS = @QTD_CONTRATO * @QTD_PARCELA;

WITH T1 AS(
	SELECT 1 AS CONTADOR_1, 1 AS CONTADOR_2
	UNION ALL
	SELECT CONTADOR_1 + 1,
	CASE WHEN CONTADOR_1 % @QTD_PARCELA = 0
	THEN CONTADOR_2 + 1 ELSE CONTADOR_2 
	END 
	FROM T1 WHERE CONTADOR_1 < @QTD_LINHAS 
)
	SELECT CONTADOR_2,
		   RANK() OVER(PARTITION BY CONTADOR_2 ORDER BY CONTADOR_1 ) 
	FROM T1


