-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Feb 2021 pada 07.54
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lapmat`
--

DELIMITER $$
--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `f_aduan` (`niks` CHAR(16)) RETURNS INT(11) BEGIN DECLARE amount INT;
SELECT COUNT(*) AS jumlahAduan INTO amount FROM pengaduan WHERE NIK = niks;
RETURN amount;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `masyarakat`
--

CREATE TABLE `masyarakat` (
  `NIK` char(16) NOT NULL,
  `NAMA` varchar(35) DEFAULT NULL,
  `USERNAME` varchar(25) DEFAULT NULL,
  `PASSWORD` varchar(32) DEFAULT NULL,
  `TELP` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `masyarakat`
--

INSERT INTO `masyarakat` (`NIK`, `NAMA`, `USERNAME`, `PASSWORD`, `TELP`) VALUES
('1212343456567878', 'Eizen', 'Eizen', '123456', '089567894441'),
('909878765654343', 'Alisha', 'Alisha', '654321', '089586594678');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaduan`
--

CREATE TABLE `pengaduan` (
  `ID_PENGADUAN` int(11) NOT NULL,
  `TGL_PENGADUAN` date DEFAULT NULL,
  `NIK` char(16) DEFAULT NULL,
  `ISI_LAPORAN` text DEFAULT NULL,
  `FOTO` varchar(255) DEFAULT NULL,
  `STATUS` enum('0','proses','selesai') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pengaduan`
--

INSERT INTO `pengaduan` (`ID_PENGADUAN`, `TGL_PENGADUAN`, `NIK`, `ISI_LAPORAN`, `FOTO`, `STATUS`) VALUES
(1, '2021-01-01', '1212343456567878', 'woi', 'odo.jpg', '0'),
(2, '2021-01-01', '1212343456567878', 'woi', 'odo.jpg', '0'),
(3, '2021-01-01', '1212343456567878', 'woi', 'odo.jpg', '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `ID_PETUGAS` int(11) NOT NULL,
  `NAMA_PETUGAS` varchar(35) DEFAULT NULL,
  `USERNAME` varchar(25) DEFAULT NULL,
  `PASSWORD` varchar(32) DEFAULT NULL,
  `TELP` varchar(13) DEFAULT NULL,
  `LEVEL` enum('admin','petugas') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tanggapan`
--

CREATE TABLE `tanggapan` (
  `ID_TANGGAPAN` int(11) NOT NULL,
  `ID_PENGADUAN` int(11) DEFAULT NULL,
  `TGL_TANGGAPAN` date DEFAULT NULL,
  `TANGGAPAN` text DEFAULT NULL,
  `ID_PETUGAS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `masyarakat`
--
ALTER TABLE `masyarakat`
  ADD PRIMARY KEY (`NIK`);

--
-- Indeks untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`ID_PENGADUAN`),
  ADD KEY `FK_REFERENCE_4` (`NIK`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`ID_PETUGAS`);

--
-- Indeks untuk tabel `tanggapan`
--
ALTER TABLE `tanggapan`
  ADD PRIMARY KEY (`ID_TANGGAPAN`),
  ADD KEY `FK_REFERENCE_3` (`ID_PENGADUAN`),
  ADD KEY `FK_REFERENCE_5` (`ID_PETUGAS`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD CONSTRAINT `FK_REFERENCE_4` FOREIGN KEY (`NIK`) REFERENCES `masyarakat` (`NIK`);

--
-- Ketidakleluasaan untuk tabel `tanggapan`
--
ALTER TABLE `tanggapan`
  ADD CONSTRAINT `FK_REFERENCE_3` FOREIGN KEY (`ID_PENGADUAN`) REFERENCES `pengaduan` (`ID_PENGADUAN`),
  ADD CONSTRAINT `FK_REFERENCE_5` FOREIGN KEY (`ID_PETUGAS`) REFERENCES `petugas` (`ID_PETUGAS`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
