USE kino
GO

/*
use kino
delete from Rola
delete from Aktor
delete from Film
*/

INSERT INTO Aktor
    (id_aktor, imie, nazwisko, data_urodzenia, narodowosc)
SELECT
    XML_DOC.Aktor.query('id_aktor').value('.', 'INTEGER'),
    XML_DOC.Aktor.query('imie').value('.', 'VARCHAR(100)'),
    XML_DOC.Aktor.query('nazwisko').value('.', 'VARCHAR(100)'),
    XML_DOC.Aktor.query('data_urodzenia').value('.', 'DATE'),
    XML_DOC.Aktor.query('narodowosc').value('.', 'VARCHAR(100)')
FROM (SELECT CAST(XML_DOC AS xml)
    FROM OPENROWSET(BULK '/var/opt/mssql/data/Aktorzy.xml', SINGLE_BLOB) AS T(XML_DOC)) AS T(XML_DOC)
      CROSS APPLY XML_DOC.nodes('Aktorzy/Aktor') AS XML_DOC (Aktor);

INSERT INTO Film
    ("id_film", "tytul", "rok_powstania", "gatunek")
SELECT
    XML_DOC.Film.query('id_film').value('.', 'INTEGER'),
    XML_DOC.Film.query('tytul').value('.', 'VARCHAR(100)'),
    XML_DOC.Film.query('rok_powstania').value('.', 'INTEGER'),
    XML_DOC.Film.query('gatunek').value('.', 'VARCHAR(100)')
FROM (SELECT CAST(XML_DOC AS xml)
    FROM OPENROWSET(BULK '/var/opt/mssql/data/Film.xml', SINGLE_BLOB) AS T(XML_DOC)) AS T(XML_DOC)
      CROSS APPLY XML_DOC.nodes('Filmy/Film') AS XML_DOC (Film);

INSERT INTO Rola
    ("id_rola", "id_aktor", "id_film")
SELECT
    XML_DOC.Rola.query('id_rola').value('.', 'INTEGER'),
    XML_DOC.Rola.query('id_aktor').value('.', 'INTEGER'),
    XML_DOC.Rola.query('id_film').value('.', 'INTEGER')
FROM (SELECT CAST(XML_DOC AS xml)
    FROM OPENROWSET(BULK '/var/opt/mssql/data/Rola.xml', SINGLE_BLOB) AS T(XML_DOC)) AS T(XML_DOC)
      CROSS APPLY XML_DOC.nodes('Role/Rola') AS XML_DOC (Rola);