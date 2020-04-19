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
END 

EXEC ViewPodreczniki