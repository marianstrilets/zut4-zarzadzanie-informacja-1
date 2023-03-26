/*1. Nałóż ograniczenie:

l_stron może mieć wartość zakresu 1-10000
cena musi być większa od 0
nazwisko (w tabeli autor) nie może być puste*/

ALTER TABLE KSIAZKA ADD CONSTRAINT L_STRON CHECK (L_STRON >= 1 AND L_STRON <= 10000);
ALTER TABLE KSIAZKA ADD CONSTRAINT CENA CHECK (CENA > 0);
ALTER TABLE AUTOR MODIFY NAZWISKO NOT NULL;


/*+2. Dodaj do tabeli czytelnik adres email.*/

ALTER TABLE CZYTELNIK 
ADD EMAIL VARCHAR(32) 

/*+3. Zmień rozmiar kolumny miejscowość z 25 na 50.*/

ALTER TABLE  CZYTELNIK 
MODIFY  MIEJSTOWOSC VARCHAR2(50)

/*+4. Usuń z tabeli czytelnik kolumne ulica.*/

ALTER TABLE  CZYTELNIK 
DROP COLUMN ULICA

/*+5. Podnieś cenę książek o 20 dla tych, które zostały przez wydawnictwo, które ma w nazwie ma literę "a".*/

UPDATE KSIAZKA K 
SET K.CENA = K.CENA +20
WHERE K.CENA IN
    (SELECT K.CENA 
    FROM KSIAZKA K
    JOIN WYDAWNICTWO  WYD 
    ON WYD.ID_WYD IN K.ID_WYD
    WHERE WYD.NAZWA LIKE '%a%')

/*+6. Obniż premię o 10% tym pracownikom, którzy mają więcej niż 20 dni urlopu*/

UPDATE 
    (SELECT PREMIA FROM PRACOWNICY 
    WHERE URLOP > 20)
SET PREMIA =  PREMIA * 0.9

/* +7. Uaktualnij PENSJE pracowników na stanowisku PRACOWNIK tak, aby ich wynagrodzenie było 
    połową średniej płacy na wszystkich stanowiskach.     */
        
UPDATE PRACOWNICY P
SET P.PREMIA = 
    (SELECT AVG(PENSJA) /2
    FROM STANOWISKA S)
    WHERE P.ID_STAN IN
        (SELECT P.ID_STAN 
        FROM PRACOWNICY P
        JOIN STANOWISKA S ON S.ID_STAN IN P.ID_STAN
        WHERE S.NAZWA IN 
            (SELECT S.NAZWA 
            FROM STANOWISKA S 
            WHERE S.NAZWA LIKE 'PRACOWNIK')
        );    
    
    

/*+8. Zmniejsz liczbę stron o 10 dla angielkisch książek.*/

UPDATE KSIAZKA 
SET L_STRON = L_STRON - 10
WHERE ID_AUT IN 
    (SELECT ID_AUT FROM AUTOR
    WHERE NARODOWOSC LIKE 'Anglia')


