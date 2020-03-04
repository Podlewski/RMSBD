--2. Dodaj rezerwacje  
--nie mozna wiecej zarezerwowac miejsc na seans niz pojemnosc sali 
--drop procedure Dodaj_Rezerwacje 
--GO 

CREATE PROCEDURE Dodaj_rezerwacje(@imie     VARCHAR(100), 
                                  @nazwisko VARCHAR(100), 
                                  @tytul    VARCHAR(100), 
                                  @liczba   INT, 
                                  @data     DATE) 
AS 
  BEGIN 
      IF @imie IS NULL 
          OR @nazwisko IS NULL 
          OR @tytul IS NULL 
          OR @liczba < 0 
        BEGIN 
            PRINT 'Zbyt malo danych lub podano ujemna ilosc osob' 
        END 
      ELSE 
        BEGIN 
            DECLARE @id_seansu INT 

            SET @id_seansu = (SELECT TOP 1 id_seans 
                              FROM   seans s, 
                                     film f 
                              WHERE  @tytul = f.tytul 
                                     AND s.id_film = f.id_film 
                                     AND CONVERT(DATE, s.rozpoczecie) = @data) 

            IF @liczba > (SELECT sa.liczba_osob 
                          FROM   seans s, 
                                 sala sa 
                          WHERE  s.id_sala = sa.id_sala 
                                 AND @id_seansu = s.id_seans) 
              BEGIN 
                  PRINT 'Podano zbyt duza ilosc osob na sale' 
              END 
            ELSE 
              BEGIN 
                  DECLARE @numer INT 

                  SET @numer = 1 

                  WHILE( @numer IN (SELECT id_rezerwacja 
                                    FROM   rezerwacja) ) 
                    BEGIN 
                        SET @numer = @numer + 1; 
                    END 

                  INSERT INTO rezerwacja 
                  VALUES      (@numer, 
                               @id_seansu, 
                               @imie, 
                               @nazwisko, 
                               @liczba, 
                               30) 
              END 
        END 
  END 

GO 

--niepoprawna wartosc
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', -3, '2018-09-01'
GO

--rezerwacja na zbyt duza liczbe osob
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', 300, '2018-09-01'
GO

--poprawna rezerwacja
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', 50, '2018-09-01'
GO