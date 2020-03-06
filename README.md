# Rozszerzone modelowanie systemów baz danych

<img src="https://static.dwcdn.net/css/flag-icons/flags/4x3/gb.svg" height="10" width="20">Enhanced Modelling of Database Systems classes at Lodz University of Technology (TUL)

Więcej informacji o przedmiocie: [karta przedmiotu](https://programy.p.lodz.pl/ectslabel-web/przedmiot_3.jsp?l=pl&idPrzedmiotu=172758&pkId=1149&s=1&j=0&w=informatyka%20stosowana&v=3)

---

## Konfiguracja

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

1. Przynajmniej 5 powiązanych tabel.
2. Procedury przechowywane (ang. stored procedures) i funkcje (ang. functions) pozwalające na dodawanie, zmianę oraz pobieranie danych z bazy (łącznie przynajmniej 5).
3. Rozbudowanie procedur i funkcji o złożone konstrukcje programistyczne: instrukcje warunkowe, pętle, kursory, obsługę wyjątków.
4. Wyzwalacze charakterystyczne dla aktywnych baz danych (przynajmniej 3 różne).
