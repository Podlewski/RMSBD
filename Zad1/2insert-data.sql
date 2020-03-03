USE kino
GO

--kino
INSERT INTO kino VALUES
    (1, 1, 'Lodz'),
    (2, 2, 'Warszawa'),
    (3, 3, 'Krakow'),
    (4, 4, 'Wroclaw')

--pracownik
INSERT INTO pracownik VALUES
    (1, 1, 'Adam', 'Szubka', 2000.0),
    (2, 2, 'Wojciech', 'Wojciechowski', 2000.0),
    (3, 3, 'Anna', 'Maslak', 3000.0),
    (4, 4, 'Ewa', 'Nowak',3000.0),
    (5, 1, 'Zofia', 'Kowalska', 2000.0),
    (6, 2, 'Piotr', 'Szczesniak', 4000.0),
    (7, 3, 'Michal', 'Pawlak', 2200.0),
    (8, 4, 'Daniel', 'Mucha', 8000.0),
    (9, 3, 'Monika', 'Golec', 2000.0)

--film
INSERT INTO film VALUES
    (1, 'Matrix', 1997, 1, 'sci-fi'),
    (2, 'Historia Polski', 2000, 1, 'dramat'),
    (3, 'Zycie studenta', 2011, 2, 'dramat'),
    (4, 'Miodowe Lata', 2018, 2, 'komedia'),
    (5, 'Projekt', 2009, 4, 'komedia'),
    (6, 'Czolg', 2008, 4, 'wojenny'),
    (7, 'Czarny Kojot', 2001, 4, 'sci-fi'),
    (8, 'Duch', 2001, 4, 'horror')

--sala
INSERT INTO sala VALUES
    (1, 1, 100),
    (2, 1, 50),
    (3, 1, 150),
    (4, 1, 90),
    (5, 2, 100),
    (6, 2, 50),
    (7, 2, 160),
    (8, 2, 80),
    (9, 3, 110),
    (10, 3, 80),
    (11, 3, 150),
    (12, 3, 90),
    (13, 4, 180),
    (14, 4, 50),
    (15, 4, 120),
    (16, 4, 90)

--seans
INSERT INTO seans VALUES 
    (1, 1, 5, '2018-09-01 18:00:00'),
    (2, 2, 8, '2018-09-02 18:10:00'),
    (3, 4, 11, '2018-09-07 11:40:00'),
    (4, 3, 12, '2018-09-07 15:30:00'),
    (5, 1, 6, '2018-09-08 11:40:00'),
    (6, 2, 7, '2018-09-08 11:40:00'),
    (7, 7, 1, '2018-09-10 20:55:00'),
    (8, 6, 13, '2018-09-11 21:30:00'),
    (9, 5, 2, '2018-09-12 20:00:00'),
    (10, 8, 3, '2018-09-13 17:45:00')

--rezerwacja
INSERT INTO rezerwacja VALUES 
    (1, 1, 'Anna', 'Patyk', 5, 30.0),
    (2, 2, 'Wiktor', 'Motyl', 5, 50.0),
    (3, 3, 'Kazimierz', 'Górski', 3, 30.0),
    (4, 4, 'Irena', 'Wójcik', 2, 30.0),
    (5, 5, 'Marian', 'Chmielewski', 10, 30.0),
    (6, 6, 'Małgorzata', 'Jaworska', 1, 30.0),
    (7, 7, 'Ewa', 'Duda', 4, 36.0),
    (8, 8, 'Jakub', 'Malinowski', 3, 50.0),
    (9, 9, 'Jadwiga', 'Brzezińska', 6, 30.0),
    (10, 10, 'Roman', 'Sawicki', 3, 30.0),
    (11, 4, 'Marcin', 'Szymczak', 3, 55.0),
    (12, 6, 'Joanna', 'Baranowska', 2, 30.0),
    (13, 8, 'Maciej', 'Szczepański', 1, 60.0),
    (14, 2, 'Czesław', 'Wróbel', 2, 50.0),
    (15, 1, 'Grażyna', 'Górska', 4, 70.0)