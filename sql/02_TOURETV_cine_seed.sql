-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-touret-v.alwaysdata.net
-- Generation Time: Nov 24, 2026 at 10:18 AM
-- Server version: 10.11.18-MariaDB
-- PHP Version: 8.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `touret-v_cinema`
--

SET FOREIGN_KEY_CHECKS=0;

-- 1. Tables parentes (aucune dépendance)

--
-- Dumping data for table `SALLE`
--

INSERT INTO `SALLE` (`id`, `salle`, `nb_fauteuils`, `nb_pmr`, `taille_ecran`, `services`, `techs`) VALUES
(1, 'Salle 1', 0, 0, 'N/A', NULL, NULL),
(2, 'Salle 2', 0, 0, 'N/A', NULL, NULL),
(3, 'Salle 3', 0, 0, 'N/A', NULL, NULL),
(4, 'Salle 4', 0, 0, 'N/A', NULL, NULL),
(5, 'Salle 5', 0, 0, 'N/A', NULL, NULL),
(6, 'Salle 6', 0, 0, 'N/A', NULL, 'Premium ICE'),
(7, 'Salle 7', 0, 0, 'N/A', NULL, NULL),
(8, 'Salle 8', 0, 0, 'N/A', NULL, 'Premium ICE'),
(9, 'Salle 9', 0, 0, 'N/A', NULL, NULL),
(10, 'Salle 10', 0, 0, 'N/A', NULL, NULL),
(11, 'Salle 11', 0, 0, 'N/A', NULL, 'grand écran'),
(15, 'Salle Prof', 0, 0, 'N/A', NULL, NULL);

--
-- Dumping data for table `FILMS`
--

INSERT INTO `FILMS` (`id`, `titre`, `age_limite`, `duree`, `langue`, `resume`) VALUES
(4, 'Croquette', 0, 95, 'VF', NULL),
(5, 'Smile', 16, 127, 'VOSTFR', NULL),
(6, 'Lee Miller', 0, 130, 'VF', NULL);

-- 2. Tables enfants de niveau 1 (dépendent de SALLE et/ou FILMS)

--
-- Dumping data for table `CARTE`
--

INSERT INTO `CARTE` (`id`, `nom`, `id_salle`, `numero`) VALUES
(1, 'Capteur 101', 1, 101),
(2, 'Capteur 102', 2, 102),
(3, 'Capteur 103', 3, 103),
(4, 'Capteur 104', 4, 104),
(5, 'Capteur 105', 5, 105),
(6, 'Capteur 106', 6, 106),
(7, 'Capteur 107', 7, 107),
(8, 'Capteur 108', 8, 108),
(9, 'Capteur 109', 9, 109),
(10, 'Capteur 110', 10, 110),
(11, 'Capteur 111', 11, 111),
(12, 'Capteur 201', 1, 201),
(13, 'Capteur 202', 2, 202),
(14, 'Capteur 203', 3, 203),
(15, 'Capteur 204', 4, 204),
(16, 'Capteur 205', 5, 205),
(17, 'Capteur 206', 6, 206),
(18, 'Capteur 207', 7, 207),
(19, 'Capteur 208', 8, 208),
(20, 'Capteur 209', 9, 209),
(21, 'Capteur 210', 10, 210),
(22, 'Capteur 15', 15, 15);

--
-- Dumping data for table `SEANCE`
--

INSERT INTO `SEANCE` (`id`, `id_salle`, `id_films`, `heure`, `langue`) VALUES
(49, 1, 6, '2026-11-04 00:00:00', 'VF'),
(50, 2, 5, '2026-11-12 00:00:00', 'VF'),
(51, 3, 4, '2026-11-20 00:00:00', 'VF'),
(52, 1, 6, '2026-11-25 00:00:00', 'VOSTFR'),
(53, 2, 5, '2026-11-28 00:00:00', 'VF'),
(54, 3, 4, '2026-11-30 00:00:00', 'VF');

-- 3. Tables enfants de niveau 2 (dépend de CARTE)

--
-- Dumping data for table `MESURE`
--

INSERT INTO `MESURE` (`id`, `date`, `temperature`, `humidite`, `co2`, `id_carte`) VALUES
(27, '2026-09-30 14:00:00', 24.12, 31, 620.02, 1),
(28, '2026-09-30 14:01:00', 20.79, 59.46, 941.36, 2),
(43, '2026-09-30 14:16:00', 24.09, 44.59, 696.14, 17),
(44, '2026-09-30 14:17:00', 20.68, 40.68, 1149.32, 18),
(45, '2026-09-30 14:18:00', 24.18, 54.37, 536.91, 19),
(46, '2026-09-30 14:19:00', 24.83, 36.54, 703.56, 20),
(47, '2026-09-30 14:20:00', 26.92, 55.6, 845.56, 21),
(48, '2026-09-30 14:21:00', 24.48, 63.71, 1020.8, 22),
(49, '2026-09-30 14:35:00', 20.83, 31.28, 652.36, 21),
(50, '2026-09-30 14:40:00', 21.14, 38.44, 1154.33, 21),
(51, '2026-09-30 14:45:00', 26.01, 42.59, 924.35, 21),
(52, '2026-09-30 14:50:00', 22.17, 66.58, 767.08, 21);

COMMIT;
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
