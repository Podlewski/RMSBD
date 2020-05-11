USE kino; 
GO 

DECLARE @path VARCHAR(250)
SET @path = '<PATH_TO_REPO>\Zad2\Posters\FileLoad\HarryPotter.jpg'
EXEC WczytajPlik @path;
GO

SELECT * FROM plakat
GO

DECLARE @path VARCHAR(250)
SET @path = '<PATH_TO_REPO>\Zad2\Posters\'
EXEC WczytajFolder @path;
GO

SELECT * FROM plakat
GO

INSERT INTO film (tytul, rok_powstania, gatunek, plakat_id) VALUES
    ('Matrix', 1997, 'sci-fi', 4),
    ('Władca Pierścieni: Drużyna Pierścienia', 2001, 'fantasy', 3),
    ('Harry Potter i Kamień Filozoficzny', 2001, 'fantasy', 1),
    ('Piraci z Karaibów: Klątwa Czarnej Perły', 2003, 'fantasy', 5),
    ('Iron Man', 2008, 'sci-fi', 2)

INSERT INTO aktor (imie, nazwisko, data_urodzenia, narodowosc) VALUES
    ('Keanu', 'Reeves', '1964-09-02', 'CA'),
    ('Laurence', 'Fishburne', '1961-07-30', 'US'),
    ('Elijah', 'Wood', '1981-01-28', 'US'),
    ('Ian', 'McKellen', '1939-05-25', 'GB'),
    ('Daniel', 'Radcliffe', '1989-07-23', 'GB'),
    ('Richard', 'Harris', '1930-10-01', 'IR'),
    ('Johnny', 'Depp', '1963-06-09', 'US'),
    ('Geoffrey', 'Rush', '1951-07-06', 'AU'),
    ('Robert', 'DowneyJr', '1965-04-04', 'US'),
    ('Gwyneth', 'Paltrow', '1972-09-27', 'US')

INSERT INTO rola (id_aktor, id_film) VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 3),
    (6, 3),
    (7, 4),
    (8, 4),
    (9, 5),
    (10, 5)
