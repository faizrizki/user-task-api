-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2025 at 10:21 AM
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
-- Database: `user_task_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `action` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `logged_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_07_02_155902_create_tasks_table', 1),
(6, '2025_07_02_160000_create_activity_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'api_token', '4a0661f230870eaee3aa174f832a671c2aba4c85a21b41b511d612450678ded6', '[\"*\"]', '2025-07-04 00:38:30', NULL, '2025-07-03 21:47:21', '2025-07-04 00:38:30'),
(2, 'App\\Models\\User', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'api_token', 'bb02bf074884333adb038d5b7bcd37d1cc7d20bb2697dfd18026c96d1b23a42e', '[\"*\"]', '2025-07-03 21:49:46', NULL, '2025-07-03 21:48:57', '2025-07-03 21:49:46'),
(3, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'c7dcb181028a95a181b22d14e271f570610985401d098627b6d5fc09bb3e8fc7', '[\"*\"]', '2025-07-03 22:34:08', NULL, '2025-07-03 22:34:07', '2025-07-03 22:34:08'),
(4, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '0e09503ddddc8b737c6ef0e6bc2d8c26926873ad53468411c4822f68139ed931', '[\"*\"]', '2025-07-03 22:34:40', NULL, '2025-07-03 22:34:20', '2025-07-03 22:34:40'),
(5, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '19bbfcd535be5b1e2e92c937ded3406f6fbbfc500ea2febb9cf4eb942df60200', '[\"*\"]', '2025-07-03 22:35:17', NULL, '2025-07-03 22:35:15', '2025-07-03 22:35:17'),
(6, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', 'b5818b099c118af7e46be53acecbd8cc18002e8477892371ce48661428ad956d', '[\"*\"]', '2025-07-03 22:36:02', NULL, '2025-07-03 22:35:41', '2025-07-03 22:36:02'),
(7, 'App\\Models\\User', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'api_token', '79119b3c2b8a9b599db4a9617869f1a7116365a2f490a5818b7cbd3323e8554f', '[\"*\"]', '2025-07-03 22:36:08', NULL, '2025-07-03 22:36:08', '2025-07-03 22:36:08'),
(8, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '4645a53793300b50b71de276d51eb61b9e914908a469c50c76757967301da3e0', '[\"*\"]', '2025-07-03 23:08:32', NULL, '2025-07-03 22:36:17', '2025-07-03 23:08:32'),
(9, 'App\\Models\\User', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'api_token', '5b106baa11a16a47ebfba824c75eac54278498d076b6676860a6f947ba2a4fba', '[\"*\"]', '2025-07-03 22:40:14', NULL, '2025-07-03 22:37:08', '2025-07-03 22:40:14'),
(10, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '497f5ed9684c89189564114b18fe0824cbf30cddd50a84820d2dd76ecdae4526', '[\"*\"]', '2025-07-03 23:10:29', NULL, '2025-07-03 23:10:28', '2025-07-03 23:10:29'),
(11, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '33774695a45de8b0a72c0614fd42cc74292e4c840e6281267890e378dabca33c', '[\"*\"]', '2025-07-03 23:22:32', NULL, '2025-07-03 23:11:36', '2025-07-03 23:22:32'),
(12, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '65e53da64e919297a936e6f6623b7916b8c3b5ad97bc8e2187e9c553be300a93', '[\"*\"]', '2025-07-03 23:22:38', NULL, '2025-07-03 23:22:35', '2025-07-03 23:22:38'),
(13, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '7db658ee24252ffcc04585e2955fe3c3d4929beb2a423253b5ed946be656d50f', '[\"*\"]', '2025-07-03 23:22:52', NULL, '2025-07-03 23:22:51', '2025-07-03 23:22:52'),
(14, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'c73d4e77454414e5fd0a415c91fb472e2e0c6e497f1696d2897ed3dd99b6fa76', '[\"*\"]', '2025-07-03 23:26:47', NULL, '2025-07-03 23:22:58', '2025-07-03 23:26:47'),
(15, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', 'ae1f905c9e500044e3fbab5b01fb5166824581f73c5f06def27799c15c2237cf', '[\"*\"]', '2025-07-03 23:26:51', NULL, '2025-07-03 23:26:50', '2025-07-03 23:26:51'),
(16, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '1fefe5cd4331fe587e2713c8880fbd82ac54a70487286ab7b128f1c101ff2c6e', '[\"*\"]', '2025-07-03 23:27:01', NULL, '2025-07-03 23:27:01', '2025-07-03 23:27:01'),
(17, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'e58a8ed7287bd2f415b0d0b18ad281a3a4381ab344fde74e62e7ca9f2c45078b', '[\"*\"]', '2025-07-03 23:29:49', NULL, '2025-07-03 23:27:24', '2025-07-03 23:29:49'),
(18, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '71223206e063281ee43803a1a51bcc60773adbeee27e02d43163210d936db447', '[\"*\"]', '2025-07-03 23:32:03', NULL, '2025-07-03 23:30:45', '2025-07-03 23:32:03'),
(19, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '3df825464ffde88a931027530df0f8959970cc110233b9e8f3e21798fe9ebc2a', '[\"*\"]', '2025-07-03 23:32:18', NULL, '2025-07-03 23:32:18', '2025-07-03 23:32:18'),
(20, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', 'db8ea2ec72dc8030220a2d0f529d986f8e8d040add7843d9e5a81dd8d462a0e6', '[\"*\"]', '2025-07-03 23:41:42', NULL, '2025-07-03 23:32:32', '2025-07-03 23:41:42'),
(21, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '3cf804046a090e8f2a205b53a649f8dbd696d504c4553d5f5a2905faedae9dfa', '[\"*\"]', '2025-07-03 23:42:22', NULL, '2025-07-03 23:33:02', '2025-07-03 23:42:22'),
(22, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'a879a1a2a3776e2d59ad8757045e8dfc662b9878668da2cddd7f068a760763af', '[\"*\"]', '2025-07-03 23:54:06', NULL, '2025-07-03 23:54:06', '2025-07-03 23:54:06'),
(23, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'ae517735bfd54d19eb06d7d563ecf90420b1fac4e899c1e4ea86579f480550e1', '[\"*\"]', '2025-07-03 23:57:34', NULL, '2025-07-03 23:54:16', '2025-07-03 23:57:34'),
(24, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', 'bb17126ca69c4468eb4421010100cea6e34feb022f948356551928db3354fa6f', '[\"*\"]', '2025-07-03 23:55:08', NULL, '2025-07-03 23:54:57', '2025-07-03 23:55:08'),
(25, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '62d7479e9e21bbcc81f830cb5b64f40b06c56ba0037729c9f64ce7dc3a882237', '[\"*\"]', '2025-07-03 23:55:32', NULL, '2025-07-03 23:55:25', '2025-07-03 23:55:32'),
(26, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '5b7aa226c2b084fb1c5a199b70582d1f7be4e832078266339b15fa2193276710', '[\"*\"]', '2025-07-03 23:56:27', NULL, '2025-07-03 23:56:04', '2025-07-03 23:56:27'),
(27, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '99d88d4273fceaae2e5e64e7c2b48a1eabcda34fe01f3bc107a3a48d1f14903c', '[\"*\"]', '2025-07-03 23:57:51', NULL, '2025-07-03 23:57:47', '2025-07-03 23:57:51'),
(28, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'f023d4e25d6529284c5b3ea8668904edf49f3d85e86226457d55cc0602ca4254', '[\"*\"]', '2025-07-04 00:01:19', NULL, '2025-07-03 23:59:38', '2025-07-04 00:01:19'),
(29, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '984973df4b1e72021b4ebcad5b9b87ccaa5e6fd794a27f969f5d54ccc2ec3594', '[\"*\"]', '2025-07-04 00:02:28', NULL, '2025-07-04 00:02:19', '2025-07-04 00:02:28'),
(30, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '722cc6c9694fdcd287a58b39ab1867c0b2246f5726842ef8d70638c749c3f333', '[\"*\"]', '2025-07-04 00:05:57', NULL, '2025-07-04 00:05:07', '2025-07-04 00:05:57'),
(31, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '9ab86d9ddd717504f3b1069b69f77edc2989ef10055fad03fe2eef6462d9e664', '[\"*\"]', NULL, NULL, '2025-07-04 00:06:26', '2025-07-04 00:06:26'),
(32, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '8d79ab47c16af56e56ca7aba783a84b66c2063a3107dbaa3d4b46d3b2390f55b', '[\"*\"]', '2025-07-04 00:06:54', NULL, '2025-07-04 00:06:32', '2025-07-04 00:06:54'),
(33, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '063b2376eb0d1a5025dabb84d2658bc96f465301568675df4559b417b62481fc', '[\"*\"]', '2025-07-04 00:07:34', NULL, '2025-07-04 00:07:27', '2025-07-04 00:07:34'),
(34, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', 'e1126557010079205b2123a86a137c9279e755840e0818ba2cb188c313d85c9b', '[\"*\"]', '2025-07-04 00:11:18', NULL, '2025-07-04 00:09:27', '2025-07-04 00:11:18'),
(35, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '9f408042ee6a5ffc0402867ef601b11401297bef05c15b5c723ac06c29e2e10b', '[\"*\"]', '2025-07-04 00:14:31', NULL, '2025-07-04 00:13:51', '2025-07-04 00:14:31'),
(36, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '15f6bb978ca86ab12d5269178bec80a693456d944ad920fffb2eb4baefbfeda2', '[\"*\"]', '2025-07-04 00:16:28', NULL, '2025-07-04 00:16:07', '2025-07-04 00:16:28'),
(37, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '02129e2673cab3f02ea169619fd27134cd275230b7ef3f01d83d5fac29394589', '[\"*\"]', '2025-07-04 00:27:43', NULL, '2025-07-04 00:16:48', '2025-07-04 00:27:43'),
(38, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'f2c7970cd55f53569b9b88bd52e1d10e768c879fcd5ce54fb05e9ad2ab323286', '[\"*\"]', '2025-07-04 00:26:53', NULL, '2025-07-04 00:23:04', '2025-07-04 00:26:53'),
(39, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '28fc70e26b7b88108da88e0e7053e831f2eb5df8eea393e033d86d6f6733131a', '[\"*\"]', '2025-07-04 00:32:03', NULL, '2025-07-04 00:26:58', '2025-07-04 00:32:03'),
(40, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', 'd3e3dcf33f462d3d8089bb4729ddfc4943eae4ff32a6f85471c55e4d81bdf5db', '[\"*\"]', '2025-07-04 00:31:24', NULL, '2025-07-04 00:27:54', '2025-07-04 00:31:24'),
(41, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '0e71a8b4cfcbb14bf5e0b9d2deeda202d23bdcf13524c21bbd3d750f5dfacd3d', '[\"*\"]', '2025-07-04 00:34:45', NULL, '2025-07-04 00:34:16', '2025-07-04 00:34:45'),
(42, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', '128c1ca8d3316b60ac8ce7d47f286045c3237a2d3dcc01f220cd3673ff197d50', '[\"*\"]', NULL, NULL, '2025-07-04 00:35:43', '2025-07-04 00:35:43'),
(43, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '0da67db66e475ef980d6c19fa44745c73ffad3872ed84e84f51010eb019e9d57', '[\"*\"]', '2025-07-04 00:39:04', NULL, '2025-07-04 00:36:26', '2025-07-04 00:39:04'),
(44, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', '395e812b333694d04c8452a95e9d570d3db0376acbb8c280b37b22e0e79b748e', '[\"*\"]', '2025-07-04 00:37:55', NULL, '2025-07-04 00:37:36', '2025-07-04 00:37:55'),
(45, 'App\\Models\\User', '615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'api_token', 'b6661393734b73cd903b3674b4cf981f257d8a0796216c4e71b82db85631d86c', '[\"*\"]', NULL, NULL, '2025-07-04 00:38:16', '2025-07-04 00:38:16'),
(46, 'App\\Models\\User', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'api_token', 'f209a41cb72ce6193533c6e9f4b1e1ed270300d4389f6f3e7b586ec6ba39df74', '[\"*\"]', '2025-07-04 00:38:52', NULL, '2025-07-04 00:38:39', '2025-07-04 00:38:52'),
(47, 'App\\Models\\User', '393b4df9-8386-43dc-8051-03e4f4188b12', 'api_token', '904905c55afecbac41e998917f4c61f20a0a0b486ed6aff951b7d80f8728d985', '[\"*\"]', '2025-07-04 00:39:28', NULL, '2025-07-04 00:39:23', '2025-07-04 00:39:28');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `assigned_to` char(36) NOT NULL,
  `status` enum('pending','in_progress','done') NOT NULL DEFAULT 'pending',
  `due_date` date NOT NULL,
  `created_by` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `description`, `assigned_to`, `status`, `due_date`, `created_by`, `created_at`, `updated_at`) VALUES
('1e8316f0-12c2-4ffe-81e2-3e451f5c87ed', 'Test Task', 'Ini task testing', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'pending', '2025-07-07', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-04 00:14:54', '2025-07-04 00:14:54'),
('573478cb-b2a5-4958-a196-918bc62dbb7a', 'Test Task', 'Ini task testing', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'pending', '2025-07-07', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-04 00:15:28', '2025-07-04 00:15:28'),
('5e9fd1c1-c6ad-4e31-bab6-1a6e319021ed', 'Test Task', 'Ini task testing', '393b4df9-8386-43dc-8051-03e4f4188b12', 'pending', '2025-07-07', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-04 00:36:00', '2025-07-04 00:36:00'),
('676baece-c893-4332-a8f0-2080e3c61cc4', 'UI/UX', 'landingPage', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'in_progress', '2025-07-06', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-03 21:52:48', '2025-07-04 00:15:41'),
('792dcc1b-232f-49f9-b2a0-e83f514eead0', 'Test Task 2', 'Ini task testing', '393b4df9-8386-43dc-8051-03e4f4188b12', 'pending', '2025-07-07', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-04 00:37:20', '2025-07-04 00:37:20'),
('d34e0f02-083b-405d-838b-f87bb3786f22', 'Test Task 2', 'Ini task testing', 'd8c860ba-a67c-4902-a56b-2b07677c8573', 'pending', '2025-07-07', 'a6877c38-b3a1-4851-bf77-0d2bcedfb849', '2025-07-04 00:38:30', '2025-07-04 00:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','manager','staff') NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `status`, `created_at`, `updated_at`) VALUES
('393b4df9-8386-43dc-8051-03e4f4188b12', 'faiz', 'faiz@example.com', '$2y$10$iVHmdz04fEjwu0FixjPdBu81zlGELvCNWrIMOcbzLcgrnRgL0gX.e', 'manager', 1, '2025-07-03 21:49:27', '2025-07-03 21:49:27'),
('615546b5-c30e-44c8-8cbd-94023a6fc3e7', 'admin', 'admin@example.com', '$2y$10$gqjBfBLlG.Wjc1VBBaI4o.moU7g24SIp4aScLbWE/G6WkPU4igiD2', 'admin', 1, '2025-07-03 21:49:14', '2025-07-03 21:49:14'),
('6516be2f-4b63-4eea-b928-3555a91f58d7', 'Test User', 'testuser@example.com', '$2y$10$./Ylcbn1wi7hNmURnKldZexzIyJhsO00ZnoLHs0PsahmQzlsf2omS', 'staff', 1, '2025-07-03 21:51:10', '2025-07-03 21:51:10'),
('a6877c38-b3a1-4851-bf77-0d2bcedfb849', 'Test User', 'test@example.com', '$2y$10$SfY2ppI5eXRFHhRVJtcA/OSOKKyx1YvPBAVapbd3f00hkgMsr2UcK', 'admin', 1, '2025-07-03 21:47:02', '2025-07-03 21:47:02'),
('d8c860ba-a67c-4902-a56b-2b07677c8573', 'rizki', 'rizki@example.com', '$2y$10$kf.ajjhxtv0kDGv9frE6pupCKWczNBFY0IPC98hK7HQ..yyIFmf/.', 'staff', 1, '2025-07-03 21:49:45', '2025-07-03 21:49:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
