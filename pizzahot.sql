-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2022. Ápr 12. 09:26
-- Kiszolgáló verziója: 10.4.20-MariaDB
-- PHP verzió: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `pizzahot`
--
CREATE DATABASE IF NOT EXISTS `pizzahot` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `pizzahot`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasználók`
--

DROP TABLE IF EXISTS `felhasználók`;
CREATE TABLE IF NOT EXISTS `felhasználók` (
  `felhAzon` int(11) NOT NULL AUTO_INCREMENT,
  `vezetekNev` varchar(150) COLLATE utf8_hungarian_ci NOT NULL,
  `keresztNev` varchar(150) COLLATE utf8_hungarian_ci NOT NULL,
  `szulDatum` date NOT NULL,
  `regDatum` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `jelszo` varchar(32) COLLATE utf8_hungarian_ci NOT NULL,
  `jogosultsag` int(11) NOT NULL,
  PRIMARY KEY (`felhAzon`),
  UNIQUE KEY `felhAzon` (`felhAzon`),
  KEY `jogosultsag` (`jogosultsag`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- TÁBLA KAPCSOLATAI `felhasználók`:
--   `jogosultsag`
--       `jogosultságok` -> `jogAzon`
--

--
-- A tábla adatainak kiíratása `felhasználók`
--

INSERT INTO `felhasználók` (`felhAzon`, `vezetekNev`, `keresztNev`, `szulDatum`, `regDatum`, `jelszo`, `jogosultsag`) VALUES
(1, 'Kovács', 'Gizella', '2002-04-16', '2022-04-12 06:59:45', 'afdd0b4ad2ec172c586e2150770fbf9e', 1),
(2, 'Kiss', 'Antal', '2001-12-16', '2022-04-12 07:03:16', '219c2743e25ff2ea38602ef0a6777067', 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jogosultságok`
--

DROP TABLE IF EXISTS `jogosultságok`;
CREATE TABLE IF NOT EXISTS `jogosultságok` (
  `jogAzon` int(11) NOT NULL AUTO_INCREMENT,
  `megnevezes` varchar(150) COLLATE utf8_hungarian_ci NOT NULL,
  PRIMARY KEY (`jogAzon`),
  UNIQUE KEY `jogAzon` (`jogAzon`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- TÁBLA KAPCSOLATAI `jogosultságok`:
--

--
-- A tábla adatainak kiíratása `jogosultságok`
--

INSERT INTO `jogosultságok` (`jogAzon`, `megnevezes`) VALUES
(1, 'admin'),
(2, 'editor');

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `felhasználók`
--
ALTER TABLE `felhasználók`
  ADD CONSTRAINT `felhasználók_ibfk_1` FOREIGN KEY (`jogosultsag`) REFERENCES `jogosultságok` (`jogAzon`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
