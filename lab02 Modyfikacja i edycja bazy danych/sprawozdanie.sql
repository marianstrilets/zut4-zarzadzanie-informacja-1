--  Ćwiczenia 2.
-- ===============================================================================================
--  1. Za pomocą poleceń SQL wstaw do tabeli z danymi o towarach poniższe dane (INSERT):
--  modyfikowania danych w bazie zawartych 
ALTER TABLE 'products' RENAME TO 'towary'
ALTER TABLE `towary` CHANGE `ID_TOWARY` `kod` INT(11) not null;
ALTER TABLE `towary` CHANGE `PRODUCT_NAME` `nazwa` varchar(40) not null;
ALTER TABLE `towary` CHANGE `PRICE` `cena` int(11) not null;
ALTER TABLE `towary` DROP COLUMN `DESIGNATION`;
ALTER TABLE `towary` DROP COLUMN `ITEM_NUMBER`;
ALTER TABLE `towary` DROP COLUMN `COLOUR`;
ALTER TABLE `towary` DROP COLUMN `SIZE`;
ALTER TABLE `towary` DROP COLUMN `WIGHT`;
ALTER TABLE `towary` DROP COLUMN `PRODUCT_DESCRIPTION`;
ALTER TABLE `towary` ADD COLUMN `ilosc` int(11) not null;
-- ====================================================================
-- wstawianie do tabeli z danymi o towarach
--      Dwa pierwsze wiersze wprowadźe oddzielnie (po jednej instrukcji dla każdego wiersza)
INSERT INTO `towary` SET `nazwa`='Monitor LCD 21"', `ilosc`=3, `cena`=300.50;
INSERT INTO `towary` SET `nazwa`='Monitor LCD 19"', `ilosc`=5, `cena`=250.00;
--     pozostałe grupowo (w jednej instrukcji) 
INSERT INTO `towary` (`nazwa`, `ilosc`, `cena`) VALUES 
    ('Monitor LCD 29"',    15, 550.00),
    ('Monitor LCD 19"',    30, 300.00),
    ('Monitor LCD 21"',    25, 250.00),
    ('klawiatura',         15, 67.45),
    ('plyta glowna',       20, 350.20),
    ('klawiatura',         35, 42.35),
    ('mysz bezprzewodowa', 23, 51.00),
    ('pamiec SSD',         50, 75.25);
-- ===============================================================================================
-- 2. Zmodyfikuj strukturę tabeli z towarami (ALTER):
--  a) dodaj pole model (VARTEXT(20) NULL),
--  b) zmień typ pola producent na pole tekstowe o długości 30 znaków.
--  c) Uzupełnij wybrane pola (producent, model).
ALTER TABLE `towary` ADD COLUMN `model` VARCHAR(20) NULL;
ALTER TABLE `towary` ADD COLUMN `producent` VARCHAR(20) NULL AFTER `cena`;

ALTER TABLE `towary` CHANGE `producent` `producent` VARCHAR(30) NULL;

UPDATE `towary` SET `producent`="Toshiba",   `model`="NC125"   WHERE `kod` = "1";
UPDATE `towary` SET `producent`="Linea",     `model`=""        WHERE `kod` = "2";
UPDATE `towary` SET `producent`="Belinea",   `model`="MBE1234" WHERE `kod` = "3";
UPDATE `towary` SET `producent`="Sharp",     `model`=""        WHERE `kod` = "4";
UPDATE `towary` SET `producent`="Sharp",     `model`=""        WHERE `kod` = "5";
UPDATE `towary` SET `producent`="producent", `model`="model"   WHERE `kod` = "6";
UPDATE `towary` SET `producent`="Assus",     `model`=""        WHERE `kod` = "7";
UPDATE `towary` SET `producent`="Logitech",  `model`="BKE12"   WHERE `kod` = "8";
UPDATE `towary` SET `producent`="AITECH",    `model`=""        WHERE `kod` = "9";
UPDATE `towary` SET `producent`="BIGComp ",  `model`="OWE12"   WHERE `kod` = "10";
-- ===============================================================================================
-- 3. Edytuj dane w tabeli towary (UPDATE):
--  a) Zmień wartość pola producent ‘producent’ na ‘Sony’.
--  b) W polu model zamiast wartości NULL wstaw tekst ‘NOWY’.
--  c) Dokonaj dwóch podobnych modyfikacji danych.

-- Zmieniam wartość pola producent ‘producent’ na ‘Sony’
UPDATE `towary` SET `producent`="Sony" WHERE `producent` = "producent";

-- W polu model wstawiam tekst ‘NOWY’
UPDATE `towary` SET `model`="NOWY" WHERE `model` = "";

-- dwóch podobnych modyfikacji danych
UPDATE `towary` SET `producent`="ASUS" WHERE `producent` = "Assus";
UPDATE `towary` SET `model`="MODEL" WHERE `model` = "model";

-- ===============================================================================================
-- 4. Usuń z tabeli towary pole model (ALTER)
ALTER TABLE `towary` DROP COLUMN `model`;
-- ===============================================================================================

-- 5. Usuń rekordy z tabeli towary, spełniające następujące warunki (DELETE):. 
--  a) ilość towaru jest mniejsza od 10, 
--  b) nazwa towaru zawiera słowo ‘klawiatura’
--  c) cena jest z przedziału (200,300).

-- Usuwa rekordy z tabeli towary, kiedy ilość towaru jest mniejsza od 10
DELETE FROM `towary` WHERE `ilosc`<10;

-- Usuwa rekordy z tabeli towary, kiedy nazwa towaru zawiera słowo ‘klawiatura’
DELETE FROM `towary` WHERE `nazwa` IN ('klawiatura');

-- Usuwa rekordy z tabeli towary, kiedy cena jest z przedziału (200,300).
DELETE FROM `towary` WHERE `cena` BETWEEN 200 AND 300;

-- ===============================================================================================
-- 6. Usuń wszystkie dane z tabeli towary (wyczyść tabelę) (TRUNCATE).

-- Usuwa wszystkie dane z tabeli towary
TRUNCATE TABLE `towary`;

-- ===============================================================================================
-- 7. Usuń tabelę towary.

-- Usuwa tabelę towary.
DROP TABLE `towary`;
