# Booker

Booker to aplikacja do zarządzania ksiązkami z uwzględnieniem pożyczania sobie ksiązek pomiędzy uzytkownikami.

# Cel biznesowy
Aplikacja ma pozwalic użytkownikowi na zarządzanie swoją biblioteką ksiązek, pilnowanie tego jakie ksiązki pożyczył innym uzytkownikom platformy oraz katalogowanie swoich zbiorów.

# Podstawowe funkcjonalnosci

1. Rejestracja oraz logowanie się do systemu
  1. Uzytkownik moze się zalogować się do systemu przy pomocy adresu email oraz hasła
  2. Użytkownik rejestruję się do systemu przy pomocy adresu email oraz hasła
  3. Adres email powinien być unikalny w skali systemu
2. Dodanie autorów książek posiadanych przez użytkownika
   1. System powinien pozwalać na dodanie nowego autora do systemu jeżeli taki nie istnieje w systemie
   2. System powinien zapewniać możliwość przeglądania oraz wyszukiwania wszystkich autorów w systemie
   3. System powinien wyświetlać wszystkie książki danego autora, nawet jeżeli nie są w posiadaniu danego użytkownika, zaprezentowane będzie to jako wyszarzona pozycja w liście książek autora
   4. System powinien zapewniać możliwość dodania opisu do autora, imion i nazwiska
   5. Raz dodany autor nie powinien być zmieniany, takie uprawnienia powinien posiadać tylko administrator systemu
      1. **NTH** system powinien móc oznaczyć autora do poprawki, po akceptacji przez administratora zmienionych treści zmiana powinna być wprowadzona globalnie
      2. Użytkownik nie powinien móc usuwać autora ani książek autora
3. Dodanie książki do systemu
   1. System powinien pozwalać na dodanie książki posiadanej przez użytkownika
      1. Książka zawsze powinna być powiązana z konkretnym autorem. Jeżeli autor książki nie istnieje powinien zostać najpierw stworzony
      2. Książka powinna zawierać takie informacje jak:
         1. Tytuł
         2. Autor
         3. Opis
         4. Data wydania
         5. ISBN
         6. Kategoria
      3. Jeżeli taka książka już istnieje w systemie(taki numer ISBN już istnieje) powinno nastąpić powiązanie użytkownika z już istniejącą książka, nie powinno być tworzonej nowej encji w bazie
   2. System powinien pozwalać na wyszukiwanie i przeglądanie wszystkich książek w systemie
4. Dodanie innego użytkownika systemu jako znajomego
   1. System powinien zapewniać możliwość wyszukania innych użytkowników
   2. System powinien pozwalać na dodanie innego użytkownika do systemu
   3. System powinien pozwalać na potwierdzenia dodania do znajomych przez innego użytkownika
5. Zapisanie informacji o wypożyczeniu książki innemu użytkownikowi systemu
   1. System daje możliwość oznaczenia danej książki jako "wypożyczonej" innemu użytkownikowi, przedstawiając w jasny sposób tą informacje
      1. System powinien zapisać takie dane jak:
         1. użytkownik wypożyczający
         2. użytkownik któremu książka została wypożyczona
         3. date wypożyczenia

To są **podstawowe** funcjonalności systemu. Można je rozbudować o następujące podsystemy:

* recenzje oraz oceny
* wishlist

# Implementacja

Aplikacja napisana jest w stylu microservices, gdzię podział na serwisy dyktowany jest domeną problemu który dany serwis rozwiązuje. Na ten moment udało się wydzielić nastepujące serwisy:

* booker-auth
  * serwis odpowiedzialny za obsługe logowania, rejestracji oraz uwierzytelniania użytkowników
* booker-gateway
  * serwis odpowiedzialny za routowanie komunikacji pomiedzy frontendem a odpowiednimi serwisami
* booker-books-and-friends
  * serwis odpowiedzialny za obsługe informacji związanych z podstawowymi funkcjonalnościami biznesowymi
* booker-lender(brak)
  * serwis odpowiedzialny za wypożyczenia książek innym użytkownikom

## booker-auth

Serwis zaimplementowany przy pomocy języka **Elixir** oraz frameworka **Phoenix**. Wystawia interfejs REST do zarządzania użytkownikami oraz uwierzytelniania ich. Używa bazy **PostgreSQL** do przechowywania informacji o użytkowniach. Jest to obok __booker-gateway__ jedyny serwis z którym następuję bezpośrednia komunikacja klienta.

## booker-gateway

Serwis który posiada wiedzę na temat innych serwisów i odpowiedzialny jest za kierowanie ruchem oraz zapytaniami do nich. Aplikacja napisana jest w języku **Elixir** przy pomocy frameworka **Phoenix**.

## booker-books-and-friends

Serwis odpowiedzialny za zapisywanie informacji na temat znajomych, książek oraz autorów dostępnych w systemie. Napisany w **Clojure** używa grafowej bazy danych **Neo4j**.

