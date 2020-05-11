USE kino;
GO

CREATE OR ALTER PROCEDURE WczytajPlik (@path NVARCHAR(max))
AS
  BEGIN
      DECLARE @sql NVARCHAR(max);

      SET @sql = 'INSERT INTO plakat (obrazek) '
                 + 'SELECT * FROM OPENROWSET(bulk N''' + @path
                 + ''', SINGLE_BLOB) AS obrazek;'

      EXEC(@sql)
  END
GO


CREATE OR ALTER PROCEDURE WczytajFolder (@path NVARCHAR(max)) 
AS 
  BEGIN
      SET @path = replace(@path, '''', '''''')

      DECLARE @filenames TABLE (fname VARCHAR(max)); 
      DECLARE @cmd NVARCHAR(max) = N'exec xp_cmdshell ''dir '
                                   + @path + '*.jpg /b'''; 
      INSERT @filenames EXEC(@cmd); 

      DECLARE @sql NVARCHAR(max) = ''; 
      WITH fullnames 
           AS (SELECT fname = @path + fname 
               FROM   @filenames 
               WHERE  fname IS NOT NULL) 
      SELECT @sql = @sql + N'INSERT plakat (obrazek) VALUES ' 
                    + '((SELECT * FROM OPENROWSET(bulk ''' 
                    + fullnames.fname + N''', SINGLE_BLOB) AS obrazek));' 
      FROM   fullnames; 
      EXEC(@sql); 
  END 
GO
