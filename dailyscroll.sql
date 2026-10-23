-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2026 at 09:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dailyscroll`
--

-- --------------------------------------------------------

--
-- Table structure for table `folders`
--

CREATE TABLE `folders` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `folders`
--

INSERT INTO `folders` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'read', 'manhwa yang lagi di baca genre historical', '2026-10-23 19:15:11'),
(2, 'wait', 'manhwa yang belom di baca genre historical dan belom tamat', '2026-10-23 19:15:51'),
(3, 'moderen', 'manhwa genre moderen yang belom dibaca', '2026-10-23 19:16:28'),
(4, 'manhua', 'manhua yang belum dan lagi dibaca', '2026-10-23 19:17:05'),
(5, 'end tapi belom selesai', 'manhwa genre historical yang belom dibaca tapi sudah tamat', '2026-10-23 19:17:50'),
(6, 'end', 'semua manhwa yang sudah selesai di babca(tamat)', '2026-10-23 19:18:19'),
(7, 'moderead', 'manhwa genre moderen yang lagi di baca', '2026-10-23 19:18:49'),
(8, 'manga anime', 'manhwa/manga yang ada anime-nya', '2026-10-23 19:19:22');

-- --------------------------------------------------------

--
-- Table structure for table `manhwa`
--

CREATE TABLE `manhwa` (
  `id` int(10) UNSIGNED NOT NULL,
  `folder_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `alternative_title` varchar(255) DEFAULT NULL,
  `synopsis` text DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `author` varchar(150) DEFAULT NULL,
  `status` enum('Reading','Completed','Plan to Read') NOT NULL DEFAULT 'Plan to Read',
  `current_chapter` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_chapters` int(10) UNSIGNED DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL,
  `cover_url` text DEFAULT NULL,
  `personal_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `manhwa`
--

INSERT INTO `manhwa` (`id`, `folder_id`, `title`, `alternative_title`, `synopsis`, `genre`, `author`, `status`, `current_chapter`, `total_chapters`, `rating`, `cover_url`, `personal_notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'How To Get My Husband On My Side', 'How To Win My Husband Over', 'Cerita ini berpusat pada seorang wanita modern yang meninggal secara tragis dalam kecelakaan pesawat. Jiwanya kemudian bereinkarnasi ke dalam dunia novel fantasi-romance yang pernah dibacanya. Sialnya, ia terbangun di dalam tubuh Rudbeckia de Borgia, seorang karakter figuran berwajah cantik yang ditakdirkan memiliki nasib yang sangat brutal.\r\nDi dalam cerita asli novelnya, keluarga Borgia (dipimpin oleh sang Ayah yang menjabat sebagai Paus) adalah keluarga korup, manipulatif, dan kejam. Mereka memanfaatkan Rudbeckia sebagai alat politik dengan menikahkannya sebanyak tiga kali demi memperluas kekuasaan. Pernikahan politik ketiganya adalah dengan Iske van Omerta, seorang ksatria suci terkuat dari wilayah Utara (Kerajaan Britannia) yang sangat membenci keluarga Borgia. Tragisnya, di alur asli novel, Rudbeckia nantinya akan tewas dibunuh oleh suaminya sendiri setelah keluarga Borgia memicu kejatuhan politik wilayah Utara.', 'Drama, Romance, Fantasy, Reinkarnasi, Kerajaan', 'Spice&Kitty,SIRU', 'Reading', 137, 137, 7.6, 'https://i.pinimg.com/1200x/e6/f4/13/e6f4138e88f1be866144a5027a43a126.jpg', 'asik sih apalagi melihat di kehidupan yang sekarang izek-nya mulai berubah,tapi kesel sama abang nya ruby ganteng tapiobses dan jadi jahat', '2026-10-23 19:30:58', '2026-10-23 19:32:04'),
(2, 1, 'The Villainess Empress\'s Attendant / An Exclusive Maid of the Wicked Empress', 'An Exclusive Maid of the Wicked Empress', 'Cerita bermula ketika Paresa Menzel menerima pekerjaan dengan bayaran yang sangat tinggi untuk menjadi pelayan eksklusif (pribadi) bagi Permaisuri, yang terkenal di seluruh penjuru negeri sebagai wanita kejam dan berhati iblis. Paresa awalnya sudah bersiap menghadapi siksaan atau kepribadian yang mengerikan dari majikan barunya tersebut.\r\nNamun, setelah bekerja langsung di istana, Paresa justru menemukan fakta yang sebaliknya. Sang Permaisuri ternyata hanyalah wanita kesepian yang naif dan menyembunyikan bekas luka emosional yang mendalam akibat intrik politik istana. Melihat sisi rapuh sang Permaisuri, Paresa yang aslinya adalah seorang mantan ksatria tangguh bersumpah di dalam hatinya untuk melindungi sang Permaisuri dari segala bahaya dan konspirasi politik istana.\r\nMasalah rumit mulai muncul ketika Putra Mahkota menyadari bahwa Paresa bukanlah pelayan biasa. Pangeran yang memiliki ketajaman insting mencurigai identitas rahasia Paresa sebagai pelarian politik atau mata-mata. Di tengah permainan tipu daya istana, fitnah antar-pelayan, dan perebutan kekuasaan, Paresa harus berjuang menjaga rahasia masa lalunya agar tidak membahayakan dirinya sendiri maupun Permaisuri yang kini sangat ia sayangi.', 'Fantasy, Romance, Historical, Drama, Knight/Supernatural Power', 'Haeyeon, Zzaribo / Antstudio', 'Reading', 77, 77, 8.6, 'https://i.pinimg.com/736x/11/3a/e4/113ae45d0c41fd80b8561a7dd8bbaefb.jpg', 'sukak sih tapi kesel karna fl nya gak mau nunjukin kekuatannya', '2026-10-23 19:38:17', '2026-10-23 19:38:17'),
(3, 1, 'I Don\'t Want to Be a Lady', 'I Refuse to Be a Lady', 'Arianne Bornes dibesarkan dalam penderitaan dan tekanan oleh ayahnya sendiri. Ketika sang ayah berencana menjualnya untuk dijadikan selir/selir tambahan dari Putra Mahkota, Arianne menolak untuk dijadikan alat politik orang lain.   Demi mengambil alih kendali atas hidupnya sendiri dan membalas dendam, Arianne mendekati sang Duke yang merupakan musuh ayahnya. Ia menawarkan kesepakatan rahasia berupa pernikahan kontrak dan informasi penting mengenai korupsi ayahnya. Berbekal kecerdasan, ketegasan, serta keahliannya bertarung, Arianne bertekad menghancurkan ekspektasi masyarakat patriarki dan menjadi pemenang atas takdirnya sendiri!', 'Romance, Fantasy, Drama, Historical', 'Biyan, Jeommyeon, Yun Moo-Woo / yoonmuu, Seon', 'Reading', 47, 47, 7.7, 'https://i.pinimg.com/736x/ea/21/71/ea21719e622f057b4bcb1b28d6c06325.jpg', 'bagus sih tapi belom update', '2026-10-23 19:44:19', '2026-10-23 19:44:19'),
(4, 1, 'The Male Lead\'s Father Refuses to Break Off Our Engagement', 'The Male Lead\'s Father Refuses to Cancel the Engagement', 'Renata terlahir kembali ke dalam dunia novel fantasi komedi romantis sebagai pemeran pendukung yang ditakdirkan mati tragis. Dalam alur aslinya, sang pemeran utama pria (Male Lead) ditakdirkan untuk jatuh cinta dengan pahlawan wanita (Female Lead), sementara pertunangannya dengan Renata seharusnya dibatalkan.\r\n\r\nSadar akan nasib buruk yang menantinya, Renata memutuskan untuk bertindak lebih cepat: ia berusaha membatalkan pertunangannya sendiri sedini mungkin agar bisa hidup tenang dan aman. Namun, rencananya berantakan ketika ayah dari calon tunangannya—seorang Duke legendaris yang dingin dan sangat berpengaruh—secara tegas menolak pembatalan pertunangan tersebut! Ayah sang Male Lead justru bersikeras mempertahankan Renata di keluarganya, memicu berbagai situasi rumit dan tak terduga yang sama sekali berbeda dari alur cerita novel aslinya.', 'Romance, Fantasy, Drama, Reincarnation, Comedy, Historical', 'Lee Ji-ah, Mong-geul, Eum', 'Reading', 84, 84, 5.8, 'https://i.pinimg.com/736x/cb/4c/7d/cb4c7d74d7f11b5e8921cf4b9316bea5.jpg', 'bagusssss', '2026-10-23 19:48:26', '2026-10-23 19:48:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `manhwa`
--
ALTER TABLE `manhwa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_manhwa_folder` (`folder_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `manhwa`
--
ALTER TABLE `manhwa`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `manhwa`
--
ALTER TABLE `manhwa`
  ADD CONSTRAINT `fk_manhwa_folder` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
