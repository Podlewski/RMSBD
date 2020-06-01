USE kina_w_lodzi

INSERT INTO kino (nazwa, sale, ulica, nr_budynku, lokalizacja)
VALUES
    ('Cinema City - Manufaktura', 14, 'Drewnowska', '58', geography::Point(51.780670, 19.446750, 4326)),
    ('Multikino', 10, 'Marszałka Józefa Piłsudskiego', '5', geography::Point(51.759080, 19.460810, 4326)), 
    ('Helios - Sukcesja', 9, 'Politechniki', '1', geography::Point(51.742409, 19.451811, 4326)), 
    ('Kino Charlie', 2, 'Piotrkowska', '203/205', geography::Point(51.755000, 19.458611, 4326)), 
    ('Kino Szkoły Filmowej w Łodzi', 1, 'Targowa', '61/63', geography::Point(51.757658, 19.472633, 4326)), 
    ('Stare Kino', 1, 'Piotrkowska', '120', geography::Point(51.762910, 19.458110, 4326)) 

SELECT * FROM kino;
GO