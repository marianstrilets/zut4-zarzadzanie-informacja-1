/*1. Wyświetl wszystkie dane (autor, tytuł gatunek literacki) na temat
 książki o najwyższej cenie spośród książek wydanych przez wydawnictwo
  Świat książki.*/
  
SELECT A.*, K.TYTUL,  G.NAZWA, K.CENA
FROM AUTOR A, KSIAZKA K, GATUNEK G
WHERE K.ID_AUT = A.ID_AUT 
    AND K.ID_GAT = G.ID_GAT
    AND K.CENA = 
        (SELECT MAX(K.CENA) 
        FROM KSIAZKA K, WYDAWNICTWO WYD
         WHERE K.ID_WYD = WYD.iD_WYD
         AND WYD.NAZWA = 'Świat książki');
         
/*2. Wyświetl wszystkie dane na temat czytelnika, oraz książki, który wypożyczył
ją na najdłuższy okres czasu oraz termin, na jaki ta książka została
wypożyczona.*/
  
SELECT C.*, 
    W.DATA_ZWR  - W.DATA_WYP  AS "LICZBA DNI",
    A.IMIE || '  ' || A.NAZWISKO AS "AUTOR KSIĄZKI",
    K.TYTUL AS "TYTUŁ KSIĄZKI"
FROM CZYTELNIK C, WYPOZYCZENIA W,
    KSIAZKA K,   AUTOR A
WHERE C.ID_CZYT IN W.ID_CZYT
    AND W.ID_KS IN K.ID_KS    
    AND K.ID_AUT IN A.ID_AUT 
    AND W.DATA_ZWR  - W.DATA_WYP IN
        (SELECT MAX(W.DATA_ZWR  - W.DATA_WYP)
        FROM WYPOZYCZENIA W);

/*3. Wyświetl wszystkie informacje o książkach, które zostały wypożyczone
przez tego samego czytelnika, który wypożyczył Pana Tadeusza Adama
Mickiewicza.
Jeśli podzapytanie zwraca więcej niż jeden wiersz to
wtedy zamiast = stosujemy IN*/ 

SELECT 
    C.NAZWISKO || '  ' ||  C.IMIE AS "CZYTELNICY BIBLIOTEKI",
     K.TYTUL AS "TYTUŁ KSIĄZKI",
     K.CENA AS "CENA KSIĄŻKI",
     K.DATA_WYD AS "DATA WYDANIA",
     K.L_STRON AS "LICZBA STRON", 
     A.IMIE || ' ' || A.NAZWISKO AS "AUTOR KSIĄZKI",
     WYD.NAZWA AS "NAZWA WYDAWNICTWA",
     COUNT(C.ID_CZYT) AS "ILOŚĆ WYPOZYCZENIA"
FROM 
    KSIAZKA K, CZYTELNIK C, WYPOZYCZENIA W, AUTOR A, WYDAWNICTWO WYD
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND K.ID_AUT IN A.ID_AUT
    AND K.ID_WYD IN WYD.ID_WYD
    AND A.IMIE IN 'Adam' 
    AND A.NAZWISKO IN 'Mickiewicz'
    AND K.TYTUL IN 'PAN TADEUSZ'    
GROUP BY C.NAZWISKO, C.IMIE, K.TYTUL, A.IMIE, A.NAZWISKO,
        K.CENA, K.DATA_WYD, K.L_STRON, WYD.NAZWA 
HAVING COUNT(C.ID_CZYT) > 1;
        
/*4. Wyświetl dane autora oraz tytuł książki wydanej przez to samo
wydawnictwo, w którym wydano najstarszą książkę, jaka znajduje się w
wypożyczalni.
UWAGA!!! Mamy do czynienia z dwoma podzapytaniami, zapytanie zagnieżdżone*/

SELECT A.IMIE AS "IMIE AUTORA", 
    A.NAZWISKO AS "NAZWISKO AUTORA",
    A.NARODOWOSC AS "NARODOWOSC AUTORA",
    K.TYTUL AS "TYTUŁ KSIĄZKI",
    WYD.NAZWA AS "NAZWA WYDAWNICTWA",
    W.DATA_ZWR - W.DATA_WYP AS "ILOŚĆ DNI"
FROM 
    KSIAZKA K, CZYTELNIK C, WYPOZYCZENIA W, AUTOR A, WYDAWNICTWO WYD
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND K.ID_AUT IN A.ID_AUT
    AND K.ID_WYD IN WYD.ID_WYD
    AND WYD.NAZWA IN 
        (SELECT WYD.NAZWA 
        FROM WYDAWNICTWO WYD, KSIAZKA K, WYPOZYCZENIA W
        WHERE WYD.ID_WYD IN K.ID_WYD
            AND K.ID_KS IN W.ID_KS
            AND  W.DATA_ZWR - W.DATA_WYP IN 
                (SELECT MAX(W.DATA_ZWR  - W.DATA_WYP) 
                FROM WYPOZYCZENIA W)
        )
ORDER BY "ILOŚĆ DNI" DESC        


/*5. Wyświetl imiona, nazwiska, miejscowość, z której pochodzą czytelnicy oraz
daty wypożyczonych i zwróconych przez nich książek, dla czytelników,
którzy wypożyczyli i oddali książki w okresie, pomiędzy wypożyczeniem
przez klienta LIPKA JAKUB pierwszej książki a oddaniem przez niego
ostatniej z wypożyczonych książek.*/

SELECT C.IMIE,
    C.NAZWISKO,     
    C.MIEJSTOWOSC, 
    W.DATA_WYP AS "DATA WYPOZYCZENIA",
    W.DATA_ZWR AS "DATA ZWROTU"
FROM CZYTELNIK C, KSIAZKA K, WYPOZYCZENIA W
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND W.DATA_WYP BETWEEN 
        (SELECT MIN(W.DATA_WYP)
        FROM WYPOZYCZENIA W, CZYTELNIK C
        WHERE W.ID_CZYT IN C.ID_CZYT
            AND C.NAZWISKO LIKE 'LIPKA' 
            AND C.IMIE LIKE 'JAKUB')
            AND 
            (SELECT MAX(W.DATA_ZWR)
            FROM WYPOZYCZENIA W, CZYTELNIK C
            WHERE W.ID_CZYT IN C.ID_CZYT
            AND C.NAZWISKO LIKE 'LIPKA' 
            AND C.IMIE LIKE 'JAKUB')
    AND C.IMIE NOT LIKE 'JAKUB'
    AND C.NAZWISKO NOT LIKE 'LIPKA'
ORDER BY W.DATA_WYP

 
/*6. Wyświetl nazwiska i imiona czytelników, autora i tytuł książki oraz
narodowość autora, dla tych osób, które wypożyczyły książki, których cena
dla gatunku ‘Dla młodzieży’ jest największa.*/

SELECT 
    C.NAZWISKO || '  ' ||  C.IMIE AS "CZYTELNICY BIBLIOTEKI",
    A.IMIE || '  ' || A.NAZWISKO AS "AUTOR KSIĄZKI",
    A.NARODOWOSC AS "NARODOWOSC AUTORA",
    K.TYTUL AS "TYTUŁ KSIĄZKI",
    G.NAZWA,
    K.CENA
FROM 
    KSIAZKA K, CZYTELNIK C, WYPOZYCZENIA W, AUTOR A, GATUNEK G
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND K.ID_AUT IN A.ID_AUT
    AND K.ID_GAT IN G.ID_GAT
    AND G.NAZWA IN 
        (SELECT  G.NAZWA
        FROM  GATUNEK G, KSIAZKA K
         WHERE K.ID_GAT IN G.ID_GAT
            AND G.NAZWA LIKE 'Dla młodzieży'
            AND K.CENA IN 
                (SELECT MAX(K.CENA) 
                FROM KSIAZKA K)
        )
ORDER BY K.CENA DESC;

        
/*7. Wyświetl wszystkie dane o czytelnikach, którzy pożyczali książkę
POLLYANNA DORASTA, której autorem jest Porter*/

SELECT
    C.*, 
    A.NAZWISKO || '  ' || A.IMIE AS "AUTOR",
    K.TYTUL AS "TYTUŁ KSIĄZKI"
FROM 
    KSIAZKA K, CZYTELNIK C, WYPOZYCZENIA W, AUTOR A
WHERE W.ID_CZYT IN C.ID_CZYT
    AND W.ID_KS IN K.ID_KS
    AND K.ID_AUT IN A.ID_AUT
    AND K.TYTUL IN 
        (SELECT K.TYTUL 
        FROM KSIAZKA K
        WHERE TYTUL LIKE 'POLLYANNA DORASTA')
    AND A.NAZWISKO IN 
        (SELECT  A.NAZWISKO 
        FROM AUTOR A
        WHERE A.NAZWISKO LIKE 'Porter')
    
/*8. Wyświetl tytuł książki oraz nazwy tych wydawnictw wydające książki,
których cena jest większa niż średnia cena dla wszystkich książek z gatunku
Dla dzieci.*/

SELECT  
    K.TYTUL AS "TYTUŁ KSIĄZKI",
    WYD.NAZWA AS "NAZWA WYDAWNICTWA",
    K.CENA AS "CENA KSIĄZKI", 
    G.NAZWA AS "NAZWA GATUNKU"
FROM KSIAZKA K, WYDAWNICTWO WYD, GATUNEK G
WHERE K.ID_WYD IN WYD.ID_WYD
    AND K.ID_GAT IN G.ID_GAT
    AND G.NAZWA IN 
        (SELECT G.NAZWA 
        FROM GATUNEK G
        WHERE G.NAZWA LIKE 'Dla dzieci')
    AND K.CENA IN 
        (
        SELECT K.CENA
        FROM KSIAZKA K
        WHERE K.CENA 
        BETWEEN 
            (SELECT AVG(K.CENA) FROM KSIAZKA K)
        AND 
            (SELECT MAX(K.CENA) FROM KSIAZKA K)        
        )
ORDER BY K.CENA DESC;
