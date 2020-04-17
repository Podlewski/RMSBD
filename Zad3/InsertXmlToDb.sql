USE kino
GO

INSERT INTO Aktor
    (imie, nazwisko, data_urodzenia, narodowosc)
SELECT
    -- MY_XML.Aktor.query('id_aktor').value('.', 'INTEGER'),
    MY_XML.Aktor.query('imie').value('.', 'VARCHAR(100)'),
    MY_XML.Aktor.query('nazwisko').value('.', 'VARCHAR(100)'),
    MY_XML.Aktor.query('data_urodzenia').value('.', 'DATE'),
    MY_XML.Aktor.query('narodowosc').value('.', 'VARCHAR(100)')
FROM (SELECT CAST(MY_XML AS xml)
    FROM OPENROWSET(BULK '/var/opt/mssql/data/Aktorzy.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Aktorzy/Aktor') AS MY_XML (Aktor);

-- delete from Aktor
-- delete from Rola