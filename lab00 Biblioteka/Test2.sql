
TEST złączenia i podzapytania II

/*1. Wyświetl ulicę i miasto (jedna kolumna – adres) i nazwę gatunku, dla książek, które w tytule mają literę „o” lub kończą się na „a”.*/

       SELECT 
    C.ULICA || '  ' || C.MIEJSTOWOSC AS "adres", 
    G.NAZWA AS "nazwę gatunku"    
FROM CZYTELNIK C, KSIAZKA K, GATUNEK G
WHERE G.ID_GAT IN K.ID_GAT
    AND C.ID_CZYT IN K.ID_KS
    AND K.TYTUL LIKE '%A' OR K.TYTUL LIKE '%O%'

/*2. Wyświetl liczbę książek i sumaryczną liczbę stron dla książek z każdego gatunku.*/

SELECT COUNT(K.ID_KS) AS "ILOŚĆ KSIĄZEK",
    SUM(K.L_STRON) AS "ILOŚĆ STRON",
    G.NAZWA
FROM KSIAZKA K
    JOIN GATUNEK G ON K.ID_GAT IN G.ID_GAT
    GROUP BY G.NAZWA

    
/*3. Wyświetl nazwisko czytelnika, nazwisko autora oraz daty wypożyczenia 
       książek dla czytelników spoza Krakowa lub dla autora z USA.*/
    
SELECT DISTINCT C.NAZWISKO, A.NAZWISKO, W.DATA_WYP
FROM CZYTELNIK C, KSIAZKA K,WYPOZYCZENIA W, AUTOR A
WHERE K.ID_KS IN W.ID_KS
    AND W.ID_CZYT IN C.ID_CZYT
    AND A.ID_AUT IN K.ID_AUT 
    AND C.MIEJSTOWOSC NOT LIKE 'KRAKOW' OR A.NARODOWOSC LIKE 'USA'    
ORDER BY W.DATA_WYP DESC
    
/*4. Wyświetl tytuły książek wydane przez to wydawnictwo, które wydało najstarszą książkę.*/
    
        
           SELECT K.TYTUL FROM KSIAZKA K, WYDAWNICTWO WYD
     WHERE K.ID_WYD IN WYD.ID_WYD
        AND K.ID_WYD IN 
        ( 
        SELECT K.ID_WYD FROM KSIAZKA K, WYDAWNICTWO WYD
        WHERE K.ID_WYD IN WYD.ID_WYD
            AND K.DATA_WYD IN (
                SELECT MIN(K.DATA_WYD)  FROM KSIAZKA K
            )
        )

/*5. Wyświetl nazwisko czytelnika, który pożyczał książki napisane przez tego autora, który napisał najdroższą książkę.*/

SELECT C.NAZWISKO
FROM CZYTELNIK C, KSIAZKA K, WYPOZYCZENIA W, AUTOR A 
WHERE K.ID_KS IN W.ID_KS
    AND W.ID_CZYT IN C.ID_CZYT
    AND A.ID_AUT IN K.ID_AUT
    AND K.ID_AUT IN 
    (
    SELECT A.ID_AUT 
    FROM KSIAZKA K, AUTOR A
    WHERE K.ID_AUT IN A.ID_AUT
        AND K.CENA IN 
            (SELECT MAX(K.CENA) FROM KSIAZKA K )
    )


 /*6. Wyświetl wszystkie dane autora, który napisał najwięcej książek z gatunku poezja.*/
 
SELECT A.NAZWISKO, A.IMIE, A.NARODOWOSC, 
    COUNT(G.NAZWA) AS "ILOŚĆ KSIĄZEK"
FROM AUTOR A, KSIAZKA K, GATUNEK G
WHERE K.ID_GAT IN K.ID_GAT
    AND K.ID_AUT IN A.ID_AUT
    AND G.NAZWA LIKE 'Poezja'

GROUP BY G.NAZWA,A.IMIE, A.NARODOWOSC, A.NAZWISKO
ORDER BY "ILOŚĆ KSIĄZEK" DESC
FETCH FIRST ROWS ONLY;
 

 Wyświetl tytuły książek i nazwiska autorów, którzy pochodzą z tego kraju, z
którego jest najmniej autorów.

SELECT * FROM AUTOR
SELECT * FROM AUTOR
SELECT * FROM KSIAZKA
SELECT * FROM CZYTELNIK

SELECT K.TYTUL, A.NAZWISKO, MIN(A.NARODOWOSC)
FROM KSIAZKA K
JOIN AUTOR A ON A.ID_AUT IN K.ID_AUT
WHERE A.NARODOWOSC IN 
    (
    SELECT COUNT(A.NARODOWOSC) AS "ILOSC" FROM  AUTOR A
    JOIN KSIAZKA K ON K.ID_AUT IN A.ID_AUT
    GROUP BY A.NARODOWOSC
    )

GROUP BY K.TYTUL, A.NAZWISKO





WHERE COUNT(A.NARODOWOSC) !> COUNT(A.NARODOWOSC)
INTERSECT   
SELECT K.ID_KS, K.TYTUL, A.NAZWISKO, A.NARODOWOSC FROM KSIAZKA K
JOIN AUTOR A ON A.ID_AUT IN K.ID_AUT
WHERE A.NARODOWOSC IN 
    (SELECT COUNT(A.NARODOWOSC) 
    FROM AUTOR A 
    GROUP BY A.NARODOWOSC  )

GROUP BY  K.ID_KS, K.TYTUL, A.NAZWISKO, A.NARODOWOSC


WHERE A.NARODOWOSC IN 
    (
    SELECT A.NARODOWOSC FROM 
    )