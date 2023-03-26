/* 1. Wyświetl nazwiska i imiona autorów oraz narodowość. 
Nazwiska i imiona mają być pisane pierwsza litera duża pozostałe małe, narodowość małymi literami, 
kolumna ma mieć nie zmienioną nazwę.
Nazwisko i imię       NAROWOWOSC
------------ ------------
				Mickiewicz Adam 	polska
*/

SELECT INITCAP (NAZWISKO) AS NAZWISKO, UPPER (IMIE) AS IMIE, LOWER (NARODOWOSC) AS NARODOWOSC FROM AUTOR;

/* 2. Oblicz na ile dni czytelnicy mieli wypożyczone książki. 
Dane wyświetl od książek przetrzymywanych najdłużej do najkrócej */
 
SELECT DATA_WYP, DATA_ZWR, TRUNC(DATA_ZWR  - DATA_WYP)  AS "LICZBA DNI"
 FROM WYPOZYCZENIA ORDER BY "LICZBA DNI" DESC;
    
/* 3. Wyświetl liczbę miesięcy, jakie upłynęły pomiędzy data wypożyczenia a datą obecną. 
Kolumnie nadaj nazwę LICZBA_MIESIECY.*/

SELECT DATA_WYP, DATA_ZWR, TRUNC (MONTHS_BETWEEN (SYSDATE, DATA_WYP)) AS  "LICZBA_MIESIECY"
 FROM WYPOZYCZENIA ORDER BY LICZBA_MIESIECY DESC;
 
/* 4. Wyświetl minimalna, średnią oraz maksymalną liczbę stron dla wszystkich książęk. 
Nazwy kolumn wynikowych mają być odpowiednio:
MINIMALNA LICZBA STRON, ŚREDNIA LICZBA STRON, MAKSYMALNA LICZBA STRON

MINIMALNA LICZBA STRON            MAKSYMALNA LICZBA STRON             ŚREDNIA LICZBA STRON
*/

SELECT MIN(L_STRON) AS "MINIMALNA LICZBA STRON", MAX(L_STRON) AS "MAKSYMALNA LICZBA STRON",
        AVG(L_STRON) AS "ŚREDNIA LICZBA STRON" FROM KSIAZKA;

/*5. Wyświetl różnicę pomiędzy najcieńszą a najgrubszą książką. Kolumnie nadaj nazwę RÓŻNICA 
*/

SELECT MAX(L_STRON) - MIN(L_STRON) AS "RÓŻNICA"  FROM KSIAZKA;

/*6. Wyświetl liczbę książek napisanych przez każdego z autorów. 
*/

SELECT ID_AUT, NAZWISKO, IMIE,
(SELECT COUNT(*) FROM KSIAZKA WHERE 
KSIAZKA.ID_AUT = AUTOR.ID_AUT) AS "ILOŚĆ KSIĄŻEK" FROM AUTOR;


7. Wyświetlić czytelnika, który wypożyczył najwięcej książek.

SELECT NAZWISKO, IMIE, COUNT(C.ID_CZYT) AS "LICZBA WYPOZYCZEN CZYTELNIKA" 
FROM CZYTELNIK C
LEFT JOIN WYPOZYCZENIA W
ON C.ID_CZYT = W.ID_CZYT
GROUP BY NAZWISKO, IMIE ORDER BY "LICZBA WYPOZYCZEN CZYTELNIKA" DESC
FETCH FIRST ROWS ONLY;


8. Wyświetl z tabeli WYPOZYCZENIA liczbę książek, które są aktualnie wypożyczone
(wykorzystaj funkcję sysdate)

SELECT COUNT(DATA_WYP) AS "ILOŚĆ KSIĄŻEK WYPORZYCONYCH"
  FROM WYPOZYCZENIA 
 WHERE DATA_ZWR > SYSDATE;