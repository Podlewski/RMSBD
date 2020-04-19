IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE  NAME = 'rpg') 
    DROP DATABASE rpg;
GO

CREATE DATABASE rpg;
GO

USE rpg; 
GO

CREATE TABLE "xml_file"
(
    "id" INTEGER IDENTITY NOT NULL PRIMARY KEY,
    "xml_data" XML
)
GO


CREATE OR ALTER PROCEDURE InsertFromXML @xmlPath VARCHAR(255) 
AS 
BEGIN 
    DECLARE @query VARCHAR(1000) 

    SET @query = 'INSERT INTO xml_file SELECT * FROM OPENROWSET (BULK ''' 
                + @xmlPath + ''', SINGLE_BLOB) AS DATA' 

    EXEC (@query) 
END 


EXEC InsertFromXML 'D:\Nauka\Git\RMSBD\Zad3\rpg.xml';
GO
