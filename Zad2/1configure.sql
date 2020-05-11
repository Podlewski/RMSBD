USE kino
GO

EXEC sp_configure 'external scripts enabled', 1;
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

EXEC sp_configure 'ole automation procedures', 1;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
GO
