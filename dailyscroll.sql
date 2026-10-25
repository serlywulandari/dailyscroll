-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2026 at 06:13 AM
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
(2, 1, 'The Villainess Empress\'s Attendant / An Exclusive Maid of the Wicked Empress', 'An Exclusive Maid of the Wicked Empress', 'Cerita bermula ketika Paresa Menzel menerima pekerjaan dengan bayaran yang sangat tinggi untuk menjadi pelayan eksklusif (pribadi) bagi Permaisuri, yang terkenal di seluruh penjuru negeri sebagai wanita kejam dan berhati iblis. Paresa awalnya sudah bersiap menghadapi siksaan atau kepribadian yang mengerikan dari majikan barunya tersebut.\r\nNamun, setelah bekerja langsung di istana, Paresa justru menemukan fakta yang sebaliknya. Sang Permaisuri ternyata hanyalah wanita kesepian yang naif dan menyembunyikan bekas luka emosional yang mendalam akibat intrik politik istana. Melihat sisi rapuh sang Permaisuri, Paresa yang aslinya adalah seorang mantan ksatria tangguh bersumpah di dalam hatinya untuk melindungi sang Permaisuri dari segala bahaya dan konspirasi politik istana.\r\nMasalah rumit mulai muncul ketika Putra Mahkota menyadari bahwa Paresa bukanlah pelayan biasa. Pangeran yang memiliki ketajaman insting mencurigai identitas rahasia Paresa sebagai pelarian politik atau mata-mata. Di tengah permainan tipu daya istana, fitnah antar-pelayan, dan perebutan kekuasaan, Paresa harus berjuang menjaga rahasia masa lalunya agar tidak membahayakan dirinya sendiri maupun Permaisuri yang kini sangat ia sayangi.', 'Fantasy, Romance, Historical, Drama, Knight/Supernatural Power', 'Haeyeon, Zzaribo / Antstudio', 'Reading', 77, NULL, 8.6, 'https://i.pinimg.com/736x/11/3a/e4/113ae45d0c41fd80b8561a7dd8bbaefb.jpg', 'sukak sih tapi kesel karna fl nya gak mau nunjukin kekuatannya', '2026-10-23 19:38:17', '2026-10-23 20:17:19'),
(3, 1, 'I Don\'t Want to Be a Lady', 'I Refuse to Be a Lady', 'Arianne Bornes dibesarkan dalam penderitaan dan tekanan oleh ayahnya sendiri. Ketika sang ayah berencana menjualnya untuk dijadikan selir/selir tambahan dari Putra Mahkota, Arianne menolak untuk dijadikan alat politik orang lain.   Demi mengambil alih kendali atas hidupnya sendiri dan membalas dendam, Arianne mendekati sang Duke yang merupakan musuh ayahnya. Ia menawarkan kesepakatan rahasia berupa pernikahan kontrak dan informasi penting mengenai korupsi ayahnya. Berbekal kecerdasan, ketegasan, serta keahliannya bertarung, Arianne bertekad menghancurkan ekspektasi masyarakat patriarki dan menjadi pemenang atas takdirnya sendiri!', 'Romance, Fantasy, Drama, Historical', 'Biyan, Jeommyeon, Yun Moo-Woo / yoonmuu, Seon', 'Reading', 47, 47, 7.7, 'https://i.pinimg.com/736x/ea/21/71/ea21719e622f057b4bcb1b28d6c06325.jpg', 'bagus sih tapi belom update', '2026-10-23 19:44:19', '2026-10-23 19:44:19'),
(4, 1, 'The Male Lead\'s Father Refuses to Break Off Our Engagement', 'The Male Lead\'s Father Refuses to Cancel the Engagement', 'Renata terlahir kembali ke dalam dunia novel fantasi komedi romantis sebagai pemeran pendukung yang ditakdirkan mati tragis. Dalam alur aslinya, sang pemeran utama pria (Male Lead) ditakdirkan untuk jatuh cinta dengan pahlawan wanita (Female Lead), sementara pertunangannya dengan Renata seharusnya dibatalkan.\r\n\r\nSadar akan nasib buruk yang menantinya, Renata memutuskan untuk bertindak lebih cepat: ia berusaha membatalkan pertunangannya sendiri sedini mungkin agar bisa hidup tenang dan aman. Namun, rencananya berantakan ketika ayah dari calon tunangannya—seorang Duke legendaris yang dingin dan sangat berpengaruh—secara tegas menolak pembatalan pertunangan tersebut! Ayah sang Male Lead justru bersikeras mempertahankan Renata di keluarganya, memicu berbagai situasi rumit dan tak terduga yang sama sekali berbeda dari alur cerita novel aslinya.', 'Romance, Fantasy, Drama, Reincarnation, Comedy, Historical', 'Lee Ji-ah, Mong-geul, Eum', 'Reading', 84, 84, 5.8, 'https://i.pinimg.com/736x/cb/4c/7d/cb4c7d74d7f11b5e8921cf4b9316bea5.jpg', 'bagusssss', '2026-10-23 19:48:26', '2026-10-23 19:48:26'),
(5, 1, 'She No Longer Wields Her Sword', 'The Female Knight No Longer Wields a Sword', 'Ludia Centrin adalah seorang ksatria wanita tangguh yang mendedikasikan seluruh hidup, pedang, dan kesetiannya untuk melindungi Pangeran Frau. Namun, pengabdian tulusnya justru dibalas pengkhianatan kejam—ia difitnah melakukan pengkhianatan terhadap Kekaisaran hingga akhirnya dihukum mati secara tragis.\r\n\r\nSecara ajaib, Ludia terbangun kembali dalam tubuh Elfreda, putri seorang Count yang lemah. Dalam kehidupan barunya ini, ia tidak lagi terbangun sebagai ksatria penembus garis depan, melainkan sosok yang dilimpahi dengan kekuatan sihir dan divine power yang luar biasa. Bertekad tidak akan lagi memegang pedangnya demi orang yang salah, Ludia/Elfreda berusaha mengungkap rahasia serta konspirasi di balik tuduhan palsu yang mengakhiri hidupnya dulu.', 'Romance, Fantasy, Drama, Reincarnation, Action', 'RAMI.K, Studio Jilpung / Studio Zilpung', 'Reading', 41, 70, 8.8, 'https://i.pinimg.com/736x/d3/eb/35/d3eb35b9bd0cb91e597fada67139124f.jpg', 'udah agak lupa soalny sub indo-nya cuman sampe chapter 41', '2026-10-23 20:05:31', '2026-10-23 20:05:31'),
(6, 6, 'Electrifying Confession', 'Powerful Confession', 'Hari Jeon adalah seorang siswi SMA yang memiliki penyakit jantung. Suatu hari, ia secara misterius terkena kutukan unik: setiap kali detak jantungnya berpacu akibat perasaan cintanya pada Jeong-won (cinta bertepuk sebelah tangannya), tubuhnya akan mengeluarkan sengatan listrik secara harfiah ke orang-orang di sekitarnya!   Situasi semakin rumit ketika hadir Yura, yang ingin memanfaatkan fenomena kutukan tersebut. Di tengah gejolak perasaan cinta pertama, persahabatan, dan kutukan kejutan listrik yang tak terkendali, akankah Hari berani mengungkapkan perasaannya secara jujur atau memilih bertahan dalam zona nyaman persahabatan?', 'Romance, Comedy, School Life, Supernatural, Drama', 'SONCHAYANG, Nyangji', 'Completed', 85, 85, 9.6, 'https://i.pinimg.com/736x/9e/92/c3/9e92c3fa6580dd5a95e0fdbaeb21bf72.jpg', 'sukakkkkk jarang ada yang alurnya begini', '2026-10-23 20:09:18', '2026-10-23 20:16:54'),
(7, 7, 'Serim\'s Golden Rule', 'Serim\'s Iron Rule', 'Han Serim adalah siswi SMA yang sangat ditakuti di sekolahnya karena beredar rumor bahwa ia adalah seorang gengster/preman. Ia hidup tanpa kepedulian seolah tidak ada hari esok. Di sisi lain, Kang Seung-woo adalah murid teladan sempurna (\"anak emas\") yang hidupnya terencana sangat rapi.\r\n\r\nKetika Seung-woo dipasangkan dengan Serim dalam sebuah program mentor-mentee, sang murid teladan bertekad mendekati Serim agar proyeknya berjalan sempurna. Namun, kepribadian Serim yang tak terduga dan penuh misteri membuat Seung-woo kewalahan. Dimulailah hubungan romansa sekolah yang penuh dinamika unik antara si cewek pembuat masalah (delinquent) dan si cowok teladan (model student)!', 'Romance, School Life, Drama, Comedy', 'Seyoon, Sun_ah / Seonna', 'Reading', 20, NULL, 9.6, 'https://i.pinimg.com/736x/b2/d6/97/b2d69734a76752086adcf8678ddda1bc.jpg', 'sukakkkk, kepo banget sama latar belakangnya serim yang misterius', '2026-10-23 20:12:55', '2026-10-23 20:16:32'),
(8, 7, 'Purely Delinquent', 'Rebellious Innocence', 'Setelah dikhianati oleh cinta pertamanya yang ternyata seorang pemain wanita (\"central heating/player\"), Kang Cheonga berikrar tidak akan pernah lagi jatuh cinta pada pria dengan tipe serupa. Namun, nasib berkata lain ketika ia justru terikat situasi dan hubungan dengan Ban Seokjae—seorang siswa yang dikenal lihai, berpenampilan delinquent, dan memiliki reputasi flirty/playboy.\r\n\r\nSeokjae biasanya bersikap santai, acuh tak acuh, serta pandai mempermainkan perasaan orang lain. Tetapi anehnya, hanya kepada Cheonga-lah ia tidak bisa menjaga jarak dan selalu bertindak penuh keposesifan serta perhatian yang tak terduga. Di tengah hubungan pikat-mempikat dan kepura-puraan ini, Cheonga terus dibuat bingung: apakah Seokjae hanya sedang mempermainkannya, ataukah perasaan manis sang delinquent ini benar-benar tulus?', 'Romance, Comedy, School Life, Drama', 'Kim Su-Bak, Ssangpil', 'Reading', 30, NULL, 9.6, 'https://i.pinimg.com/736x/e3/34/ba/e334ba4b2171d581de0a86b5ff027d3c.jpg', 'sukakkkk cowoknya comel bettt', '2026-10-23 20:16:13', '2026-10-23 20:16:13'),
(9, 7, 'Part-Time Couple', 'Part-Time Married Couple', 'Cinta pertama sekaligus mantan kekasih Da-in, Kang Seo-jun, mendadak muncul kembali dalam hidupnya dan mengajukan penawaran gila: sebuah pernikahan kontrak selama 100 hari! Seo-jun mengklaim bahwa jika ia tidak menikah, ia berada dalam situasi hidup dan mati.\r\n\r\nMeskipun harga dirinya sedikit terluka oleh tawaran yang tiba-tiba itu, Da-in—yang tidak mau kalah begitu saja—memberanikan diri menyetujui dan menegosiasikan syarat-syaratnya sendiri. Maka dimulailah kehidupan pernikahan kontrak \"paruh waktu\" mereka. Di tengah kesepakatan yang penuh perhitungan ini, perasaan masa lalu yang belum usai perlahan-lahan mulai muncul kembali, membuat hitungan mundur menuju hari ke-100 menjadi semakin rumit.', 'Romance, Drama, Modern, Josei', 'Choi Yeon, Sancha', 'Reading', 54, NULL, 9.1, 'https://i.pinimg.com/736x/4d/a8/84/4da8849991152b6edaef944e36acd74f.jpg', NULL, '2026-10-23 20:20:01', '2026-10-23 20:20:14'),
(10, 7, 'Merry Psycho', NULL, NULL, NULL, NULL, 'Reading', 0, NULL, NULL, 'https://i.pinimg.com/736x/e2/3b/08/e23b082e40d1fc4a03d39fd722a1ad29.jpg', NULL, '2026-10-23 20:22:57', '2026-10-23 20:22:57'),
(11, NULL, 'proof of dignity', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/14/df/01/14df0146775b15fb499e6f28731050c6.jpg', NULL, '2026-10-23 20:24:33', '2026-10-23 20:24:33'),
(12, NULL, 'endless yearning', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/1a/0e/0a/1a0e0adf50ff22dc68e14e8c64648ab4.jpg', NULL, '2026-10-23 20:25:05', '2026-10-23 20:25:05'),
(13, NULL, 'the 100 curses of illeston mansion', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/08/84/95/088495983c3ccf41c3fa0507fa22d23e.jpg', NULL, '2026-10-23 20:25:42', '2026-10-23 20:25:42'),
(14, NULL, 'how to survive thr horror novel i wrote', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/e1/91/9a/e1919af1b03e9d010e51cb6f7c525517.jpg', NULL, '2026-10-23 20:26:28', '2026-10-23 20:26:28'),
(15, NULL, 'dawn of vengeance', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/29/d4/d6/29d4d6ec9ce7975839e295dbc0d64a68.jpg', NULL, '2026-10-23 20:26:55', '2026-10-23 20:26:55'),
(16, NULL, 'i tamed my ex-husband\'s mad dog', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/6c/73/60/6c7360901b6959830622446d00325ba8.jpg', NULL, '2026-10-23 20:27:42', '2026-10-23 20:27:42'),
(17, NULL, 'selfish romance', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/0f/e9/ca/0fe9ca62807cc4e402d9541798aea96d.jpg', NULL, '2026-10-23 20:28:52', '2026-10-23 20:28:52'),
(18, NULL, 'just twilight', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/17/3e/18/173e184cd743b7c2e1e22f31562353ca.jpg', NULL, '2026-10-23 20:29:27', '2026-10-23 20:29:27'),
(19, NULL, 'Daytime in the Bunker', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/22/f9/71/22f971a4556ce1c837f84de082f2d0f1.jpg', NULL, '2026-10-23 20:29:56', '2026-10-23 20:29:56'),
(20, NULL, '𝐓𝐞𝐚𝐫𝐬 𝐎𝐧 𝐀 𝐖𝐢𝐭𝐡𝐞𝐫𝐞𝐝 𝐅𝐥𝐨𝐰𝐞𝐫𝐬', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/00/69/6a/00696a0db9cda17872cc6091d4a4280e.jpg', NULL, '2026-10-23 20:30:56', '2026-10-23 20:30:56'),
(21, NULL, 'The Mansion Awaits Spring', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/8a/f3/d8/8af3d8f1d88cff249cf109c0993f1978.jpg', NULL, '2026-10-23 20:31:19', '2026-10-23 20:31:19'),
(22, NULL, 'Behind the Laughter of the Surviving Princess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/9b/2c/27/9b2c279dfa8fce09bf09b18b1f2f37c7.jpg', NULL, '2026-10-23 20:31:48', '2026-10-23 20:31:48'),
(23, NULL, 'free in dreams', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/d3/0a/ee/d30aee9b25bc2c331650ab6b032cf784.jpg', NULL, '2026-10-23 20:32:37', '2026-10-23 20:32:37'),
(24, NULL, 'unofficial campus couple', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/55/0e/b5/550eb5b0a002afb90398499b00e0ee0d.jpg', NULL, '2026-10-23 20:34:10', '2026-10-23 20:34:10'),
(25, NULL, 'undercover! chaebol high school', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/b2/37/f7/b237f71b5822aca293f07a7062ec1fdf.jpg', NULL, '2026-10-23 20:35:15', '2026-10-23 20:35:15'),
(26, NULL, 'operation pure love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/ac/38/20/ac3820f01d6c3d65f58279b13fa63074.jpg', NULL, '2026-10-23 20:35:46', '2026-10-23 20:35:46'),
(27, NULL, 'for my derelict favorite', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/cf/a7/b4/cfa7b46e06b50014d72b75342096c6de.jpg', NULL, '2026-10-23 20:36:29', '2026-10-23 20:36:29'),
(28, NULL, 'erica when a friend is obsessed with me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/7e/75/be/7e75beaad5b1e06dac17b076293db397.jpg', NULL, '2026-10-23 20:37:17', '2026-10-23 20:37:17'),
(29, NULL, 'Not Your Typical Reincarnation Story', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c3/ab/74/c3ab7433fc7856209a025fb44cc79cb5.jpg', NULL, '2026-10-23 20:37:40', '2026-10-23 20:37:40'),
(30, NULL, 'The forgotten field', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/76/49/fa/7649fafc12c8cf0a8e5ec95946cc2d24.jpg', NULL, '2026-10-23 20:38:22', '2026-10-23 20:38:22'),
(31, NULL, 'I Only Need the Duke’s Child', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/b8/91/b7/b891b7384c7242249da36c04a696ca3a.jpg', NULL, '2026-10-23 20:38:45', '2026-10-23 20:38:45'),
(32, NULL, 'My Possession Became a Ghost Story', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/02/a5/95/02a595dfb5337b7b57932f12019a9d5a.jpg', NULL, '2026-10-23 20:39:14', '2026-10-23 20:39:14'),
(33, NULL, 'the flower who bears the sword', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/6d/24/09/6d240993eeb9d721dcb0478069ac1b4f.jpg', NULL, '2026-10-23 20:39:40', '2026-10-24 03:32:17'),
(34, NULL, 'The Archduke\'s Bride Is a Hell Warrior', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/17/c1/ae/17c1ae058b765811441bda7641b3f750.jpg', NULL, '2026-10-23 20:40:09', '2026-10-23 20:40:09'),
(35, NULL, 'The Villainess Just Wants To Live In Peace!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a8/12/98/a81298c945d180f1baaa9ff1baa3989c.jpg', NULL, '2026-10-23 20:40:41', '2026-10-23 20:40:41'),
(36, NULL, 'i will fall with the emperor', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/fe/0c/ec/fe0cec62f6f0b826331a21534f03636a.jpg', NULL, '2026-10-23 20:40:55', '2026-10-24 03:33:06'),
(37, NULL, 'I\'ve Fallen In Love With Empire\'s Greatest Villainess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/e5/a1/ac/e5a1ac808d8fc59aab4b100358e33ee0.jpg', NULL, '2026-10-23 20:41:16', '2026-10-23 20:41:16'),
(38, NULL, 'my aggravating sovereign', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/56/61/27/5661275ec5dbbcd93f04d241b9968406.jpg', NULL, '2026-10-23 20:41:34', '2026-10-24 03:33:52'),
(39, NULL, 'Grand Duchess’s Constitution', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/ea/e2/1d/eae21d06f4896f6e2b62c41638ad18fe.jpg', NULL, '2026-10-23 20:41:53', '2026-10-23 20:41:53'),
(40, NULL, 'i will seduce the northern deke', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/27/29/f5/2729f56676af5dd03b9f79bf22bd00f2.jpg', NULL, '2026-10-23 20:42:18', '2026-10-24 03:42:31'),
(41, NULL, 'Perks of being a s class heroine', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/6d/8a/5d/6d8a5dc7532f9f8e85edf1f3153439d9.jpg', NULL, '2026-10-23 20:42:43', '2026-10-23 20:42:43'),
(42, 5, 'the villainess is a marionette', NULL, NULL, NULL, NULL, 'Plan to Read', 0, 112, NULL, 'https://i.pinimg.com/1200x/9b/e6/e3/9be6e3c45b0d471dd66420e9e961cca9.jpg', NULL, '2026-10-23 20:43:05', '2026-10-24 03:41:32'),
(43, NULL, 'My Villainous Family Won’t Let Me Be', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/d7/0b/1d/d70b1d5daf8de45a2e06ff7779a72889.jpg', NULL, '2026-10-23 20:43:38', '2026-10-23 20:43:38'),
(44, NULL, 'The Male Lead? I Don’t Want Him', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/08/5e/f1/085ef131a7a7fdb9e0993e651a1deeae.jpg', NULL, '2026-10-23 20:43:55', '2026-10-23 20:43:55'),
(45, NULL, 'the villainess directs a romance fantasy', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/58/55/b8/5855b838848768ac6b3dcb60e87179c5.jpg', NULL, '2026-10-23 20:44:23', '2026-10-23 20:44:23'),
(46, NULL, 'Don\'t look for the resurrected Villainess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/42/3b/a9/423ba9457fc01d4831cc05577605b267.jpg', NULL, '2026-10-23 20:44:47', '2026-10-23 20:44:47'),
(47, NULL, 'you will pay with your life for deceiving me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/3d/1b/41/3d1b414a29c49b196ae7a381e97c04bc.jpg', NULL, '2026-10-23 20:45:09', '2026-10-24 03:57:08'),
(48, NULL, 'the devil raises a lady', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/64/fd/1b/64fd1b9f9a67bc730c6c40de3d32227a.jpg', NULL, '2026-10-23 20:45:23', '2026-10-24 03:51:08'),
(49, NULL, 'Perks of being a villainess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/52/90/fa/5290fa35aeec24c89429e04838c1f3d8.jpg', NULL, '2026-10-23 20:46:00', '2026-10-23 20:46:00'),
(50, NULL, 'Father, I Don\'t Want This Marriage', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/f6/82/22/f68222ab5ea6054655667c78a6ff33b6.jpg', NULL, '2026-10-23 20:46:19', '2026-10-23 20:46:19'),
(51, NULL, 'the reason why raeliana ended up at the duke\'s mansion', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/2e/2c/ed/2e2cedf142deceae8b34b7d1dfe557e6.jpg', NULL, '2026-10-23 20:46:42', '2026-10-24 04:01:54'),
(52, NULL, 'doctor elise: the royal lady with the lamp', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/10/8d/7f/108d7f5d655ffa35453c2b8e152cc9c1.jpg', NULL, '2026-10-23 20:47:00', '2026-10-24 04:00:34'),
(53, NULL, 'author of my own destiny', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/d8/09/5a/d8095a07a98a07a54e93f7f5d88cb66d.jpg', NULL, '2026-10-23 20:47:44', '2026-10-24 03:53:52'),
(54, NULL, 'i thought my time was up!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/3d/3e/e2/3d3ee2a0616e3fdbf11c80fb5362815f.jpg', NULL, '2026-10-23 20:48:18', '2026-10-23 20:48:18'),
(55, NULL, 'I\'m the Queen in This Life', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/ab/78/84/ab78844929d266ec7c06e150301940ee.jpg', NULL, '2026-10-23 20:48:38', '2026-10-23 20:48:38'),
(56, NULL, 'Trapped In A Soap Opera', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/00/53/c6/0053c699b3c5e6ea9e391f8c63a1b302.jpg', NULL, '2026-10-23 20:49:00', '2026-10-23 20:49:00'),
(57, NULL, 'mybe meant to be', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/36/7f/58/367f5822d204f8eae05c2de852d51cfb.jpg', NULL, '2026-10-23 20:49:28', '2026-10-24 03:46:44'),
(58, NULL, 'couple breaker', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/74/a0/64/74a0642fa73b6cfbef6720a24e8756c7.jpg', NULL, '2026-10-23 20:49:54', '2026-10-23 20:49:54'),
(59, NULL, 'childhood friend complex', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/41/b4/f3/41b4f3a4814b1d415335b1110953c4d9.jpg', NULL, '2026-10-23 20:50:16', '2026-10-24 03:47:59'),
(60, NULL, 'Iseop\'s Romance', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/51/20/76/512076d0c5d2324863115e72d23890b6.jpg', NULL, '2026-10-23 20:50:39', '2026-10-23 20:50:39'),
(61, NULL, 'My bias gets on the last train', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/da/fe/56/dafe56beff5ef63c474efad109975d8f.jpg', NULL, '2026-10-23 20:51:00', '2026-10-23 20:51:00'),
(62, NULL, 'Duchess in Ruins', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/35/a6/2a/35a62aeab1b526d8a5d1fc3007d45714.jpg', NULL, '2026-10-23 20:51:38', '2026-10-23 20:51:38'),
(63, NULL, 'The Countess Makes a Comeback', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/f2/fd/9b/f2fd9be616b946625f443432f8ca514a.jpg', NULL, '2026-10-23 20:51:58', '2026-10-23 20:51:58'),
(64, NULL, 'My Child Will Have a Different Father', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/fa/c7/83/fac7836af719ddae66636f24cc81889b.jpg', NULL, '2026-10-23 20:52:17', '2026-10-23 20:52:17'),
(65, NULL, 'Beware of the Strongest Man Who Is Crazy About Me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/66/16/81/66168165ea3e06e4c29207f028168c0e.jpg', NULL, '2026-10-23 20:52:37', '2026-10-23 20:52:37'),
(66, NULL, 'l', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/f7/fb/4f/f7fb4f62686fea1fe117b30b7396eb51.jpg', NULL, '2026-10-23 20:53:04', '2026-10-23 20:53:04'),
(67, NULL, 'I Got Engaged to the Blind Duke', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a7/61/91/a7619129f3e0373aafa0718837eda6f4.jpg', NULL, '2026-10-23 20:53:24', '2026-10-23 20:53:24'),
(68, NULL, '𝑇𝘩𝑒 𝐶𝑢𝑝 𝑜𝑓 𝑉𝑒𝑛𝑔𝑒𝑎𝑛𝑐𝑒 𝐼𝑠 𝑖𝑛 𝑌𝑜𝑢𝑟 𝐻𝑎𝑛𝑑𝑠', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bf/b1/c4/bfb1c40f17124708f1e07083ce2bc5f6.jpg', NULL, '2026-10-23 20:54:01', '2026-10-23 20:54:01'),
(69, NULL, 'How to Perfectly End a Contract Marriage', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/6a/89/a2/6a89a2607b3589198f90e6891bd70f97.jpg', NULL, '2026-10-23 20:54:19', '2026-10-23 20:54:19'),
(70, NULL, 'My Beloved Oppressor', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/77/19/50/771950f903989d1d9736fe84b88b1309.jpg', NULL, '2026-10-23 20:54:39', '2026-10-23 20:54:39'),
(71, NULL, 'm', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/b4/bd/0f/b4bd0f93ce19e0ddaf265d0ec97743fe.jpg', NULL, '2026-10-23 20:55:00', '2026-10-23 20:55:00'),
(72, NULL, 'Darling, Why Can\'t We Divorce?', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/f6/19/87/f6198704ff698d03bdefef2da95a1d0a.jpg', NULL, '2026-10-23 20:55:30', '2026-10-23 20:55:30'),
(73, NULL, 'the broken ring', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/23/2a/06/232a0685d04ed1970300f5a3382ea9ee.jpg', NULL, '2026-10-23 20:56:34', '2026-10-23 20:56:34'),
(74, NULL, 'My Evil Husband is Obsessed with the Wrong Person', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/25/7e/4f/257e4ffad0d4bf27c214b2ebba0d5906.jpg', NULL, '2026-10-23 20:57:03', '2026-10-23 20:57:03'),
(75, NULL, 'Villain, I’ll Do Everything Except Marriage for You!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/0a/13/ec/0a13ec44657715eebe6eab65a69893eb.jpg', NULL, '2026-10-23 20:57:20', '2026-10-23 20:57:20'),
(76, NULL, 'be my side', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/03/3d/f2/033df25a7fcb1fc40117ec89ea52febb.jpg', NULL, '2026-10-23 20:57:58', '2026-10-23 20:57:58'),
(77, NULL, 'ashtarte', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/de/6a/32/de6a320b3228fa64a0c5fd4b9fbf584e.jpg', NULL, '2026-10-23 20:58:43', '2026-10-23 20:58:43'),
(78, NULL, 'I Became the Wife of the Monstrous Crown Prince', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/9d/f4/87/9df4876336d65a71ab6f9470a6e3fdca.jpg', NULL, '2026-10-23 20:59:08', '2026-10-23 20:59:08'),
(79, NULL, 'beloved by the male lead\'s nephew', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/9a/9d/c6/9a9dc6af53f35344f0dd7e7c3afbfe47.jpg', NULL, '2026-10-23 20:59:34', '2026-10-24 03:50:33'),
(80, NULL, 'i became the mother of the evil male lead', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/89/40/8f/89408f72720b8159de0e2f930f83f943.jpg', NULL, '2026-10-23 20:59:56', '2026-10-23 20:59:56'),
(81, NULL, 'savor the taste', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/bf/9f/3e/bf9f3e4a35d70e0d22336717315a6662.jpg', NULL, '2026-10-23 21:00:14', '2026-10-24 03:44:19'),
(82, NULL, 'can we become family?', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/7e/3f/bc/7e3fbc15cb00ca77a730fa9c7afb6e91.jpg', NULL, '2026-10-23 21:00:42', '2026-10-24 03:43:05'),
(83, NULL, 'friends don\'t do this!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/fa/7c/f9/fa7cf916170417fd11ef4b721853e5f2.jpg', NULL, '2026-10-23 21:01:12', '2026-10-24 04:04:37'),
(84, NULL, 'the ledy needs a break', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bf/68/99/bf6899a87a7616c3a4067a79fb6c2168.jpg', NULL, '2026-10-23 21:01:28', '2026-10-24 03:37:32'),
(85, NULL, 'Regina Rena: to the Unforgiven', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/45/ff/50/45ff509b21812aad6533beebc5493ed7.jpg', NULL, '2026-10-23 21:01:54', '2026-10-23 21:01:54'),
(86, NULL, 'The Fortune Telling Lady', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/25/f5/c1/25f5c1e23c85ca338c315182fb427458.jpg', NULL, '2026-10-23 21:02:19', '2026-10-23 21:02:19'),
(87, NULL, 'the reason why the twin lady crossdresses', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/6f/5b/ae/6f5bae406986e68dbdded44ca7be551c.jpg', NULL, '2026-10-23 21:02:53', '2026-10-24 04:03:33'),
(88, NULL, 'We Don’t Know Each Other Anymore', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/09/4a/e4/094ae4a9f7c471e3f2e8fa1c12c7b4fd.jpg', NULL, '2026-10-23 21:03:23', '2026-10-23 21:03:23'),
(89, NULL, 'The Eldest Daughter Walks on the Flower Path', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/8c/bd/cd/8cbdcd63d8fbe1e098804b72e3b9eaf6.jpg', NULL, '2026-10-23 21:03:44', '2026-10-23 21:03:51'),
(90, NULL, 'gg', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/4d/cb/45/4dcb4555e719a8e85764fde4d8082cb1.jpg', NULL, '2026-10-23 21:04:14', '2026-10-23 21:04:14'),
(91, NULL, 'Red Hot Revenge', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/cc/8f/67/cc8f67c27fd99ef1ea2e4b35995eea34.jpg', NULL, '2026-10-23 21:04:31', '2026-10-23 21:04:31'),
(92, NULL, 'hh', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/15/0a/6a/150a6a274d51ced760e9d6a4d41a51b6.jpg', NULL, '2026-10-23 21:04:50', '2026-10-23 21:04:50'),
(93, NULL, 'The Father and the Daughter', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/8b/fc/11/8bfc11f3b445ccd8ccf39c5093434c16.jpg', NULL, '2026-10-23 21:05:46', '2026-10-23 21:05:46'),
(94, NULL, 'I Became a Leader in a Wretched Prison slider', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/54/a5/90/54a5901fb734ce88fbd455249deb9b97.jpg', NULL, '2026-10-23 21:06:22', '2026-10-23 21:06:22'),
(95, NULL, '𝐵𝑒𝑤𝑎𝑟𝑒 𝑡𝘩𝑒 𝑉𝑖𝑙𝑙𝑎𝑖𝑛𝑒𝑠𝑠!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bb/db/1c/bbdb1caa1cb55b719fae9ee1b4d46ad6.jpg', NULL, '2026-10-23 21:06:53', '2026-10-23 21:07:02'),
(96, NULL, 'time is running out on the status window', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/23/b0/9d/23b09d3674d5a3b1ec7f90ec53b7125d.jpg', NULL, '2026-10-23 21:07:32', '2026-10-24 03:52:55'),
(97, NULL, 'jj', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/65/41/1f/65411f32d94935a05ca9a899c0abe325.jpg', NULL, '2026-10-23 21:07:46', '2026-10-23 21:07:46'),
(98, NULL, 'I Bought the Villains With Money', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a3/2b/0b/a32b0bd4d8a24e0cec399eeed35252fd.jpg', NULL, '2026-10-23 21:08:14', '2026-10-23 21:08:14'),
(99, NULL, 'once an assassin, now a royal nanny', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bb/71/d8/bb71d8daed79fd9b51719aea4ede5117.jpg', NULL, '2026-10-23 21:08:32', '2026-10-24 03:36:53'),
(100, NULL, 'the count\'s secret maid', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/236x/04/cc/b0/04ccb017047ec45c8cd564858d6ef5a9.jpg', NULL, '2026-10-23 21:08:51', '2026-10-24 04:05:47'),
(101, NULL, 'The Age of Arrogance', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/2c/3c/57/2c3c571b353880a71ca82f35a57d8cf3.jpg', NULL, '2026-10-23 21:09:23', '2026-10-23 21:09:23'),
(102, NULL, 'Obsidian Bride', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/f2/7e/46/f27e46bf1a398b18c2b64a9587129a19.jpg', NULL, '2026-10-23 21:10:24', '2026-10-23 21:10:24'),
(103, NULL, 'Post-Possession Damage Control', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/8d/76/14/8d7614cf9e5dd8fec6b2111d426e25c1.jpg', NULL, '2026-10-23 21:10:51', '2026-10-23 21:10:51'),
(104, NULL, 'The Baddest Villainess Is Back', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/32/68/e8/3268e8fb98009969d1e07220d993cf8c.jpg', NULL, '2026-10-23 21:11:15', '2026-10-23 21:11:15'),
(105, NULL, 'The Villainess Hides Her Wealth', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/9b/d8/1a/9bd81ab6f3302f2e31d61f4ff3cd285b.jpg', NULL, '2026-10-23 21:11:40', '2026-10-23 21:11:40'),
(106, NULL, 'how to survive as a villain on the verge of death', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/35/7e/0e/357e0e04a5e8c5ce995ccfd461c25e88.jpg', NULL, '2026-10-23 21:12:02', '2026-10-24 03:49:31'),
(107, NULL, '1', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/48/1b/6f/481b6f7573191c168155c870cff8597e.jpg', NULL, '2026-10-23 21:12:19', '2026-10-23 21:12:19'),
(108, NULL, 'https://i.pinimg.com/736x/48/1b/6f/481b6f7573191c168155c870cff8597e.jpg', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/b4/ea/a1/b4eaa147ca681060957938eb74155680.jpg', NULL, '2026-10-23 21:12:41', '2026-10-23 21:12:41'),
(109, NULL, '2', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ea/f5/4f/eaf54f13072e51a605970055b71d5b8f.jpg', NULL, '2026-10-23 21:13:05', '2026-10-23 21:13:05'),
(110, NULL, 'The Baby Fairy is a Villain', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/39/6a/43/396a4329b451485752c104fd111700f2.jpg', NULL, '2026-10-23 21:13:35', '2026-10-23 21:13:35'),
(111, NULL, 'my daddy hide his power', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/1f/1f/a0/1f1fa034fa33ea5b1708b8eec921eaa2.jpg', NULL, '2026-10-23 21:13:49', '2026-10-24 03:36:19'),
(112, NULL, 'Bad Killer Whale Baby', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/7d/db/b4/7ddbb48b13c3cb88c2bf6c893db4b206.jpg', NULL, '2026-10-23 21:14:33', '2026-10-23 21:14:33'),
(113, NULL, 'I Became the Mother of the Sub-Male Lead’s Son', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/ff/b2/b5/ffb2b5c14dd2a5ab92965e2b970e5a79.jpg', NULL, '2026-10-23 21:14:57', '2026-10-23 21:14:57'),
(114, NULL, 'How To Hide The Emperor\'s Child', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/31/2f/d4/312fd4e7cda53be2943cb617452f3340.jpg', NULL, '2026-10-23 21:15:30', '2026-10-23 21:15:30'),
(115, NULL, 'i was picked as the tyrant\'s daughter in law', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/60/2f/7f/602f7f245f93c09e87c3209cfe0634b4.jpg', NULL, '2026-10-23 21:16:02', '2026-10-24 03:59:46'),
(116, NULL, 'this emperor commits marriage fraud', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a3/df/46/a3df46ec97591ca3007246cf835c82d6.jpg', NULL, '2026-10-23 21:16:18', '2026-10-24 03:35:21'),
(117, NULL, '6', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/b7/b4/4a/b7b44a8d4278cad71c5e7a1139bd611d.jpg', NULL, '2026-10-23 21:16:44', '2026-10-23 21:16:44'),
(118, NULL, 'undecover bulter to the grand duke', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c4/d4/ee/c4d4ee1d0b9532ac1c1f9d53cf4d0747.jpg', NULL, '2026-10-23 21:17:05', '2026-10-24 03:35:50'),
(119, NULL, 'Lips on the Tip of a Knife', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bc/ab/d7/bcabd7fc4290e137ba2173e010065a6a.jpg', NULL, '2026-10-23 21:17:42', '2026-10-23 21:17:42'),
(120, NULL, 'i hold the tyrant\'s heart', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/c5/56/1d/c5561d13cb016b0ff6f27f1046ae6714.jpg', NULL, '2026-10-23 21:18:08', '2026-10-24 03:45:43'),
(121, 5, 'i will live the life of a villaines', NULL, NULL, NULL, NULL, 'Plan to Read', 32, 90, 9.5, 'https://i.pinimg.com/736x/b4/0c/ce/b40cceb41b9f4242b5962afe22938b8c.jpg', NULL, '2026-10-23 21:18:26', '2026-10-24 03:40:05'),
(122, NULL, 'a savage proposal', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/e4/47/1f/e4471f1b40c9b0d688ba6a3ebed38115.jpg', NULL, '2026-10-23 21:18:54', '2026-10-24 03:34:17'),
(123, 1, 'High Society', NULL, NULL, NULL, NULL, 'Reading', 0, NULL, NULL, 'https://i.pinimg.com/736x/3a/b1/a0/3ab1a03b8f14463aa140a8202e6b4a7d.jpg', NULL, '2026-10-23 21:19:19', '2026-10-23 21:30:55'),
(124, NULL, '11', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/09/5d/43/095d4322aeedfb7f2b48e3a68ae6a170.jpg', NULL, '2026-10-23 21:19:44', '2026-10-23 21:19:44'),
(125, NULL, 'my childhood friends are trying to kill me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/be/1c/32/be1c327c9fddbb181790ce3df810c8a0.jpg', NULL, '2026-10-23 21:20:00', '2026-10-24 03:51:43'),
(126, NULL, 'the ugly lady\'s secret pouch', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/d5/8f/d5/d58fd5848487b280daf2c294093a3dc8.jpg', NULL, '2026-10-23 21:20:16', '2026-10-24 03:39:02'),
(127, 7, 'the mafia nanny', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/84/33/8a/84338a83509722e81e4d93d2004dc9df.jpg', NULL, '2026-10-24 04:09:16', '2026-10-24 04:09:16'),
(128, 7, 'my frist love confession', NULL, NULL, NULL, NULL, 'Reading', 0, NULL, NULL, 'https://i.pinimg.com/736x/38/63/29/386329f3057a9cb2e6df8bfe77bdcc75.jpg', NULL, '2026-10-24 04:10:54', '2026-10-24 04:10:54'),
(129, NULL, 'youth of revelation', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/20/8f/15/208f157f83e39d0f215248fb18a227dc.jpg', NULL, '2026-10-24 04:11:32', '2026-10-24 04:11:32'),
(130, NULL, 'meet me in the middle', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ad/4d/64/ad4d64197a023fea7ddb1431e23af32d.jpg', NULL, '2026-10-24 04:12:28', '2026-10-24 04:12:28'),
(131, NULL, 'the villain\'s pure love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/9e/df/58/9edf581bbfa4159798224cf94a161f04.jpg', NULL, '2026-10-24 04:14:11', '2026-10-24 04:14:11'),
(132, NULL, 'my meddler in love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/4c/d2/2b/4cd22b3c88bb7ad5ed0e778975181402.jpg', NULL, '2026-10-24 04:14:50', '2026-10-24 04:14:50'),
(133, NULL, 'spring fever', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ae/3a/5e/ae3a5eb4ba4dcdd8fde88907e333ff98.jpg', NULL, '2026-10-24 04:15:55', '2026-10-24 04:15:55'),
(134, NULL, 'summer, my love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:16:44', '2026-10-24 04:16:44'),
(135, NULL, 'marriage defense scandal', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/be/93/bb/be93bbc6a1c6e6e474252e974f7f6b9c.jpg', NULL, '2026-10-24 04:17:19', '2026-10-24 04:17:19'),
(136, NULL, 'the hashtag is first love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bc/0a/4c/bc0a4ca397d0f66192bf863dcd817e06.jpg', NULL, '2026-10-24 04:18:00', '2026-10-24 04:18:00'),
(137, NULL, 'we\'re not a couple', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:18:58', '2026-10-24 04:18:58'),
(138, NULL, 'the delinquent first love', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/7d/13/75/7d1375e6723034deb9e2889363de541d.jpg', NULL, '2026-10-24 04:19:47', '2026-10-24 04:19:47'),
(139, NULL, 'the male lead\'s boyfriend is obsessed with me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c6/dd/a7/c6dda7d19042b3097614db7c0eac3c30.jpg', NULL, '2026-10-24 04:21:01', '2026-10-24 04:21:01'),
(140, NULL, 'flowers are bite', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c0/7d/86/c07d8610fda3bd298c753f21c20615fb.jpg', NULL, '2026-10-24 04:22:16', '2026-10-24 04:22:16'),
(141, NULL, 'mia has returned', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/84/b4/3b/84b43b81f523b78a234d1d69bee3101b.jpg', NULL, '2026-10-24 04:22:46', '2026-10-24 04:22:46'),
(142, NULL, 'for your perfect ending', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c7/c5/60/c7c560f83a95c5d5085a0f16586ff11d.jpg', NULL, '2026-10-24 04:24:02', '2026-10-24 04:24:02'),
(143, NULL, 'the time of mr.and mrs', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/64/d2/09/64d2098e250024d6b5a34b904779a340.jpg', NULL, '2026-10-24 04:24:52', '2026-10-24 04:24:52'),
(144, NULL, 'affordable romance', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:26:23', '2026-10-24 04:26:23'),
(145, NULL, 'office romance contract', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/28/ff/3b/28ff3b23f9af47657a148ce94257f837.jpg', NULL, '2026-10-24 04:26:55', '2026-10-24 04:26:55'),
(146, NULL, 'i will change the ending', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/8a/a3/d0/8aa3d044be66a2667cdfc368a1d5db05.jpg', NULL, '2026-10-24 04:27:41', '2026-10-24 04:27:41'),
(147, NULL, 'aiming for the alimony', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/45/61/1c/45611cedf510c8fa42d58fda285b7836.jpg', NULL, '2026-10-24 04:28:16', '2026-10-24 04:28:16'),
(148, NULL, 'big spender in a busted game', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:28:47', '2026-10-24 04:28:47'),
(149, NULL, 'the tiger next door', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/cd/a2/7e/cda27e3ba31602ebcda8fc0653c718e4.jpg', NULL, '2026-10-24 04:29:15', '2026-10-24 04:29:15'),
(150, NULL, 'absolute threshold', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/62/0c/84/620c84d58cf4f4e4cd9aa0c69f141fcb.jpg', NULL, '2026-10-24 04:29:53', '2026-10-24 04:29:53'),
(151, NULL, 'crowning a spoiled prince', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/bf/1f/9b/bf1f9bcfc6be94c261849c3ce2be9dd5.jpg', NULL, '2026-10-24 04:30:46', '2026-10-24 04:30:46'),
(152, NULL, 'rules for dating a trash', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/08/bc/98/08bc987c877b756990ecec1f8106ac14.jpg', NULL, '2026-10-24 04:31:25', '2026-10-24 04:31:25'),
(153, NULL, 'what i decided to die for', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:32:07', '2026-10-24 04:32:07'),
(154, NULL, 'my desire is not a sin', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/24/65/9c/24659c906f61adcce4338a33966ab6e6.jpg', NULL, '2026-10-24 04:32:43', '2026-10-24 04:32:43'),
(155, NULL, 'my clueless love diary', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/02/35/2c/02352c4f676b2ab6b3add84e0beb3ebd.jpg', NULL, '2026-10-24 04:34:25', '2026-10-24 04:34:25'),
(156, NULL, 'locked onto you', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/cb/80/1e/cb801eb299bc13d31c46425e7f75b2bf.jpg', NULL, '2026-10-24 04:35:01', '2026-10-24 04:35:01'),
(157, NULL, 'causality', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/3a/32/81/3a32817124ea7120fee33b74cdb83e30.jpg', NULL, '2026-10-24 04:35:41', '2026-10-24 04:35:41'),
(158, NULL, 'secret temptation', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:36:33', '2026-10-24 04:36:33'),
(159, NULL, 'the young emperor is obsessed with mw', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/68/9e/ef/689eef0f74b8375ef281f64b6735a855.jpg', NULL, '2026-10-24 04:37:33', '2026-10-24 04:37:33'),
(160, NULL, 'violets blooming in the back garden', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/1b/1a/0b/1b1a0b8ee69dc0831106d15b09bb24fa.jpg', NULL, '2026-10-24 04:38:41', '2026-10-24 04:38:41'),
(161, NULL, 'bj villainess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/42/d8/76/42d87616b8ff3c3853ea6688b5d339d5.jpg', NULL, '2026-10-24 04:39:07', '2026-10-24 04:39:07'),
(162, NULL, 'please save me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/31/7a/1f/317a1f3bb054f38a352c50f8b8451ebe.jpg', NULL, '2026-10-24 04:39:30', '2026-10-24 04:39:30'),
(163, NULL, 'what the duke found in the forest', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/dd/14/5f/dd145fb3c139895e117400e7d7e8967a.jpg', NULL, '2026-10-24 04:40:14', '2026-10-24 04:40:14'),
(164, NULL, 'miyeon', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/be/0a/20/be0a20c45368218ae2de3658d60c1172.jpg', NULL, '2026-10-24 04:40:39', '2026-10-24 04:40:39'),
(165, NULL, 'i grabbed the leash of the blind beast', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:42:04', '2026-10-24 04:42:04'),
(166, NULL, 'my sweet enemy thy name is husband', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c1/f0/b6/c1f0b6f163c60c7d65a3acebeabc8267.jpg', NULL, '2026-10-24 04:42:47', '2026-10-24 04:42:47'),
(167, NULL, 'how to turn a kind savior into an emperor', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/f0/dc/ec/f0dcec1512f3458a54258d0e47bcbb4a.jpg', NULL, '2026-10-24 04:43:42', '2026-10-24 04:43:42'),
(168, NULL, 'the dilettante', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ec/dc/a3/ecdca32766e1c78f93d66944a098de79.jpg', NULL, '2026-10-24 04:44:13', '2026-10-24 04:44:13'),
(169, NULL, 'the empress who returned in time: kidnapping and marriage', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/7c/11/2e/7c112eaccb96963ce147e8ea5d5cd146.jpg', NULL, '2026-10-24 04:45:25', '2026-10-24 04:45:25'),
(170, NULL, 'after breaking up, he with my ex\'s uncle', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/2f/53/7a/2f537a9840702135a6d8f0e974ce6167.jpg', NULL, '2026-10-24 04:46:09', '2026-10-24 04:46:09'),
(171, NULL, 'teach me desire', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ca/66/0f/ca660f5e4578c938763287a06b75ec36.jpg', NULL, '2026-10-24 04:46:50', '2026-10-24 04:46:50'),
(172, NULL, 'marriage and swords', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/83/42/e8/8342e8b758baecc054ca7455669d9323.jpg', NULL, '2026-10-24 04:47:32', '2026-10-24 04:47:32'),
(173, NULL, 'i tamed the crazy marquis', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a3/00/95/a300950b5d71d79f206a74ffc8f42f7e.jpg', NULL, '2026-10-24 04:48:05', '2026-10-24 04:48:05'),
(174, NULL, 'i decided my fate your highness', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:49:04', '2026-10-24 04:49:04'),
(175, NULL, 'This is the wrong house, Mr. Villain', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/02/a8/98/02a898cf3e10dc5da8c38a0820e93cc7.jpg', NULL, '2026-10-24 04:51:09', '2026-10-24 04:51:09'),
(176, NULL, 'you mustn\'t your majesty', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/49/b3/4b/49b34bc0a2cb17bfd0f79418a83fd742.jpg', NULL, '2026-10-24 04:52:20', '2026-10-24 04:52:20'),
(177, NULL, 'reporting for duty duchess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/44/0f/9a/440f9aec99becc2098c607e9855cffba.jpg', NULL, '2026-10-24 04:52:46', '2026-10-24 04:52:46'),
(178, NULL, 'the substitue bride', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:53:31', '2026-10-24 04:53:31'),
(179, NULL, 'i was told to die', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:54:28', '2026-10-24 04:54:28'),
(180, NULL, 'lips upon answord\'s edge', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/bc/ab/d7/bcabd7fc4290e137ba2173e010065a6a.jpg', NULL, '2026-10-24 04:55:02', '2026-10-24 04:55:02'),
(181, NULL, 'torn between two', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/43/77/13/4377130e8a8fcf8b2d56e692f94b534b.jpg', NULL, '2026-10-24 04:56:14', '2026-10-24 04:56:14'),
(182, NULL, 'the sister who was my enemy now loves me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/cb/07/32/cb0732dcebdeb29cebfb08a0d4b23f9f.jpg', NULL, '2026-10-24 04:58:50', '2026-10-24 04:58:50'),
(183, NULL, 'i\'m being obsessed over by 5 men to the point of being killed', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 04:59:48', '2026-10-24 04:59:48'),
(184, NULL, '3-year contract with the grim reaper', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/68/59/14/6859145ab1df5c41d6b655c156e1b5e5.jpg', NULL, '2026-10-24 05:00:26', '2026-10-24 05:00:26'),
(185, NULL, 'i\'m a villain but i\'m favored', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/07/c0/38/07c03819cdc804c1f94c9ba7d193fe42.jpg', NULL, '2026-10-24 05:01:04', '2026-10-24 05:01:04'),
(186, NULL, 'post possession damage control', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/54/f9/c6/54f9c6f8d143e4142da7c247db8a37b1.jpg', NULL, '2026-10-24 05:01:40', '2026-10-24 05:01:40'),
(187, NULL, 'to my beloved foe', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/a5/05/72/a50572e8a86362172d1f96a9193b112a.jpg', NULL, '2026-10-24 05:03:27', '2026-10-24 05:03:27'),
(188, NULL, 'the boss wants to die', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 05:04:03', '2026-10-24 05:04:03');
INSERT INTO `manhwa` (`id`, `folder_id`, `title`, `alternative_title`, `synopsis`, `genre`, `author`, `status`, `current_chapter`, `total_chapters`, `rating`, `cover_url`, `personal_notes`, `created_at`, `updated_at`) VALUES
(189, NULL, 'what death tauhgt me', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/236x/f0/86/21/f0862156458a9846ff66664b2757abc2.jpg', NULL, '2026-10-24 05:04:54', '2026-10-24 05:04:54'),
(190, NULL, 'the grand duke has awakened in a strange place', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/12/f8/81/12f8811eda1f3d768910c14bc8c9e0d0.jpg', NULL, '2026-10-24 05:05:35', '2026-10-24 05:05:35'),
(191, NULL, 'maid to love or die', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/85/e6/65/85e665302cdf8449f04b979e761a90f7.jpg', NULL, '2026-10-24 05:06:05', '2026-10-24 05:06:05'),
(192, NULL, 'may sleep befall death', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/28/e7/7c/28e77cadf266a49e1a18b2db038303b3.jpg', NULL, '2026-10-24 05:06:43', '2026-10-24 05:06:43'),
(193, NULL, 'vote for your knight!', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/57/e5/44/57e544f4d3dc9d57f6d421d959f789e1.jpg', NULL, '2026-10-24 05:07:18', '2026-10-24 05:07:18'),
(194, NULL, 'the nerd next door turned out to be the magic tower master', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/11/c4/4b/11c44b1e38529807d7970048dce26ae6.jpg', NULL, '2026-10-24 05:08:39', '2026-10-24 05:08:39'),
(195, NULL, 'marrying the illegitimate child of the enemy family', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/d2/57/88/d25788d240434be2bfc04411859026af.jpg', NULL, '2026-10-24 05:09:28', '2026-10-24 05:09:28'),
(196, NULL, 'i\'m the only granddaughter of the strongest duke', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/10/fd/e9/10fde95e5e12dd75b9b711196720574f.jpg', NULL, '2026-10-24 05:10:07', '2026-10-24 05:10:07'),
(197, NULL, 'i became the secretary of the terminally ill child', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/af/f1/3c/aff13cbc62dcafeec73f8316d784e40c.jpg', NULL, '2026-10-24 05:11:35', '2026-10-24 05:11:35'),
(198, NULL, 'asha of the borderlands', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/31/c4/7b/31c47b8c42dd36d5ad09f2f42631b782.jpg', NULL, '2026-10-24 05:12:01', '2026-10-24 05:12:01'),
(199, NULL, 'the acting empress still spends', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/0a/f4/7b/0af47babf831aa0b6d5141c6a1770594.jpg', NULL, '2026-10-24 05:13:17', '2026-10-24 05:13:17'),
(200, NULL, 'this wasn\'t in my adoption plan', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/75/c1/56/75c156d41019ac59966c67f4c2e256af.jpg', NULL, '2026-10-24 05:14:00', '2026-10-24 05:14:00'),
(201, NULL, 'i played the role of the adopted', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/1200x/4f/cb/04/4fcb04e96c16a57547b021b4ee664936.jpg', NULL, '2026-10-24 05:14:32', '2026-10-24 05:14:32'),
(202, NULL, 'she was supposed to be a temporary princess', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/f7/a9/78/f7a978220cbf02efb53f1f63d490fd4d.jpg', NULL, '2026-10-24 05:15:08', '2026-10-24 05:15:08'),
(203, NULL, 'hiding my identity from my husband', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/c3/9c/5d/c39c5db61b6c0398e0d571793e498341.jpg', NULL, '2026-10-24 05:15:36', '2026-10-24 05:15:36'),
(204, NULL, 'When Pride Fell at My Toes', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/ca/6a/4e/ca6a4eab0255d07c7d3edd5c401020bf.jpg', NULL, '2026-10-24 05:16:16', '2026-10-24 05:16:16'),
(205, NULL, 'Time Healer Ceres', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/2f/ca/2f/2fca2ff4811ac21227fd0b1a756fbf49.jpg', NULL, '2026-10-24 05:16:56', '2026-10-24 05:16:56'),
(206, NULL, 'the terminally ill lady fakes a job with the villain family', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, NULL, NULL, '2026-10-24 05:17:54', '2026-10-24 05:17:54'),
(207, NULL, 'marriage with a suspiciously demure husband', NULL, NULL, NULL, NULL, 'Plan to Read', 0, NULL, NULL, 'https://i.pinimg.com/736x/92/fe/75/92fe75cd819e95127e1999d27ff6e4d3.jpg', NULL, '2026-10-24 05:18:40', '2026-10-24 05:18:40');

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
