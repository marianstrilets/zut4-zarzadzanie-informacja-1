/* 2.Wyświetl wszystkie dane na temat wszystkich czytelników*/

SELECT * FROM CZYTELNIK;

/*3. Wyświetl identyfikatory wypożyczeń, daty wypożyczeń i zwrotów, dla wszystkich
wypożyczonych książek*/

SELECT ID_WYP, DATA_WYP, DATA_ZWR FROM WYPOZYCZENIA;

/*4. Wyświetl wszystkie dane na temat czytelnika (lub czytelników) o nazwisku
zaczynającym sie na literę N */

SELECT * FROM CZYTELNIK WHERE NAZWISKO LIKE 'N%';

/*5. Wyświetl tytuły oraz daty wydania wszystkich książek, których tytuły maja więcej niż
20 znaków pomijając wszystkie spacje w tytule.*/

SELECT TYTUL, DATA_WYD FROM  KSIAZKA WHERE LENGTH(TYTUL) > 20;

/*6. Wyświetl tytuły książek, cena oraz liczb stron (kolumnom nadać nazwę TYTUŁ,
CENA KSIĄŻKI oraz liczba stron*/

SELECT TYTUL AS "TYTUŁ", CENA AS "CENA KSIĄŻKI", L_STRON AS "liczba stron" FROM  KSIAZKA;

/*7. Wyświetl nazwiska, imiona i identyfikatory czytelników sortując nazwiska w
kolejności alfabetycznej.*/

SELECT NAZWISKO, IMIE, ID_CZYT FROM  CZYTELNIK ORDER BY NAZWISKO ASC;

/*8. Wyświetl wszystkie informacje z tabeli WYPOZYCZENIA w kolejności od
najbardziej odległego.*/

SELECT * FROM  WYPOZYCZENIA ORDER BY DATA_ZWR ASC;


/*9. Wyświetl wszystkie informacje na temat książek, wydanych po 2010 roku.*/

SELECT * FROM KSIAZKA WHERE DATA_WYD > TO_DATE ('2010', 'YYYY');

/*10. Wyświetl nazwisko, imię pełny adres czytelników mieszkających poza Krakowem,
którzy nie podali numeru telefonu.*/

SELECT NAZWISKO, IMIE, MIEJSTOWOSC, ULICA, KOD_POCZTOWY 
    FROM CZYTELNIK WHERE MIEJSTOWOSC NOT IN ('KRAKÓW') AND TELEFON IS NULL;

/*11. Wyświetl wszystkie informacje na temat autorów, którzy nie są POLAKAMI*/

SELECT * FROM AUTOR WHERE NARODOWOSC NOT IN ('Polska');

/*12. Wyświetl Nazwiska i imiona, czytelników, których ulica jest wyrazem, w którym na
drugim miejscu znajduje się litera O lub I a pozostałe są dowolne, natomiast
miejscowość ma 8 znaków.*/

SELECT NAZWISKO, IMIE FROM CZYTELNIK  WHERE MIEJSTOWOSC LIKE '________' AND (ULICA LIKE '_O%' OR ULICA LIKE '_I%');