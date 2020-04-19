USE rpg; 
GO 

-- Insert from XML

CREATE OR ALTER PROCEDURE InsertFromXML @xmlPath VARCHAR(255) 
AS 
BEGIN 
    DECLARE @query VARCHAR(1000) 

    SET @query = 'INSERT INTO xml_file SELECT * FROM OPENROWSET (BULK ''' 
                + @xmlPath + ''', SINGLE_BLOB) AS DATA' 

    EXEC (@query) 
END
GO


EXEC InsertFromXML '<PATH_TO_REPO>\RMSBD\Zad3\rpg.xml';
GO


-- Export to XML

-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO

-- USE
EXEC xp_cmdshell 'bcp "SELECT * FROM rpg..xml_file FOR XML AUTO, ELEMENTS" queryout "C:\xml_queryout.xml" -c -w -t -T -S <SERVER_NAME>'
GO
