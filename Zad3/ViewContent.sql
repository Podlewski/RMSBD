USE kino
GO

CREATE OR ALTER PROCEDURE ExportWholeTable
AS
BEGIN
    SELECT id_aktor, nazwisko, data_urodzenia, narodowosc FROM aktor
    FOR XML PATH
    ('Aktor'), ROOT
    ('Aktorzy')
END

exec ExportWholeTable