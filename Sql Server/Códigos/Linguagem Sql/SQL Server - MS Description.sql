-- ====================================================================================
-- DBMS: <SQL Server>
-- Author: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Description: Ms Description
-- ====================================================================================


-- Getting all column descriptions from a Table

SELECT u.name + '.' + t.name AS 'Schema/Table Names' ,
       -- td.value AS 'Table Desc' ,
       c.name AS 'Column Name' ,
       cd.value AS 'Column Desc'
FROM sysobjects AS t
INNER JOIN sysusers AS u ON u.uid = t.uid
LEFT OUTER JOIN sys.extended_properties AS td ON td.major_id = t.id
       AND td.minor_id = 0
       AND td.name = 'MS_Description'
INNER JOIN syscolumns AS c ON c.id = t.id
LEFT OUTER JOIN sys.extended_properties AS cd ON cd.major_id = c.id
       AND cd.minor_id = c.colid
       AND cd.name = 'MS_Description'
WHERE t.type = 'u'
       AND NOT cd.value IS NULL
ORDER BY t.name, c.colorder
 
-- Getting all the descriptions from a TableSELECT c.name AS Field,
       t.name AS Type,
       c.Precision,
       c.Scale,
       c.is_nullable,
       c.collation_name
FROM sys.columns AS c
INNER JOIN sys.types AS t ON t.system_type_id = c.system_type_id
WHERE object_id = object_id('<insert_table_name>')
ORDER BY column_id
 
-- Adding Description to Table 
EXEC sys.sp_addextendedproperty
     @name = N'MS_Description',
     @value = N'Street address information for customers, employees, and vendors.',
     @level0type = N'SCHEMA', @level0name = 'Person',
     @level1type = N'TABLE', @level1name = 'Address';
GO
 
-- Adding Column Description
EXEC sys.sp_addextendedproperty
     @name = N'MS_Description',
     @value = 'Postal code is a required column.',
     @level0type = N'SCHEMA', @level0name = 'Person',
     @level1type = N'TABLE', @level1name = 'Address',
     @level2type = N'COLUMN', @level2name = 'PostalCode';
GO
 
-- Updating Description in a Column
EXEC sys.sp_updateextendedproperty
     @name = N'MS_Description' ,
     @value = 'Employee ID must be unique.' ,
     @level0type = N'SCHEMA', @level0name = 'dbo' ,
     @level1type = N'TABLE', @level1name = 'T1' ,
     @level2type = N'COLUMN', @level2name = 'id';
GO
 
-- Updating a Function Description
EXEC sys.sp_addextendedproperty
     @name = N'MS_Description',
     @value = N'Performs LTRIM(RTRIM()) on input string. Optionally loops to convert all double-spaces to single-spaces.',
     @level0type = N'SCHEMA', @level0name = 'dbo',
     @level1type = N'FUNCTION', @level1name = 'fn_Trim';
GO
