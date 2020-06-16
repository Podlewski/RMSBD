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

/*
-- Przykłady użycia:
EXEC ToString 1
EXEC ToString
*/

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

/*
-- Przykład użycia:
EXEC ObliczOdlegloscMiedzyKinami 'manufaktura', 'multikino'
GO
*/


-- Procedura #3: Policz oraz wypisz kina w danym obszarze
CREATE OR ALTER PROCEDURE WypiszKinaWObszarze (@geometria VARCHAR(MAX))
AS
BEGIN
    DECLARE @obszar geography, @bool bit
    SET @geometria = 'POLYGON((' + @geometria + '))'
    SET @obszar = geography::STPolyFromText(@geometria, 4326)
    SET @bool = 0

    DECLARE Kursor CURSOR FOR SELECT nazwa, lokalizacja FROM kino

    DECLARE @nazwa VARCHAR(100), @lokalizacja geography 
    OPEN Kursor
    FETCH NEXT FROM Kursor INTO @nazwa, @lokalizacja

    WHILE @@FETCH_STATUS = 0
      BEGIN
        IF (@lokalizacja.STIntersects(@obszar) = 1)
        BEGIN
          SET @bool = 1
          PRINT(@nazwa)
        END
        
        FETCH NEXT FROM Kursor INTO @nazwa, @lokalizacja
        
      END

      IF(@bool = 0)
        PRINT('Nie ma kin w obsarze')

    CLOSE Kursor
    DEALLOCATE Kursor
  END
GO

/*
-- Przykłady użycia:

-- Wszystkie kina
EXEC WypiszKinaWObszarze '19.4 51.7, 19.5 51.7, 19.5 51.8, 19.4 51.8, 19.4 51.7'
GO

-- Obszar nie obejmujący kin
EXEC WypiszKinaWObszarze '18.4 51.7, 18.5 51.7, 18.5 51.8, 18.4 51.8, 18.4 51.7'
GO

--  Przykładowe kina #1
EXEC WypiszKinaWObszarze '19.44 51.75, 19.46 51.75, 19.46 51.77, 19.44 51.77, 19.44 51.75'
GO

-- Przykładowe kina #2
EXEC WypiszKinaWObszarze '19.45 51.74, 19.47 51.74, 19.47 51.76, 19.45 51.76, 19.45 51.74'
GO
*/


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
    DECLARE @geometria varchar(MAX)
    SET @geometria = 'POINT ( +' + @wspolrzedna2 + ' ' + @wspolrzedna1 + ')'

    INSERT INTO kino
        (nazwa, sale, ulica, nr_budynku, lokalizacja)
    VALUES
        (@nazwa, @sale, @ulica, @nr_budynku, geography::STPointFromText(@geometria, 4326))
END
GO

/*
-- Przykład użycia:
EXEC DodajKino 'test', 14, 'Drewnowska', '58', '51.780670', '19.446750'
GO
*/
