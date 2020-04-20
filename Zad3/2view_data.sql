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
			       system_gry    	 TEXT  '../../nazwa',
                   tytuł_oryginalny  TEXT  'tytuł_oryginalny',
                   liczba_stron      INT   'liczba_stron',
                   ocena_podręcznika FLOAT 'ocena_podręcznika', 
                   cena_podręcznika  FLOAT 'cena_podręcznika')

    EXEC sp_xml_removedocument @hDoc 
END
GO 

EXEC ViewPodreczniki
GO


CREATE OR ALTER PROCEDURE ViewSystemy
AS 
BEGIN 
    DECLARE @XML  AS XML, 
            @hDoc AS INT 

    SELECT @XML = xml_data FROM xml_file 

	EXEC Sp_xml_preparedocument @hDoc output, @XML

	CREATE TABLE #system_temp
	(
		nazwa	    VARCHAR(100),
		gatunek_id  VARCHAR(5),
		gatunek     VARCHAR(25),
		wydawca_id  VARCHAR(5),
		wydawca     VARCHAR(50),
		podreczniki INT,
		format      VARCHAR(5)
	);

	INSERT INTO #system_temp 
				(nazwa, 
				 gatunek_id, 
				 wydawca_id,
				 format) 
	SELECT * 
	FROM   OPENXML(@hDoc, 'rpg/kolekcja/system') 
			  WITH (nazwa      VARCHAR(100) 'nazwa', 
					gatunek_id VARCHAR(5), 
					wydawca_id VARCHAR(5),
					format     VARCHAR(5) 'format') 

	UPDATE a 
	SET    a.wydawca = b.wydawca 
	FROM   #system_temp AS a 
		   INNER JOIN OPENXML(@hDoc, 'rpg/wydawcy/wydawca') 
						 WITH (wydawca_id VARCHAR(10), 
							   wydawca    VARCHAR(25) '.') AS b 
				   ON a.wydawca_id = b.wydawca_id; 

	UPDATE a 
	SET    a.gatunek = b.gatunek 
	FROM   #system_temp AS a 
		   INNER JOIN OPENXML(@hDoc, 'rpg/gatunki/gatunek') 
						 WITH (gatunek_id VARCHAR(10), 
							   gatunek    VARCHAR(25) '.') AS b 
				   ON a.gatunek_id = b.gatunek_id; 

	CREATE TABLE #podreczniki_temp
	(
		nazwa	    VARCHAR(100),
		podreczniki INT
	)

	INSERT INTO #podreczniki_temp 
			(nazwa, 
			 podreczniki) 
	SELECT nazwa, COUNT(tytuł) AS podreczniki
	FROM OPENXML(@hDoc, 'rpg/kolekcja/system/podręczniki/podręcznik') 
						 WITH (nazwa VARCHAR(100) '../../nazwa', 
							   tytuł VARCHAR(100) 'tytuł')
						 GROUP BY nazwa

	UPDATE a 
	SET    a.podreczniki = b.podreczniki 
	FROM   #system_temp AS a 
		   INNER JOIN #podreczniki_temp AS B
		   ON a.nazwa = b.nazwa

	EXEC sp_xml_removedocument @hDoc

	SELECT nazwa, gatunek, wydawca, podreczniki, format FROM #system_temp;

	DROP TABLE #system_temp
END
GO 

EXEC ViewSystemy
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