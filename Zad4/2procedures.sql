USE kina_w_lodzi
GO

-- Procedura #1: Wyświetl dane o kinie po Id
CREATE OR ALTER PROCEDURE ToString(@id int = NULL)
AS 
BEGIN
    IF @id is null
        SELECT id_kino
            ,nazwa
            ,sale
            ,ulica
            ,nr_budynku
            ,lokalizacja.Lat AS 'Szerokość'
            ,lokalizacja.Long AS 'Długość'
        FROM kino
    ELSE
        SELECT id_kino
            ,nazwa
            ,sale
            ,ulica
            ,nr_budynku
            ,lokalizacja.Lat AS 'Szerokość'
            ,lokalizacja.Long AS 'Długość'
            FROM kino
        WHERE id_kino = @id
END
GO

EXEC ToString 1
EXEC ToString
GO

-- Procedura #2: Oblicz odległość miedzy kinami po nazwach
CREATE OR ALTER PROCEDURE ObliczOdlegloscMiedzyKinami
    @name1 varchar(255),
    @name2 varchar(255)
AS
BEGIN
    DECLARE @kino1 geography,
            @kino2 geography
    
    SET @kino1 = (
        SELECT lokalizacja
        FROM kino
        WHERE nazwa like '%' + @name1 + '%'
    )
    SET @kino2 = (
        SELECT lokalizacja
        FROM kino
        WHERE nazwa like '%' + @name2 + '%'
    )

    DECLARE @distance FLOAT = ROUND(@kino1.STDistance(@kino2), 2)

    PRINT N'Odległość między kinami to ' + (CAST(@distance as nvarchar)) + ' metrów.'
END
GO

EXEC ObliczOdlegloscMiedzyKinami 'manufaktura', 'multikino'
GO

-- Procedura #4: Dodaj nowe kino wraz z lokalizacją
CREATE OR ALTER PROCEDURE DodajKino
    @nazwa VARCHAR(50),
    @sale INTEGER,
    @ulica VARCHAR(100),
    @nr_budynku VARCHAR(10),
    @wspolrzedna1 varchar(100),
    @wspolrzedna2 varchar(100)
AS
BEGIN
    DECLARE @geometria varchar(1000)
    SET @geometria = 'POINT ( +' + @wspolrzedna2 + ' ' + @wspolrzedna1 + ')'

    INSERT INTO kino
        (nazwa, sale, ulica, nr_budynku, lokalizacja)
    VALUES
        (@nazwa, @sale, @ulica, @nr_budynku, geography::STPointFromText(@geometria, 4326))
END
GO

EXEC DodajKino 'test', 14, 'Drewnowska', '58', '51.780670', '19.446750'
GO