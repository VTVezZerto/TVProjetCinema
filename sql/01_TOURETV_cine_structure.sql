-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-touret-v.alwaysdata.net
-- Generation Time: Nov 24, 2026 at 10:17 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `CARTE`
--

CREATE TABLE `CARTE` (
  `id` int(10) UNSIGNED NOT NULL,
  `nom` varchar(45) NOT NULL,
  `id_salle` int(10) UNSIGNED NOT NULL,
  `numero` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `FILMS`
--

CREATE TABLE `FILMS` (
  `id` int(10) UNSIGNED NOT NULL,
  `titre` varchar(40) NOT NULL,
  `age_limite` int(10) UNSIGNED DEFAULT NULL,
  `duree` int(11) NOT NULL,
  `langue` varchar(20) NOT NULL,
  `resume` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `LCD`
--

CREATE TABLE `LCD` (
  `id` int(10) UNSIGNED NOT NULL,
  `mode` varchar(20) NOT NULL,
  `model` varchar(20) NOT NULL,
  `definition` varchar(20) NOT NULL,
  `couleur` varchar(20) NOT NULL,
  `id_salle` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `MESURE`
--

CREATE TABLE `MESURE` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` datetime NOT NULL,
  `temperature` float DEFAULT NULL,
  `humidite` float DEFAULT NULL,
  `co2` float DEFAULT NULL,
  `id_carte` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SALLE`
--

CREATE TABLE `SALLE` (
  `id` int(10) UNSIGNED NOT NULL,
  `salle` varchar(10) NOT NULL,
  `nb_fauteuils` int(10) UNSIGNED NOT NULL,
  `nb_pmr` int(10) UNSIGNED NOT NULL,
  `taille_ecran` varchar(10) NOT NULL,
  `services` varchar(30) DEFAULT NULL,
  `techs` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SEANCE`
--

CREATE TABLE `SEANCE` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_salle` int(10) UNSIGNED NOT NULL,
  `id_films` int(10) UNSIGNED NOT NULL,
  `heure` datetime NOT NULL,
  `langue` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CARTE`
--
ALTER TABLE `CARTE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_carte_salle` (`id_salle`);

--
-- Indexes for table `FILMS`
--
ALTER TABLE `FILMS`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `LCD`
--
ALTER TABLE `LCD`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lcd_salle` (`id_salle`);

--
-- Indexes for table `MESURE`
--
ALTER TABLE `MESURE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mesure_carte` (`id_carte`);

--
-- Indexes for table `SALLE`
--
ALTER TABLE `SALLE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `SEANCE`
--
ALTER TABLE `SEANCE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_seance_salle` (`id_salle`),
  ADD KEY `fk_seance_films` (`id_films`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CARTE`
--
ALTER TABLE `CARTE`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `FILMS`
--
ALTER TABLE `FILMS`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `LCD`
--
ALTER TABLE `LCD`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `MESURE`
--
ALTER TABLE `MESURE`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SALLE`
--
ALTER TABLE `SALLE`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SEANCE`
--
ALTER TABLE `SEANCE`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CARTE`
--
ALTER TABLE `CARTE`
  ADD CONSTRAINT `fk_carte_salle` FOREIGN KEY (`id_salle`) REFERENCES `SALLE` (`id`);

--
-- Constraints for table `LCD`
--
ALTER TABLE `LCD`
  ADD CONSTRAINT `fk_lcd_salle` FOREIGN KEY (`id_salle`) REFERENCES `SALLE` (`id`);

--
-- Constraints for table `MESURE`
--
ALTER TABLE `MESURE`
  ADD CONSTRAINT `fk_mesure_carte` FOREIGN KEY (`id_carte`) REFERENCES `CARTE` (`id`);

--
-- Constraints for table `SEANCE`
--
ALTER TABLE `SEANCE`
  ADD CONSTRAINT `fk_seance_films` FOREIGN KEY (`id_films`) REFERENCES `FILMS` (`id`),
  ADD CONSTRAINT `fk_seance_salle` FOREIGN KEY (`id_salle`) REFERENCES `SALLE` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
