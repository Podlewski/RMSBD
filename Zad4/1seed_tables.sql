USE kina_w_lodzi

INSERT INTO kino (lokalizacja, nazwa)
VALUES
    (geography::Point(51.77, 19.44, 4326), 'Cinema City - Manufaktura')


SELECT * FROM kino;
GO