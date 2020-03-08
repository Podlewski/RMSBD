IF EXISTS(SELECT 1 
          FROM   master.dbo.sysdatabases 
          WHERE  NAME = 'kino') 
  DROP DATABASE kino 

GO 

CREATE DATABASE kino 
GO 

USE kino; 
GO 

--create tables-- 
CREATE TABLE "kino" 
( 
    "id_kino"    INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "id_manager" INTEGER, 
    "miasto"     VARCHAR(100) 
) 

CREATE TABLE "pracownik" 
( 
    "id_pracownik" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "id_kino"      INTEGER, 
    "imie"         VARCHAR(100), 
    "nazwisko"     VARCHAR(100), 
    "pensja"       MONEY, 
    CONSTRAINT sys_fk_124 FOREIGN KEY("id_kino") REFERENCES "kino"("id_kino"), 
    CONSTRAINT pracownikimieformat CHECK (imie NOT LIKE '%[^A-Z]%'), 
    CONSTRAINT pracowniknazwiskoformat CHECK (nazwisko NOT LIKE '%[^A-Z]%') 
) 

CREATE TABLE "byly_pracownik" 
( 
    "id_pracownik"    INTEGER NOT NULL PRIMARY KEY, 
    "id_kino"         INTEGER, 
    "imie"            VARCHAR(100), 
    "nazwisko"        VARCHAR(100), 
    "pensja"          MONEY, 
    "data_zwolnienia" DATE, 
    CONSTRAINT sys_fk_125 FOREIGN KEY("id_kino") REFERENCES "kino"("id_kino"), 
)

CREATE TABLE "sala" 
( 
    "id_sala"     INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "id_kino"     INTEGER, 
    "liczba_osob" INTEGER, 
    CONSTRAINT sys_fk_121 FOREIGN KEY("id_kino") REFERENCES "kino"("id_kino") 
) 

CREATE TABLE "seans" 
( 
    "id_seans"    INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "id_film"     INTEGER, 
    "id_sala"     INTEGER, 
    "rozpoczecie" DATETIME, 
    CONSTRAINT sys_fk_118 FOREIGN KEY("id_sala") REFERENCES "sala"("id_sala") 
) 

CREATE TABLE "film" 
( 
    "id_film"       INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "tytul"         VARCHAR(100), 
    "rok_powstania" INTEGER, 
    "id_rezyser"    INTEGER, 
    "gatunek"       VARCHAR(100) 
) 

CREATE TABLE "rezyser" 
( 
    "id_rezyser"     INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "imie"           VARCHAR(100), 
    "nazwisko"       VARCHAR(100), 
    "data_urodzenia" DATE, 
    "narodowosc"     VARCHAR(5), 
    CONSTRAINT rezyser_data_urodzenia CHECK (data_urodzenia > '1900/01/01'), 
    CONSTRAINT rezyserimieformat CHECK (imie NOT LIKE '%[^A-Z]%'), 
    CONSTRAINT rezysernazwiskoformat CHECK (nazwisko NOT LIKE '%[^A-Z]%') 
) 

CREATE TABLE "recenzja"
(
  "id_recenzja" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
  "id_film" INTEGER,
  "ocena" decimal,
  "autor" VARCHAR(50),
  CONSTRAINT SYS_FK_130 FOREIGN KEY("id_film") REFERENCES "film"("id_film"),
  CONSTRAINT ocenaLogika CHECK (ocena >= 0.0 and ocena <=10.0)
)

CREATE TABLE "aktor"
(
  "id_aktor" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
  "imie" VARCHAR(100),
  "nazwisko" VARCHAR(100),
  "data_urodzenia" DATE,
  "narodowosc" VARCHAR(100),
  CONSTRAINT aktor_data_urodzenia CHECK (data_urodzenia > '1900/01/01'),
  CONSTRAINT aktorImieFormat CHECK (imie not like '%[^A-Z]%'),
  CONSTRAINT aktorNazwiskoFormat CHECK (nazwisko not like '%[^A-Z]%')
)

CREATE TABLE "rola"
(
  "id_rola" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
  "id_aktor" INTEGER,
  "id_film" INTEGER,
  CONSTRAINT SYS_FK_112 FOREIGN KEY("id_film") REFERENCES "film"("id_film"),
  CONSTRAINT SYS_FK_115 FOREIGN KEY("id_aktor") REFERENCES "aktor"("id_aktor")
)

CREATE TABLE "rezerwacja" 
( 
    "id_rezerwacja" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    "id_seans"      INTEGER, 
    "imie"          VARCHAR(100), 
    "nazwisko"      VARCHAR(100), 
    "liczba_osob"   INTEGER, 
    "cena"          MONEY, 
    CONSTRAINT sys_fk_133 FOREIGN KEY("id_seans") REFERENCES "seans"("id_seans" 
    ), 
    CONSTRAINT liczba_osob_1 CHECK (liczba_osob>0), 
    CONSTRAINT rezerwacjaimieformat CHECK (imie NOT LIKE '%[^A-Z]%'), 
    CONSTRAINT rezerwacjanazwiskoformat CHECK (nazwisko NOT LIKE '%[^A-Z]%') 
) 

ALTER TABLE "seans" 
  ADD CONSTRAINT sys_fk_109 FOREIGN KEY("id_film") REFERENCES "film"("id_film") 

ALTER TABLE "film"
  ADD CONSTRAINT SYS_FK_127 FOREIGN KEY("id_rezyser") REFERENCES "rezyser"("id_rezyser")

GO