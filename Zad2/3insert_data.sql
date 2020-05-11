USE kino; 
GO 

DECLARE @path VARCHAR(250)
SET @path = 'D:\Nauka\Git\RMSBD\Zad2\Posters\FileLoad\HarryPotter.jpg'
EXEC WczytajPlik @path;
GO

SELECT * FROM plakat
GO


INSERT INTO film (tytul, rok_powstania, gatunek, plakat_id) VALUES
    ('Matrix', 1997, 'sci-fi', 1),
    ('Władca Pierścieni: Drużyna Pierścienia', 2001, 'fantasy', 2),
    ('Harry Potter i Kamień Filozoficzny', 2001, 'fantasy', 3),
    ('Piraci z Karaibów: Klątwa Czarnej Perły', 2003, 'fantasy', 4),
    ('Iron Man', 2008, 'sci-fi', 5)
