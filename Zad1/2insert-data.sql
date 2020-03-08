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

--rezyser
INSERT INTO rezyser VALUES
    (1, 'Stanley', 'Kubrick', '1928/07/26', 'USA'),
    (2, 'Janusz', 'Burczewski', '1964/3/12', 'USA'),
    (3, 'Adams', 'Stevens', '1988/7/14', 'PL'),
    (4, 'Andrzej', 'Olszewski', '1990/2/2', 'PL')

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

--aktor
INSERT INTO aktor VALUES
    (1, 'Patryk', 'Lisik', '1995-10-11', 'PL'),
    (2, 'Sylwia', 'Kaźmierczak', '1972-01-01', 'PL'),
    (3, 'Dorota', 'Maciejewska', '1944-11-21', 'CA'),
    (4, 'Jacek', 'Laskowski', '1966-10-14', 'ES'),
    (5, 'Michał', 'Sobczak', '1956-09-15', 'PL'),
    (6, 'Genowefa', 'Lis', '1995-10-24', 'PL'),
    (7, 'Mirosław', 'Czerwiński', '1975-10-18', 'PL'),
    (8, 'Agata', 'Gajewska', '1967-12-16', 'PL'),
    (9, 'Zofia', 'Bąk', '1989-06-19', 'PL'),
    (10, 'Marek', 'Adamczyk', '1974-07-20', 'PL'),
    (11, 'Agata', 'Pawlak', '1931-08-27', 'PL'),
    (12, 'Adam', 'Jankowski', '1976-11-25', 'PL'),
    (13, 'Mieczysław', 'Adamczyk', '1999-12-22', 'ES'),
    (14, 'Wanda', 'Czarnecka', '1977-11-20', 'PL'),
    (15, 'Andrzej', 'Ziółkowski', '1989-04-19', 'PL'),
    (16, 'Jarosław', 'Laskowski', '1943-06-17', 'PL'),
    (17, 'Iwona', 'Urbańska', '1922-02-10', 'USA'),
    (18, 'Aneta', 'Jakubowska', '1970-01-11', 'PL'),
    (19, 'Zdzisław', 'Król', '1960-05-08', 'PL'),
    (20, 'Maria', 'Wiśniewska', '1990-10-31', 'DE'),
    (21, 'Grzegorz', 'Borkowski', '1991-11-07', 'FR'),
    (22, 'Maria', 'Głowacka', '1988-12-05', 'PL'),
    (23, 'Jakub', 'Pietrzak', '1970-11-01', 'PL'),
    (24, 'Danuta', 'Piotrowska', '1956-07-10', 'PL'),
    (25, 'Sebastian', 'Chmielewski', '1975-04-17', 'PL'),
    (26, 'Adam', 'Andrzejewski', '1978-04-12', 'PL')

--rola
INSERT INTO rola VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 3),
    (4, 2, 4),
    (5, 8, 5),
    (6, 5, 7),
    (7, 6, 7),
    (8, 1, 7),
    (9, 10, 8),
    (10, 14, 8),
    (11, 16, 4),
    (12, 16, 4),
    (13, 16, 2),
    (14, 17, 2),
    (15, 18, 1)

--recenzja
INSERT INTO recenzja VALUES
    (1, 1, 8.0, 'filmweb.pl'),
    (2, 1, 5.0, 'wp.pl'),
    (3, 2, 7.0, 'filmweb.pl'),
    (4, 2, 5.5, 'wp.pl'),
    (5, 3, 6.8, 'interia.pl'),
    (6, 3, 9.8, 'filmy.pl')