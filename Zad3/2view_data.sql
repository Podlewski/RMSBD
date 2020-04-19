USE rpg; 
GO 

CREATE OR ALTER PROCEDURE ViewPodreczniki
AS 
BEGIN 
    DECLARE @XML  AS XML, 
            @hDoc AS INT 

    SELECT @XML = xml_data FROM xml_file 

    EXEC Sp_xml_preparedocument @hDoc output, @XML

    SELECT * 
    FROM   OPENXML(@hDoc, 'rpg/kolekcja/system/podręczniki/podręcznik') 
             WITH (tytuł             TEXT  'tytuł',
                   tytuł_oryginalny  TEXT  'tytuł_oryginalny',
                   liczba_stron      INT   'liczba_stron',
                   ocena_podręcznika FLOAT 'ocena_podręcznika', 
                   cena_podręcznika  FLOAT 'cena_podręcznika')

    EXEC sp_xml_removedocument @hDoc 
END
GO 

EXEC ViewPodreczniki
GO


CREATE OR ALTER PROCEDURE ViewWydawcy
AS
BEGIN
    DECLARE @XML  AS XML, 
            @hDoc AS INT

    SELECT @XML = xml_data FROM xml_file

    EXEC Sp_xml_preparedocument @hDoc output, @XML

    SELECT *
    FROM OPENXML(@hDoc, 'rpg/wydawcy/wydawca') 
        WITH (wydawca_id   TEXT,
              wydawca      TEXT '.')

    EXEC sp_xml_removedocument @hDoc 
END 
GO

EXEC ViewWydawcy
GO

CREATE OR ALTER PROCEDURE ViewGatunki
AS
BEGIN
    DECLARE @XML  AS XML, 
            @hDoc AS INT

    SELECT @XML = xml_data FROM xml_file

    EXEC Sp_xml_preparedocument @hDoc output, @XML

    SELECT *
    FROM OPENXML(@hDoc, 'rpg/gatunki/gatunek') 
        WITH (gatunek_id   TEXT,
              gatunek      TEXT '.')

    EXEC sp_xml_removedocument @hDoc 
END 
GO

EXEC ViewGatunki
GO

CREATE OR ALTER PROCEDURE ViewTypy
AS
BEGIN
    DECLARE @XML  AS XML, 
            @hDoc AS INT

    SELECT @XML = xml_data FROM xml_file

    EXEC Sp_xml_preparedocument @hDoc output, @XML

    SELECT *
    FROM OPENXML(@hDoc, 'rpg/typy/typ') 
        WITH (typ_id   TEXT,
              typ      TEXT '.')

    EXEC sp_xml_removedocument @hDoc 
END 
GO

EXEC ViewTypy
GO