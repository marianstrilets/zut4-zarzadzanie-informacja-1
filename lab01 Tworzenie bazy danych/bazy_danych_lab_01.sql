-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 12 Mar 2023, 23:52
-- Wersja serwera: 10.4.27-MariaDB
-- Wersja PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `bazy_danych_lab_01`
--
CREATE DATABASE IF NOT EXISTS `bazy_danych_lab_01` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bazy_danych_lab_01`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `ID_CUSTOMER` int(11) NOT NULL AUTO_INCREMENT,
  `CUSTOMER_NAME` varchar(50) NOT NULL,
  `CUSTOMER_FIRST_NAME` varchar(50) NOT NULL,
  `CUSTOMER_LAST_NAME` varchar(50) NOT NULL,
  `PHONE` int(20) NOT NULL,
  `COUNTRY` varchar(20) NOT NULL,
  `STATE` varchar(20) DEFAULT NULL,
  `CITY` varchar(20) NOT NULL,
  `ADDRESS_LINE_1` varchar(50) NOT NULL,
  `ADDRESS_LINE_2` varchar(50) DEFAULT NULL,
  `POST_CODE` varchar(10) DEFAULT NULL,
  `CREDIT_LIMIT` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`ID_CUSTOMER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE IF NOT EXISTS `orderdetails` (
  `ID_ORDER_DETAIL` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ORDER` int(11) NOT NULL,
  `ID_PRODUCT` int(11) NOT NULL,
  `QUANTITY_ORDERED` int(11) NOT NULL,
  `PRICE` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_ORDER_DETAIL`),
  KEY `orderdetails_products` (`ID_PRODUCT`),
  KEY `orderdetails_orders` (`ID_ORDER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `ID_ORDER` int(11) NOT NULL AUTO_INCREMENT,
  `ORDER_DATE` date NOT NULL,
  `REQUIRED_DATE` date NOT NULL,
  `SENT_DATE` date DEFAULT NULL,
  `STATUS` varchar(30) NOT NULL,
  `COMMENTS` text NOT NULL,
  `ID_CUSTOMER` int(11) NOT NULL,
  PRIMARY KEY (`ID_ORDER`),
  KEY `orders_customers` (`ID_CUSTOMER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `ID_PAYMENT` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CUSTOMER` int(11) NOT NULL,
  `PAYMENT_DATE` date NOT NULL,
  `AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_PAYMENT`),
  KEY `payments_customers` (`ID_CUSTOMER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `ID_PRODUCT` int(11) NOT NULL AUTO_INCREMENT,
  `DESIGNATION` varchar(20) DEFAULT NULL,
  `ITEM_NUMBER` int(11) NOT NULL,
  `PRODUCT_NAME` varchar(70) NOT NULL,
  `COLOUR` varchar(10) DEFAULT NULL,
  `SIZE` int(11) DEFAULT 0,
  `WIGHT` int(11) DEFAULT 0,
  `PRICE` int(11) NOT NULL DEFAULT 0,
  `PRODUCT_DESCRIPTION` text NOT NULL,
  PRIMARY KEY (`ID_PRODUCT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_orders` FOREIGN KEY (`ID_ORDER`) REFERENCES `orders` (`ID_ORDER`),
  ADD CONSTRAINT `orderdetails_products` FOREIGN KEY (`ID_PRODUCT`) REFERENCES `products` (`ID_PRODUCT`);

--
-- Ograniczenia dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_customers` FOREIGN KEY (`ID_CUSTOMER`) REFERENCES `customers` (`ID_CUSTOMER`);

--
-- Ograniczenia dla tabeli `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_customers` FOREIGN KEY (`ID_CUSTOMER`) REFERENCES `customers` (`ID_CUSTOMER`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
