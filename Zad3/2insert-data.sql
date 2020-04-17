USE kino
GO

--aktor
INSERT INTO aktor
("id_aktor", "imie", "nazwisko", "data_urodzenia", "narodowosc")
VALUES
    (1, 'Patryk', 'Lisik', '1995-10-11', 'PL'),
    (2, 'Sylwia', 'Kaźmierczak', '1972-01-01', 'PL'),
    (3, 'Dorota', 'Maciejewska', '1944-11-21', 'CA'),
    (4, 'Jacek', 'Laskowski', '1966-10-14', 'ES'),
    (5, 'Michał', 'Sobczak', '1956-09-15', 'PL'),
    (6, 'Genowefa', 'Lis', '1995-10-24', 'PL'),
    (7, 'Mirosław', 'Czerwiński', '1975-10-18', 'PL'),
    (8, 'Agata', 'Gajewska', '1967-12-16', 'PL'),
    (9, 'Zofia', 'Bąk', '1989-06-19', 'PL')

--film
INSERT INTO film
("id_film", "tytul", "rok_powstania", "gatunek")
VALUES
    (1, 'Matrix', 1997, 'sci-fi'),
    (2, 'Historia Polski', 2000, 'dramat'),
    (3, 'Zycie studenta', 2011, 'dramat'),
    (4, 'Miodowe Lata', 2018, 'komedia')

--rola
INSERT INTO rola 
("id_rola", "id_aktor", "id_film")
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 2),
    (5, 4, 3),
    (6, 5, 4),
    (7, 6, 4),
    (8, 6, 2),
    (9, 7, 1)