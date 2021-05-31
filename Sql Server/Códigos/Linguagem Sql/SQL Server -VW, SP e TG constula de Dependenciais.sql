-- ====================================================================================
-- SGBD: <SQL Server>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Consultas de Dependencia entre Objetos
-- ====================================================================================

-- Método 01

SELECT OBJECT_SCHEMA_NAME ( referencing_id ) AS referencing_schema_name,
   OBJECT_NAME(referencing_id) AS referencing_entity_name,
   o.type_desc AS referencing_desciption,
   COALESCE(COL_NAME(referencing_id, referencing_minor_id), '(n/a)') AS referencing_minor_id,
   referencing_class_desc, referenced_class_desc,
   referenced_server_name, referenced_database_name, referenced_schema_name,
   referenced_entity_name,
   COALESCE(COL_NAME(referenced_id, referenced_minor_id), '(n/a)') AS referenced_column_name,
   is_caller_dependent, is_ambiguous
FROM sys.sql_expression_dependencies AS sed
INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id
WHERE referenced_id = OBJECT_ID(N'TB_CONTRATO');

-- Método 02

SELECT OBJECT_NAME(OBJECT_ID),
definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'cli_id' + '%'

-- Método 03

SP_DEPENDS 'TableName'

-- Método 04 (Para Procedimentos)

WITH stored_procedures AS (
SELECT 
o.name AS proc_name, oo.name AS table_name,
ROW_NUMBER() OVER(partition by o.name,oo.name ORDER BY o.name,oo.name) AS row
FROM sysdepends d 
INNER JOIN sysobjects o ON o.id=d.id
INNER JOIN sysobjects oo ON oo.id=d.depid
WHERE o.xtype = 'P')
SELECT SP.proc_name, SH.name,SP.table_name  FROM stored_procedures AS SP
JOIN SYS.TABLES AS T ON(T.NAME = SP.table_name)
JOIN SYS.SCHEMAS AS SH ON(SH.schema_id = T.schema_id)
WHERE row = 1
ORDER BY proc_name,table_name

-- Metodo 5

WITH T1 AS(
	SELECT
		FK_Table = FK.TABLE_NAME,
		FK_Column = CU.COLUMN_NAME,
		PK_Table = PK.TABLE_NAME,
		PK_Column = PT.COLUMN_NAME,
		Constraint_Name = C.CONSTRAINT_NAME
	FROM
		INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK
		ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK
		ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU
		ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
	INNER JOIN (
				SELECT
					i1.TABLE_NAME,
					i2.COLUMN_NAME
				FROM
					INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
				INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2
					ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
				WHERE
					i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
			   ) PT
		ON PT.TABLE_NAME = PK.TABLE_NAME
) 
	SELECT PK_Table,FK_Table FROM T1
	GROUP BY PK_TABLE, FK_TABLE
	ORDER BY PK_Table
	

	
