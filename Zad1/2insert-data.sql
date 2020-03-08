USE kino
GO

--kino
INSERT INTO kino VALUES
    (1, 'Lodz'),
    (2, 'Warszawa'),
    (3, 'Krakow'),
    (4, 'Wroclaw')

--pracownik
INSERT INTO pracownik VALUES
    (1, 'Adam', 'Szubka', 2000.0),
    (2, 'Wojciech', 'Wojciechowski', 2000.0),
    (3, 'Anna', 'Maslak', 3000.0),
    (4, 'Ewa', 'Nowak',3000.0),
    (1, 'Zofia', 'Kowalska', 2000.0),
    (2, 'Piotr', 'Szczesniak', 4000.0),
    (3, 'Michal', 'Pawlak', 2200.0),
    (4, 'Daniel', 'Mucha', 8000.0),
    (3, 'Monika', 'Golec', 2000.0)

--rezyser
INSERT INTO rezyser VALUES
    ('Stanley', 'Kubrick', '1928/07/26', 'USA'),
    ('Janusz', 'Burczewski', '1964/3/12', 'USA'),
    ('Adams', 'Stevens', '1988/7/14', 'PL'),
    ('Andrzej', 'Olszewski', '1990/2/2', 'PL')

--film
INSERT INTO film VALUES
    ('Matrix', 1997, 1, 'sci-fi'),
    ('Historia Polski', 2000, 1, 'dramat'),
    ('Zycie studenta', 2011, 2, 'dramat'),
    ('Miodowe Lata', 2018, 2, 'komedia'),
    ('Projekt', 2009, 4, 'komedia'),
    ('Czolg', 2008, 4, 'wojenny'),
    ('Czarny Kojot', 2001, 4, 'sci-fi'),
    ('Duch', 2001, 4, 'horror')

--sala
INSERT INTO sala VALUES
    (1, 100),
    (1, 50),
    (1, 150),
    (1, 90),
    (2, 100),
    (2, 50),
    (2, 160),
    (2, 80),
    (3, 110),
    ( 3, 80),
    ( 3, 150),
    ( 3, 90),
    ( 4, 180),
    ( 4, 50),
    ( 4, 120),
    ( 4, 90)

--seans
INSERT INTO seans VALUES 
    (1, 5, '2018-09-01 18:00:00'),
    (2, 8, '2018-09-02 18:10:00'),
    (4, 11, '2018-09-07 11:40:00'),
    (3, 12, '2018-09-07 15:30:00'),
    (1, 6, '2018-09-08 11:40:00'),
    (2, 7, '2018-09-08 11:40:00'),
    (7, 1, '2018-09-10 20:55:00'),
    (6, 13, '2018-09-11 21:30:00'),
    (5, 2, '2018-09-12 20:00:00'),
    (8, 3, '2018-09-13 17:45:00')

--rezerwacja
INSERT INTO rezerwacja VALUES 
    (1, 'Anna', 'Patyk', 5, 30.0),
    (2, 'Wiktor', 'Motyl', 5, 50.0),
    (3, 'Kazimierz', 'Górski', 3, 30.0),
    (4, 'Irena', 'Wójcik', 2, 30.0),
    (5, 'Marian', 'Chmielewski', 10, 30.0),
    (6, 'Małgorzata', 'Jaworska', 1, 30.0),
    (7, 'Ewa', 'Duda', 4, 36.0),
    (8, 'Jakub', 'Malinowski', 3, 50.0),
    (9, 'Jadwiga', 'Brzezińska', 6, 30.0),
    (10, 'Roman', 'Sawicki', 3, 30.0),
    (4, 'Marcin', 'Szymczak', 3, 55.0),
    (6, 'Joanna', 'Baranowska', 2, 30.0),
    (8, 'Maciej', 'Szczepański', 1, 60.0),
    (2, 'Czesław', 'Wróbel', 2, 50.0),
    (1, 'Grażyna', 'Górska', 4, 70.0)

--aktor
INSERT INTO aktor VALUES
    ('Patryk', 'Lisik', '1995-10-11', 'PL'),
    ('Sylwia', 'Kaźmierczak', '1972-01-01', 'PL'),
    ('Dorota', 'Maciejewska', '1944-11-21', 'CA'),
    ('Jacek', 'Laskowski', '1966-10-14', 'ES'),
    ('Michał', 'Sobczak', '1956-09-15', 'PL'),
    ('Genowefa', 'Lis', '1995-10-24', 'PL'),
    ('Mirosław', 'Czerwiński', '1975-10-18', 'PL'),
    ('Agata', 'Gajewska', '1967-12-16', 'PL'),
    ('Zofia', 'Bąk', '1989-06-19', 'PL'),
    ('Marek', 'Adamczyk', '1974-07-20', 'PL'),
    ('Agata', 'Pawlak', '1931-08-27', 'PL'),
    ('Adam', 'Jankowski', '1976-11-25', 'PL'),
    ('Mieczysław', 'Adamczyk', '1999-12-22', 'ES'),
    ('Wanda', 'Czarnecka', '1977-11-20', 'PL'),
    ('Andrzej', 'Ziółkowski', '1989-04-19', 'PL'),
    ('Jarosław', 'Laskowski', '1943-06-17', 'PL'),
    ('Iwona', 'Urbańska', '1922-02-10', 'USA'),
    ('Aneta', 'Jakubowska', '1970-01-11', 'PL'),
    ('Zdzisław', 'Król', '1960-05-08', 'PL'),
    ('Maria', 'Wiśniewska', '1990-10-31', 'DE'),
    ('Grzegorz', 'Borkowski', '1991-11-07', 'FR'),
    ('Maria', 'Głowacka', '1988-12-05', 'PL'),
    ('Jakub', 'Pietrzak', '1970-11-01', 'PL'),
    ('Danuta', 'Piotrowska', '1956-07-10', 'PL'),
    ('Sebastian', 'Chmielewski', '1975-04-17', 'PL'),
    ('Adam', 'Andrzejewski', '1978-04-12', 'PL')

--rola
INSERT INTO rola VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (8, 5),
    (5, 7),
    (6, 7),
    (1, 7),
    (10, 8),
    (14, 8),
    (16, 4),
    (16, 4),
    (16, 2),
    (17, 2),
    (18, 1)

--recenzja
INSERT INTO recenzja VALUES
    (1, 8.0, 'filmweb.pl'),
    (1, 5.0, 'wp.pl'),
    (2, 7.0, 'filmweb.pl'),
    (2, 5.5, 'wp.pl'),
    (3, 6.8, 'interia.pl'),
    (3, 9.8, 'filmy.pl')