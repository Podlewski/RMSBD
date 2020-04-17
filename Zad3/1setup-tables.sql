IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE  NAME = 'kino') 
DROP DATABASE kino 
GO

CREATE DATABASE kino 
GO

USE kino; 
GO 

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

CREATE TABLE "film"
(
    "id_film" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    "tytul" VARCHAR(100),
    "rok_powstania" INTEGER,
    "gatunek" VARCHAR(100)
)


CREATE TABLE "rola"
(
    "id_rola" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    "id_aktor" INTEGER,
    "id_film" INTEGER,
    CONSTRAINT SYS_FK_112 FOREIGN KEY("id_film") REFERENCES "film"("id_film"),
    CONSTRAINT SYS_FK_115 FOREIGN KEY("id_aktor") REFERENCES "aktor"("id_aktor")
)