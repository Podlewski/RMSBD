# Rozszerzone modelowanie systemów baz danych

<img src="https://static.dwcdn.net/css/flag-icons/flags/4x3/pl.svg" height="10" width="20"> Laboratoria z **Rozszerzonego modelowania systemów baz danych** na Politechnice Łódzkiej (PŁ). Więcej informacji o przedmiocie: [karta przedmiotu](https://programy.p.lodz.pl/ectslabel-web/przedmiot_3.jsp?l=pl&idPrzedmiotu=172758&pkId=1149&s=1&j=0&w=informatyka%20stosowana&v=3).

<img src="https://static.dwcdn.net/css/flag-icons/flags/4x3/gb.svg" height="10" width="20"> **Enhanced Modelling of Database Systems** classes at Lodz University of Technology (TUL).

---

## Konfiguracja

> UWAGA: Kontener dockerowy wystarcza tylko i wyłącznie do wykonania Zadania 1 oraz Zadania 4. Do uruchomienia skryptów z Zadań 2 i 3 wymagana jest lokalna kopia SQL Servera.

### Uruchomienie SQL Servera przy użyciu dockerowego kontenera

Mając zainstalowany [Docker for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows/) oraz ustawione współdzielenie danych na dysku na którym znajduje się kontener wpisujemy w PowerShell komendę:

```sh
docker-compose up
```

W ten sposób utworzyliśmy kontener z SQL Serverem gotowy do pracy. By z niego skorzystać, możemy wykorzystać np. [Azure Data Studio](https://docs.microsoft.com/pl-pl/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15) tworząc nowe połączenie:

+ **Server:** localhost
+ **Authentication type:** SQL Login
+ **User name:** SA
+ **Password:** Abc12345678

---

## Zadanie 1

Należy opracować system bazodanowy przy następujących założeniach:

1. Przynajmniej 5 powiązanych tabel,
2. Procedury przechowywane (ang. stored procedures) i funkcje (ang. functions) pozwalające na dodawanie, zmianę oraz pobieranie danych z bazy (łącznie przynajmniej 5),
3. Rozbudowanie procedur i funkcji o złożone konstrukcje programistyczne: instrukcje warunkowe, pętle, kursory, obsługę wyjątków,
4. Wyzwalacze charakterystyczne dla aktywnych baz danych (przynajmniej 3 różne).

## Zadanie 2

> Należy przyznać odpowiednia uprawienia folderowi, z którego SQL Server będzie odczytywał pliki, więcej [tutaj](https://blog.sqlauthority.com/2016/08/18/sql-server-false-error-cannot-bulk-load-file-not-opened-operating-system-error-code-5-access-denied/)

Zadanie polega na zaimplementowaniu multimedialnego systemu bazodanowego dla wybranego obszaru tematycznego. Należy uwzględnić następujące wytyczne:

1. Schemat bazy danych składa się tabel (więcej niż trzech) umożliwiających przechowywanie w odpowiednich kolumnach danych multimedialnych (przynajmniej jedna tabela musi przechowywać dane multimedialne),
2. Poszczególne tabele należy wstępnie uzupełnić przykładowymi danymi zgodnymi z charakterystyką obiektów (wprowadzone dane powinny dawać możliwość przetestowania rozwiązania),
3. Przetwarzanie danych zgromadzonych w bazie odbywa się poprzez odpowiednie procedury i funkcje (odpowiednio rozbudowane), przykłady (tzn. nie ograniczając się do podanych) dla obrazów:
    + wczytanie obrazu (nazwa / ścieżka podane jako parametr),
    + wczytanie wszystkich obrazów z danego folderu,
    + przetworzenie obrazu (zmniejszenie, zmiana formatu),
    + eksport obrazu.

## Zadanie 3

Zadanie polega na zaimplementowaniu systemu baz danych dla wybranego obszaru tematycznego. W systemie podstawową rolę powinna odgrywać obsługa dokumentów XML. Należy uwzględnić następujące wytyczne:

1. Zaprojektowanie i zaimplementowanie schematu bazy danych z uwzględnieniem danych typu XML,
2. Poszczególne tabele należy wstępnie uzupełnić przykładowymi danymi,
3. Opracowanie odpowiednich procedur:
    + wprowadzania danych z dokumentu XML,
    + przeglądania danych XML (całość, wybraną gałąź, atrybut, ...),
    + wyeksportowania danych w postaci dokumentu XML.

## Zadanie 4

Zadanie polega na zaimplementowaniu systemu baz danych dla wybranego obszaru tematycznego. W systemie podstawową rolę powinna odgrywać obsługa danych przestrzennych. Należy uwzględnić następujące wytyczne:

1. Schemat bazy danych powinien uwzględniać możliwość przechowywania danych typów przestrzennych,
2. Tabele powinny zostać wstępnie uzupełnione danymi,
3. Powinny zostać zdefiniowane indeksy przestrzenne,
4. Powinny zostać zdefiniowane przykładowe (sparametryzowane) procedury:
    + do wyświetlania danych w sposób przyjazny użytkownikowi;
    + do ładowania danych jako geometrii różnych typów (punkty, linie, wielokąty, …)
