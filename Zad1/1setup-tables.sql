USE master 

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
     "id_kino"    INTEGER NOT NULL PRIMARY KEY, 
     "id_manager" INTEGER, 
     "miasto"     VARCHAR(100) 
  ) 

CREATE TABLE "pracownik" 
  ( 
     "id_pracownik" INTEGER NOT NULL PRIMARY KEY, 
     "id_kino"      INTEGER, 
     "imie"         VARCHAR(100), 
     "nazwisko"     VARCHAR(100), 
     "pensja"       MONEY, 
     CONSTRAINT sys_fk_124 FOREIGN KEY("id_kino") REFERENCES "kino"("id_kino"), 
     CONSTRAINT pracownikimieformat CHECK (imie NOT LIKE '%[^A-Z]%'), 
     CONSTRAINT pracowniknazwiskoformat CHECK (nazwisko NOT LIKE '%[^A-Z]%') 
  ) 

CREATE TABLE "sala" 
  ( 
     "id_sala"     INTEGER NOT NULL PRIMARY KEY, 
     "id_kino"     INTEGER, 
     "liczba_osob" INTEGER, 
     CONSTRAINT sys_fk_121 FOREIGN KEY("id_kino") REFERENCES "kino"("id_kino") 
  ) 

CREATE TABLE "seans" 
  ( 
     "id_seans"    INTEGER NOT NULL PRIMARY KEY, 
     "id_film"     INTEGER, 
     "id_sala"     INTEGER, 
     "rozpoczecie" DATETIME, 
     CONSTRAINT sys_fk_118 FOREIGN KEY("id_sala") REFERENCES "sala"("id_sala") 
  ) 

CREATE TABLE "film" 
  ( 
     "id_film"       INTEGER NOT NULL PRIMARY KEY, 
     "tytul"         VARCHAR(100), 
     "rok_powstania" INTEGER, 
     "id_rezyser"    INTEGER, 
     "gatunek"       VARCHAR(100) 
  ) 

CREATE TABLE "rezerwacja" 
  ( 
     "id_rezerwacja" INTEGER NOT NULL PRIMARY KEY, 
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

GO