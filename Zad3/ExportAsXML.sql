-- PREPARE

-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXECUTE AS LOGIN = 'SA' ;  
GO  
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO

-- USE
EXEC xp_cmdshell 'bcp "SELECT * FROM kino.film FOR XML AUTO, ELEMENTS" queryout "/var/opt/mssql/data/XML_ex_file.xml" -c -T'