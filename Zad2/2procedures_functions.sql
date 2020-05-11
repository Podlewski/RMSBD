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
      DECLARE @cmd NVARCHAR(max), @sql NVARCHAR(max)
      SET @path = replace(@path, '''', '''''')

      DECLARE @filenames TABLE (fname VARCHAR(max)); 
      SET @cmd = N'exec xp_cmdshell ''dir ' + @path + '*.jpg /b'''; 
      INSERT @filenames EXEC(@cmd); 
      SET @cmd = N'exec xp_cmdshell ''dir ' + @path + '*.png /b'''; 
      INSERT @filenames EXEC(@cmd); 

      SET @sql = ''; 
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


CREATE OR ALTER PROCEDURE ZapiszPlik (@id INT, @path NVARCHAR(max)) 
AS 
  BEGIN
      DECLARE @image VARBINARY(max);
      DECLARE @obj INT

      SELECT @image = (SELECT obrazek FROM plakat WHERE plakat_id = @id)

      BEGIN TRY
        EXEC sp_OACreate 'ADODB.Stream', @obj OUTPUT;
        EXEC sp_OASetProperty @obj, 'Type', 1;
        EXEC sp_OAMethod @obj,'Open';
        EXEC sp_OAMethod @obj,'Write', NULL, @image;
        EXEC sp_OAMethod @obj,'SaveToFile', NULL, @path, 2;
        EXEC sp_OAMethod @obj,'Close';
        EXEC sp_OADestroy @obj;
      END TRY

      BEGIN CATCH
        EXEC sp_OADestroy @obj;
      END CATCH
  END 
GO

CREATE OR ALTER PROCEDURE ZmienRozszerzenie (@id INT, @format NVARCHAR(200)) 
AS 
  BEGIN 
      DECLARE @ret VARBINARY(max) 
      DECLARE @sql NVARCHAR(1000) 

      SET @sql = N'SELECT obrazek FROM plakat where plakat_id = ' 
                 + Str(@id) 
      SET NOCOUNT ON 

      BEGIN TRY 
          EXEC Sp_execute_external_script 
            @language = N'Python', 
            @script = N'
from PIL import Image
import io

im = Image.open(io.BytesIO(InputDataSet.iloc[0].obrazek))
with io.BytesIO() as f:
    im.save(f, format=file_format)
    ret = f.getvalue()
',
            @input_data_1 = @sql, 
            @params = N'@file_format nvarchar(100), @ret varbinary(max) output', 
            @file_format = @format, 
            @ret = @ret output 

          UPDATE plakat 
          SET    obrazek = @ret 
          WHERE  plakat_id = @id 
      END TRY 

      BEGIN CATCH
          PRINT 'there was an error' 
      END CATCH 

      SET nocount OFF 
  END 
GO