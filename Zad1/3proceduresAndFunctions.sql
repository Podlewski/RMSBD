--Procedura - dodaje rezerwacje  
--nie mozna wiecej zarezerwowac miejsc na seans niz pojemnosc sali 
--drop procedure DodajRezerwacje 
--GO 

CREATE
OR ALTER PROCEDURE DodajRezerwacje(@imie     VARCHAR(100), 
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

/*
--niepoprawna wartosc
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', -3, '2018-09-01'
GO

--rezerwacja na zbyt duza liczbe osob
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', 300, '2018-09-01'
GO

--poprawna rezerwacja
EXEC Dodaj_Rezerwacje 'Piotr','Pawlak', 'Matrix', 50, '2018-09-01'
GO
*/

--Procedura - zwiększa pensję pracowników danego kina
--drop procedure PodwyzkaProcentowaPracownik
CREATE OR ALTER PROCEDURE PodwyzkaProcentowaPracownik (
	@imie varchar(100),
	@nazwisko varchar(100),
	@Procent float
)
AS
BEGIN
	IF @imie IS NULL OR @Procent IS NULL or @nazwisko is null
		BEGIN
			print 'Nie podano poprawnych wartosci'
		END
	ELSE
		BEGIN
			declare @id_prac int
			set @id_prac = (select id_pracownik from pracownik where nazwisko=@nazwisko and imie = @imie)
			print @id_prac

			if @id_prac is null
				begin
					print 'Nie ma takiego pracownika!'
				end
			else
				begin
					UPDATE pracownik
					SET pensja= pensja * (100.0 + @Procent) * 0.01
					WHERE id_pracownik=@id_prac
				end
		END
END
GO

/*
-- Przyklad poprawnego wykonania procedury
SELECT * FROM pracownik WHERE imie='Michal' and nazwisko = 'Pawlak'

exec PodwyzkaProcentowaPracownik 'Michal','Pawlak', 10
GO

SELECT * FROM pracownik WHERE imie='Michal' and nazwisko = 'Pawlak'

-- Przyklad niepoprawnego wywolania
exec PodwyzkaProcentowaPracownik 'Michal','Pawlak', null
GO

-- Przyklad niepoprawnego wywolania
exec PodwyzkaProcentowaPracownik 'Adam','Skiba', 10
GO
*/

--Funkcja - oblicza koszty kina
--drop function ObliczKosztyKina
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
--przyklad dzialania
GO
SELECT id_kino, dbo.SumUpCosts(id_kino, 2018, 9) as Koszta FROM kino
GO
*/

--Wyzwalacz - dodaje rok do filmu, jeżeli nie miał go podanego
--drop trigger DodajRok
CREATE TRIGGER dodajrok 
ON film 
INSTEAD OF INSERT 
AS 
  BEGIN 
      DECLARE @rok INT 

      IF (SELECT rok_powstania FROM inserted) IS NULL 
        SET @rok = CONVERT(INT, Year(Getdate())) 
      ELSE 
        SET @rok = (SELECT rok_powstania FROM inserted) 

      INSERT INTO film 
      SELECT id_film, 
             tytul, 
             @rok, 
             id_rezyser, 
             gatunek 
      FROM   inserted 
  END 

GO

/*
--przyklad dzialania
INSERT INTO film VALUES (9, 'Kogel-mogel 4', NULL, 2, 'dramat') 
SELECT * FROM   film 
GO
*/



