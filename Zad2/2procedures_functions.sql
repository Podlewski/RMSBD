USE kino;
GO

CREATE OR ALTER PROCEDURE WczytajPlik (@path NVARCHAR(250))
AS
  BEGIN
      DECLARE @sql NVARCHAR(500);

      SET @sql = 'INSERT INTO plakat (obrazek) '
                 + 'SELECT * FROM OPENROWSET(bulk N''' + @path
                 + ''', SINGLE_BLOB) AS obrazek;'

      EXEC(@sql)
  END
GO
