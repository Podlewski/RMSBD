USE kino
GO

CREATE OR ALTER PROCEDURE ViewAktorzy
AS
BEGIN
    SELECT id_aktor, nazwisko, data_urodzenia, narodowosc FROM aktor
    FOR XML PATH
    ('Aktor'), ROOT
    ('Aktorzy')
END
GO

CREATE OR ALTER PROCEDURE ViewFilmy
AS
BEGIN
    SELECT id_film, tytul, rok_powstania, gatunek FROM film
    FOR XML PATH
    ('Film'), ROOT
    ('Filmy')
END
GO

CREATE OR ALTER PROCEDURE ViewRole
AS
BEGIN
    SELECT id_rola, id_aktor, id_film FROM rola
    FOR XML PATH
    ('Rola'), ROOT
    ('Role')
END
GO

exec ViewAktorzy
GO

exec ViewFilmy
GO

exec ViewRole
GO