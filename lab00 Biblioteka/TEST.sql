/*TEST złączenia i podzapytania*/

/*+1. Wyświetl nazwisko i imię autora (jedna kolumna – dane autora) i nazwę
wydawnictwa, dla książek, które napisał jeśli nazwa ma więcej niż 10 znaków.*/

SELECT 
    A.IMIE || '  ' || A.NAZWISKO AS "dane autora", 
    WYD.NAZWA AS "nazwę wydawnictwa"    
FROM AUTOR A, WYDAWNICTWO WYD, KSIAZKA K
WHERE K.ID_WYD IN WYD.ID_WYD
    AND K.ID_AUT IN A.ID_AUT
    AND K.TYTUL IN
        (SELECT K.TYTUL 
        FROM KSIAZKA K 
        WHERE LENGTH(K.TYTUL) > 10);

/*+2. Wyświetl wszystkie dane czytelnika, który pożyczył najwięcej książek gatunku
dramat.*/

SELECT DISTINCT C.*, G.NAZWA
FROM CZYTELNIK C,  KSIAZKA K, GATUNEK G, WYPOZYCZENIA W
WHERE  K.ID_GAT IN G.ID_GAT
    AND K.ID_KS IN C.ID_CZYT
    AND W.ID_CZYT IN C.ID_CZYT
    AND G.NAZWA LIKE 'dramat'
ORDER BY C.NAZWISKO ASC;

/*+4. Wyświetl tytuły książek wydane przez to wydawnictwo, które wydało najcieńszą
książkę.*/

SELECT K.TYTUL, WYD.NAZWA 
FROM KSIAZKA K, WYDAWNICTWO WYD
WHERE K.ID_WYD IN WYD.ID_WYD
    AND WYD.NAZWA IN
        (SELECT WYD.NAZWA 
            FROM WYDAWNICTWO WYD, KSIAZKA K
            WHERE K.ID_WYD IN WYD.ID_WYD
            AND K.L_STRON IN 
                 (SELECT  MIN(K.L_STRON) FROM KSIAZKA K)
        )
ORDER BY K.TYTUL ASC;

/*+5. Wyświetl miasto i nazwisko czytelnika, jeśli pożyczał książki napisane przez
angielskich autorów albo książki, które w nazwie wydawnictwa mają literę „a”.*/

SELECT 
    C.MIEJSTOWOSC, C.NAZWISKO
FROM 
    KSIAZKA K, CZYTELNIK C, WYPOZYCZENIA W, AUTOR A, WYDAWNICTWO WYD
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND K.ID_AUT IN A.ID_AUT
    AND K.ID_WYD IN WYD.ID_WYD
    AND A.NARODOWOSC LIKE 'Anglia'
    AND WYD.NAZWA LIKE '%a%';

/*+6. Wyświetl nazwisko czytelnika, który pożyczał książki na dłuższy okres czasu niż średni
czas pożyczenia książek.*/

SELECT 
    C.NAZWISKO 
FROM 
    KSIAZKA K , CZYTELNIK C, WYPOZYCZENIA W  
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND W.DATA_ZWR - W.DATA_WYP IN 
        (SELECT MAX(W.DATA_ZWR - W.DATA_WYP) 
        FROM WYPOZYCZENIA W);


/*+7. Wyświetl liczbę książek pożyczonych w 2019 roku w każdym mieście.*/

SELECT  
    C.MIEJSTOWOSC, COUNT(K.ID_KS) AS "ILOŚĆ KSIĄZEK"
FROM 
    KSIAZKA K , CZYTELNIK C, WYPOZYCZENIA W  
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS  
    AND C.MIEJSTOWOSC IN 
        (SELECT C.MIEJSTOWOSC
        FROM CZYTELNIK C, WYPOZYCZENIA W  
        WHERE W.ID_CZYT IN C.ID_CZYT
        AND W.DATA_WYP >= '01-JAN-19'  
        AND W.DATA_WYP <  '31-DEC-19')      
GROUP BY  C.MIEJSTOWOSC
ORDER BY "ILOŚĆ KSIĄZEK" DESC;


/*+8. Wyświetl wszystkie książki pożyczone przez tego czytelnika, który pożyczył najtańszą
książkę.*/
        
SELECT K.*, C.NAZWISKO, C.IMIE 
FROM 
    KSIAZKA K , CZYTELNIK C, WYPOZYCZENIA W  
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS    
    AND C.ID_CZYT IN    
        (
        SELECT C.ID_CZYT
        FROM 
            CZYTELNIK C, KSIAZKA K, WYPOZYCZENIA W  
        WHERE W.ID_CZYT IN C.ID_CZYT
        AND W.ID_KS IN K.ID_KS         
         AND K.CENA IN 
                (
                SELECT  MIN(K.CENA) 
                FROM KSIAZKA K, WYPOZYCZENIA W
                WHERE W.ID_KS IN K.ID_KS
                )
        )
ORDER BY K.TYTUL DESC


/*+9. Wyświetl id_autora, nazwisko i kraj używając rpad lub lpad*/

SELECT 
    A.ID_AUT, LPAD(A.NAZWISKO, 15, '.') || '..........' || RPAD(A.NARODOWOSC, 15, '.') AS "AUTOR"    
FROM AUTOR A


/*+10. Wyświetl nazwę gatunku, nazwę wydawnictwa, tytuł i datę wypożyczenia książki.*/

SELECT  G.NAZWA AS "NAZWA GATUNKU",
    WYD.NAZWA AS "NAZWA WYDAWNICTWA", 
    K.TYTUL AS "TYTUŁ KSIĄZKI",
    W.DATA_WYP AS "DATA WYPOZYCZENIA"    
FROM 
    GATUNEK G, WYDAWNICTWO WYD, WYPOZYCZENIA W, KSIAZKA K
WHERE K.ID_GAT IN G.ID_GAT
    AND K.ID_WYD IN WYD.ID_WYD
    AND W.ID_KS IN K.ID_KS
ORDER BY G.NAZWA DESC  