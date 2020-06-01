USE kina_w_lodzi
GO

CREATE OR ALTER PROCEDURE ToString(@id int = NULL)
AS 
BEGIN
    IF @id is null
        SELECT id_kino
            ,nazwa
            ,sale
            ,sale_3d
            ,ulica
            ,nr_budynku
            ,nr_lokalu
            ,lokalizacja.Lat AS 'Szerokość'
            ,lokalizacja.Long AS 'Długość'
        FROM kino
    ELSE
        SELECT id_kino
            ,nazwa
            ,sale
            ,sale_3d
            ,ulica
            ,nr_budynku
            ,nr_lokalu
            ,lokalizacja.Lat AS 'Szerokość'
            ,lokalizacja.Long AS 'Długość'
            FROM kino
        WHERE id_kino = @id
END
GO

exec ToString 1
exec ToString