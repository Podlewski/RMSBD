USE kino
GO

-- 1. Procedura - Dodanie filmu dla okreslonego rezysera
-- reżyser nie może mieć filmu z roku przed jego urodzeniem

CREATE OR ALTER PROCEDURE DodajFilm(@tytul    VARCHAR(100), 
                                    @rok      INT, 
                                    @gatunek  VARCHAR(100), 
                                    @imie     VARCHAR(100), 
                                    @nazwisko VARCHAR(100)) 
AS 
  BEGIN 
    BEGIN TRY
      DECLARE @id_rez INT, @urodziny DATE 

      SET @id_rez = (SELECT id_rezyser 
                     FROM   rezyser 
                     WHERE  nazwisko = @nazwisko 
                            AND imie = @imie) 

      IF @id_rez IS NULL
      BEGIN
        RAISERROR('Nie ma takiego reżysera', 16, 1);
      END

      SET @urodziny = (SELECT data_urodzenia 
                       FROM   rezyser 
                       WHERE  id_rezyser = @id_rez) 

      IF Year(@urodziny) > @rok 
      BEGIN
        RAISERROR('Reżyser się jeszcze nie urodził', 16, 1);
      END

      INSERT INTO film 
      VALUES      (@tytul, 
                   @rok, 
                   @id_rez, 
                   @gatunek) 
    END TRY
    
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
  END

GO 

/*
-- Poprawne wywolanie procedury 
SELECT * FROM film f, rezyser r where f.id_rezyser=r.id_rezyser and f.tytul='Nowy film'

EXEC DodajFilm 'Nowy film', 2000, 'dramat', 'Stanley', 'Kubrick'
GO

SELECT * FROM film f, rezyser r where f.id_rezyser=r.id_rezyser and f.tytul='Nowy film'

-- Próba wywolania na nieistniejacym rezyserze
EXEC DodajFilm 'Nowy film', 2000, 'dramat', 'Michal', 'Kidawa'
GO

-- Proba wywolania na roku przed data urodzenia rezysera
EXEC DodajFilm 'Nowy film', 1000, 'dramat', 'Stanley', 'Kubrick'
GO
*/

-- 2. Procedura - dodaje rezerwacje  
-- nie mozna wiecej zarezerwowac miejsc na seans niz pojemnosc sali 

CREATE OR ALTER PROCEDURE DodajRezerwacje(@imie     VARCHAR(100), 
                                          @nazwisko VARCHAR(100), 
                                          @tytul    VARCHAR(100), 
                                          @liczba   INT, 
                                          @data     DATE) 
AS 
  BEGIN 
    BEGIN TRY
      DECLARE @id_seansu INT, @numer INT 

      IF @imie IS NULL 
        OR @nazwisko IS NULL 
        OR @tytul IS NULL 
        OR @liczba < 0 
          RAISERROR('Niepoprawne dane', 16, 1)

      SET @id_seansu = (SELECT TOP 1 id_seans 
                        FROM  seans s, 
                              film f 
                        WHERE @tytul = f.tytul 
                              AND s.id_film = f.id_film 
                              AND CONVERT(DATE, s.rozpoczecie) = @data) 

      IF @id_seansu IS NULL
        RAISERROR('Nie ma takiego seansu', 16, 1) 

      IF @liczba > (SELECT sa.liczba_osob 
                    FROM   seans s, 
                           sala sa 
                    WHERE  s.id_sala = sa.id_sala 
                           AND @id_seansu = s.id_seans) 
        RAISERROR('Sala nie zmieści tylu osób', 16, 1)

      INSERT INTO rezerwacja 
      VALUES      (@id_seansu, 
                   @imie, 
                   @nazwisko, 
                   @liczba, 
                   NULL)  

    END TRY
    
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
  END 

GO 

/*
-- niepoprawna wartosc
EXEC DodajRezerwacje 'Piotr','Pawlak', 'Matrix', -3, '2018-09-01'
GO

-- rezerwacja na zbyt duza liczbe osob
EXEC DodajRezerwacje 'Piotr','Pawlak', 'Matrix', 300, '2018-09-01'
GO

-- poprawna rezerwacja
EXEC DodajRezerwacje 'Piotr','Pawlak', 'Matrix', 50, '2018-09-01'
GO
*/

-- 3. Procedura - nie mozna usunac rezysera z bazy jesli istnieje jego film 

CREATE OR ALTER PROCEDURE UsunRezysera (@imie     VARCHAR(100), 
                                        @nazwisko VARCHAR(100)) 
AS 
  BEGIN
    BEGIN TRY
      DECLARE @id_rez INT 

      SET @id_rez = (SELECT id_rezyser 
                     FROM  rezyser 
                     WHERE nazwisko = @nazwisko 
                           AND imie = @imie) 

      IF @id_rez IS NULL
      BEGIN
        RAISERROR('Nie ma takiego rezysera', 16, 1);
      END

      IF NOT EXISTS (SELECT film.id_film 
                     FROM   film, rezyser 
                     WHERE  film.id_rezyser = @id_rez) 
        BEGIN 
          DELETE FROM rezyser 
          WHERE  id_rezyser = @id_rez
          PRINT 'Usunieto rezysera ' + @nazwisko + ' ' + @imie
        END 
      ELSE 
        BEGIN 
          RAISERROR('W bazie znajdują się filmy podanego reżysera, nie można go usunąć', 16, 1); 
        END 
    END TRY

    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
  END
GO 

/*
-- istnieja filmy z takim rezyserem
EXEC UsunRezysera 'Andrzej','Olszewski'
GO

-- brak takiego rezysera
EXEC UsunRezysera 'Gaweł','Palewicz'
GO

-- poprawne usuniecie
INSERT INTO rezyser VALUES ('Anna', 'Rolka', '1960/5/2', 'PL')
EXEC UsunRezysera 'Anna', 'Rolka'
GO
*/

-- 4. Procedura - zwiększa pensję pracowników którzy zarabiają mniej od podanej kwoty do tej kwoty 

CREATE OR ALTER PROCEDURE Podwyzka (@kwota int)
AS
  BEGIN
    DECLARE Kursor CURSOR FOR SELECT id_pracownik, imie, nazwisko, pensja FROM pracownik

    DECLARE @id INT, @imie VARCHAR(50), @nazwisko VARCHAR(50), @pensja INT

    OPEN Kursor
	  FETCH NEXT FROM Kursor INTO @id, @imie, @nazwisko, @pensja

    WHILE @@FETCH_STATUS = 0
      BEGIN
      
      IF (@kwota > @pensja)
        BEGIN
        PRINT 'Zwiekszam pensje pracownika ' + @nazwisko + ' ' + @imie
        UPDATE pracownik SET pensja = @kwota WHERE id_pracownik = @id
      END
      
      FETCH NEXT FROM Kursor INTO @id, @imie, @nazwisko, @pensja
      
      END

    CLOSE Kursor
    DEALLOCATE Kursor
 END
GO

/*
-- Przyklad poprawnego wykonania procedury
EXEC Podwyzka 2100
GO
*/

-- 5. Funkcja - oblicza koszty kina

CREATE OR ALTER FUNCTION ObliczKosztyKina(@idKino  INT, 
                                          @rok     INT, 
                                          @miesiac INT) 
returns MONEY 
AS 
  BEGIN 
      DECLARE @Sum MONEY = 0 

      SET @Sum = (SELECT Sum(p.pensja) 
                  FROM kino k, 
                      rezerwacja r, 
                      seans s, 
                      sala sa, 
                      pracownik p 
                  WHERE r.id_seans = s.id_seans 
                    AND s.id_sala = sa.id_sala 
                    AND sa.id_kino = k.id_kino 
                    AND p.id_kino = k.id_kino 
                    AND Year(s.rozpoczecie) = @rok 
                    AND Month(s.rozpoczecie) = @miesiac 
                    AND k.id_kino = @idKino) 

      RETURN @Sum 
  END 

GO

/*
-- przyklad dzialania
SELECT id_kino AS 'ID Kina', dbo.ObliczKosztyKina(id_kino, 2018, 9) as Koszta FROM kino
GO
*/

-- 6. Wyzwalacz - dodaje cenę rezerwacji, jeżeli nie została podana

CREATE OR ALTER TRIGGER DodajCene 
ON rezerwacja 
INSTEAD OF INSERT 
AS 
  BEGIN 
      DECLARE @cena INT

      IF (SELECT cena FROM inserted) IS NULL
      BEGIN 
        SET @cena = (SELECT liczba_osob FROM inserted) * 20.0
      END
      ELSE
        SET @cena = (SELECT cena FROM inserted)

      INSERT INTO rezerwacja 
      SELECT id_seans, 
             imie, 
             nazwisko, 
             liczba_osob,
             CONVERT(MONEY, @cena) 
      FROM   inserted 
  END 

GO

/*
-- przyklad dzialania
INSERT INTO rezerwacja VALUES (1, 'Zbysio', 'Enowski', 3, NULL)
SELECT * FROM rezerwacja WHERE nazwisko = 'Enowski'
GO
*/

-- 7. Wyzwalacz - przenosi usunietego pracownika do tabeli byłych pracowników

CREATE OR ALTER TRIGGER UsunPracownika 
ON pracownik 
AFTER DELETE 
AS 
  BEGIN 
      INSERT INTO byly_pracownik 
      SELECT id_pracownik, 
             id_kino, 
             imie,
             nazwisko,
             pensja,
             GETDATE()      
      FROM   deleted
  END 

GO

/*
-- przyklad dzialania
INSERT INTO pracownik VALUES (3, 'Szymuś', 'Zwolniony', '1000')
DELETE FROM pracownik WHERE nazwisko = 'Zwolniony'
SELECT * from byly_pracownik
DELETE FROM byly_pracownik WHERE nazwisko = 'Zwolniony'
GO
*/

-- 8. Wyzwalacz - wypisuje informację o udanej rezerwacji

CREATE OR ALTER TRIGGER UdanaRezerwacja 
ON rezerwacja 
FOR INSERT 
AS 
  BEGIN 
    DECLARE @liczba_osob INT, @imie VARCHAR(100), @nazwisko VARCHAR(100)

    SET @liczba_osob = (SELECT liczba_osob FROM inserted)
    SET @imie = (SELECT imie FROM inserted)
    SET @nazwisko = (SELECT nazwisko  FROM inserted)

    IF @liczba_osob = 1
      PRINT 'Zarezerwowano miejsca dla 1 osoby na nazwisko: '+ @nazwisko + ' ' + @imie
    ELSE
      PRINT 'Zarezerwowano miejsca dla ' + CONVERT( VARCHAR(3), @liczba_osob) + ' osób na nazwisko: '+ @nazwisko + ' ' + @imie
  END 

GO

/*
-- przyklad dzialania
EXEC DodajRezerwacje 'Piotr','Pawlak', 'Matrix', 50, '2018-09-01'
EXEC DodajRezerwacje 'Krzyś','Pisak', 'Miodowe Lata', 1, '2020-02-01'
GO
*/