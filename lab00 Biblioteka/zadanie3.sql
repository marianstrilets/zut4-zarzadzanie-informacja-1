/*___________ZESTAW 3 - ZŁĄCZENIA________________*/

/*1. Wyświetl daty wypożyczenia i zwrotu oraz tytuł książki oraz autora. Wyniki posortuj
od książki wypożyczonej najwcześniej.*/

SELECT DATA_WYP, DATA_ZWR, TYTUL, ID_AUT FROM WYPOZYCZENIA W INNER JOIN KSIAZKA K
ON K.ID_KS = W.ID_KS ORDER BY DATA_WYP

/*6. Wyświetl całkowitą cenę oraz liczbę wypożyczonych książek przez poszczególnych
czytelników. Nagłówek kolumny z liczbą wypożyczeń powinien być LICZBA WYP.
Posortuj wynik pod względem wypożyczeń w kolejności od największej do
najmniejszej, np.:

NAZWISKO LICZBA_WYP cena
--------------- ---------------------------
Nowak 3 45
*/

SELECT C.NAZWISKO,  COUNT("CENA") AS "LICZBA WYP", ROUND(CENA) AS "cena"
FROM KSIAZKA K
    JOIN WYPOZYCZENIA W ON W.ID_KS = K.ID_KS
    JOIN CZYTELNIK C ON C.ID_CZYT = W.ID_CZYT
    GROUP BY C.NAZWISKO, "CENA"
    ORDER BY  "LICZBA WYP" DESC;

/*7. Wyświetl nazwy miejscowości, z których pochodzą czytelnicy oraz ilość książek
wypożyczonych przez czytelników z danej miejscowości. Posortuj otrzymane dane
malejąco.*/

SELECT C.MIEJSTOWOSC, COUNT(C.MIEJSTOWOSC) AS "ILOŚĆ KSIĄZEK"
FROM CZYTELNIK C
    JOIN WYPOZYCZENIA W ON W.ID_CZYT = C.ID_CZYT
    JOIN KSIAZKA K ON K.ID_KS = W.ID_KS 
    GROUP BY C.MIEJSTOWOSC
    ORDER BY "ILOŚĆ KSIĄZEK" DESC;
    
/*8. Wyświetlić nazwiska czytelników, ich pełny adres (jedna kolumna) oraz tytuł książki i
nazwisko autora, dla tych czytelników, którzy aktualnie mają wypożyczone książki –
użyj funkcji sysdate.*/

SELECT C.NAZWISKO AS "NAZWISKO CZYTELNIKA", 
    C.MIEJSTOWOSC || ', ULICA ' ||C.ULICA || ',  KOD  '|| C.KOD_POCZTOWY AS "ADRESS CZYTELNIKA",
    K.TYTUL AS "TYTUL KSIĄZKI", 
    A.NAZWISKO AS "NAZWISKO AUTORA"
FROM CZYTELNIK C
    JOIN WYPOZYCZENIA W ON W.ID_CZYT = C.ID_CZYT
    JOIN KSIAZKA K ON K.ID_KS = W.ID_KS 
    JOIN AUTOR A ON A.ID_AUT = K.ID_AUT
    WHERE SYSDATE < DATA_ZWR OR DATA_ZWR IS NULL
    
/*9. Wyświetlić narodowość autora, liczbę stron oraz liczbę tych książek, których cena jest
z przedziału 20-35 zł.*/

SELECT A.NARODOWOSC AS "NARODOWOSC AUTORA", 
    K.L_STRON AS "LICZBA STRON",
    K.CENA AS "CENA  KSIĄZKI" 
FROM AUTOR A
    JOIN KSIAZKA K ON K.ID_AUT = A.ID_AUT
    WHERE K.CENA BETWEEN 20 AND 35
    
/*10. Wyświetl max cenę książki w bibliotece oraz jej autora.*/

SELECT A.NAZWISKO, A.IMIE, MAX(CENA) AS "max cenę książki" 
FROM AUTOR A
LEFT JOIN KSIAZKA K
ON K.ID_AUT = A.ID_AUT
WHERE K.CENA IS NOT NULL
GROUP BY A.NAZWISKO, A.IMIE ORDER BY "max cenę książki" DESC
FETCH FIRST ROWS ONLY;

/*11. Wyświetl nazwiska tych czytelników, którzy wypożyczyli książkę mającą więcej niż
100 stron. Wyświetlone mają być również autorzy książek oraz nazwa wydawnictwa.*/

SELECT C.NAZWISKO AS "NAZWISKO CZYTELNIKA", 
    C.IMIE AS "IMIE CZYTELNIKA", 
    K.L_STRON AS "LICZBA STRON", 
    WYD.NAZWA AS "NAZWA WYDAWNICZRTWA",
    A.NAZWISKO  AS "NAZWISKO AUTORA",
    A.IMIE  AS "IMIE AUTORA"
FROM CZYTELNIK C
    JOIN WYPOZYCZENIA W ON W.ID_CZYT = C.ID_CZYT
    JOIN KSIAZKA K ON K.ID_KS = W.ID_KS    
    JOIN   WYDAWNICTWO WYD ON WYD.ID_WYD = K.ID_WYD
    JOIN   AUTOR A ON A.ID_AUT = K.ID_AUT    
    WHERE K.L_STRON > 100
    GROUP BY C.NAZWISKO, C.IMIE, K.L_STRON, WYD.NAZWA, A.NAZWISKO, A.IMIE  
    ORDER BY K.L_STRON DESC;


/*12. Wyświetl liczbę książek dla każdego gatunku literackiego.*/

SELECT G.NAZWA AS "NAZWA GATUNKU", COUNT(G.NAZWA) AS "ILOŚĆ KSIĄZEK" FROM GATUNEK G 
    JOIN KSIAZKA K ON K.ID_GAT = G.ID_GAT
    GROUP BY G.NAZWA
    ORDER BY "ILOŚĆ KSIĄZEK" DESC;


/*13. Wyświetl poniższy raport – lpad lub rpad + concat*/
/*
czytelnicy biblioteki
----------------------------------------
1........PIOTR..........KOWALSKI.......
2........JAN............NOWAK..........
3........PAWEL..........ADAMCZYK.......
4........BOGDAN.........BRACKI.........
5........JAKUB..........LIPKA..........
*/
SELECT LPAD(IMIE, 15, '.') || '..........' || RPAD(NAZWISKO, 15, '.') AS "czytelnicy biblioteki"
FROM CZYTELNIK


