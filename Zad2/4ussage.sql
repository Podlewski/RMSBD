USE kino
GO

DROP TABLE plakat
GO
CREATE TABLE plakat
(
    plakat_id  INTEGER IDENTITY(1, 1),
    obrazek  VARBINARY(MAX) NOT NULL
);
GO

-- Wczytywanie obrazu z pliku (zrobione podczas wczytywania danych)
DECLARE @path VARCHAR(250)
SET @path = '<PATH_TO_REPO>\Zad2\Posters\FileLoad\HarryPotter.jpg'
EXEC WczytajPlik @path;
GO

SELECT * FROM plakat
GO

-- Wczytywanie wszystkich obrazów z folderu (zrobione podczas wczytywania danych)
DECLARE @path VARCHAR(250)
SET @path = '<PATH_TO_REPO>\Zad2\Posters\'
EXEC WczytajFolder @path;
GO

SELECT * FROM plakat
GO

-- Zapis obrazu do pliku
EXEC ZapiszPlik 1, '<PATH_TO_REPO>\Zad2\Posters\test.jpg';
GO

--Zmiana formatu pliku
EXEC ZmienRozszerzenie 2, 'png'
GO