-- ====================================================================================
-- SGBD: <SQL Server>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Size Object
-- ====================================================================================

-- Lista o Volume de Todas as Tabelas
SELECT 
 OBJECT_NAME(ps.[object_id]) AS [TableName] , i.name AS [IndexName] , 
SUM(ps.row_count) AS [RowCount]
FROM sys.dm_db_partition_stats AS ps 
 INNER JOIN sys.indexes AS i 
  ON i.[object_id] = ps.[object_id] AND i.index_id = ps.index_id
WHERE i.type_desc IN ( 'CLUSTERED', 'HEAP' ) AND i.[object_id] > 100 
AND OBJECT_SCHEMA_NAME(ps.[object_id]) <> 'sys'
GROUP BY ps.[object_id] , i.name
ORDER BY SUM(ps.row_count) DESC ;


-- Exibe o volume das Tabelas
SELECT 
    s.[name] AS [schema],
    t.[name] AS [table_name],
    p.[rows] AS [row_count],
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS [size_mb],
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS [used_mb], 
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS [unused_mb]
FROM 
    sys.tables t
    JOIN sys.indexes i ON t.[object_id] = i.[object_id]
    JOIN sys.partitions p ON i.[object_id] = p.[object_id] AND i.index_id = p.index_id
    JOIN sys.allocation_units a ON p.[partition_id] = a.container_id
    LEFT JOIN sys.schemas s ON t.[schema_id] = s.[schema_id]
WHERE 
    t.is_ms_shipped = 0
    AND i.[object_id] > 255 
GROUP BY
    t.[name], 
    s.[name], 
    p.[rows]
ORDER BY 
    [size_mb] DESC