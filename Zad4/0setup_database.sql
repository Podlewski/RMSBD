IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE NAME = 'kina_w_lodzi') 
    DROP DATABASE kina_w_lodzi;
GO

CREATE DATABASE kina_w_lodzi;
GO

USE kina_w_lodzi; 
GO

CREATE TABLE kino
( 
    id_kino     INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1), 
    nazwa       VARCHAR(50),
    sale        INTEGER,
    sale_3d     INTEGER,
    ulica       VARCHAR(100),
    nr_budynku  VARCHAR(10),
    nr_lokalu   VARCHAR(10),
    lokalizacja geography NOT NULL
);

CREATE SPATIAL INDEX lokalizacja_index ON kino(lokalizacja)