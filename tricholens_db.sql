-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2026 at 09:45 AM
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
-- Database: `tricholens_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `diagnosis_result` varchar(255) DEFAULT NULL,
  `diagnosis_date` timestamp NULL DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `user_id`, `diagnosis_result`, `diagnosis_date`, `image_path`) VALUES
(1, 11, 'Main Result : AGA Scalp\nDensity : Low\nScalp Condition : Dry\nMiniaturized Hair Ratio : 38%\nObservation:\nAnalysis indicates patterns associated with early Androgenetic Alopecia.\n\nThis is a non-diagnostic observation for demonstration purposes only.', '2026-03-18 07:38:40', NULL),
(2, 11, 'Main Result : Normal Scalp\nDensity : High\nScalp Condition : Oily\nMiniaturized Hair Ratio : 17%\nObservation:\nAnalysis indicates a hair growth pattern consistent with a normal scalp profile.\n\nThis is a non-diagnostic observation for demonstration purposes o', '2026-03-18 07:43:31', NULL),
(3, 11, 'Main Result : AGA Scalp\nDensity : Medium\nScalp Condition : Normal\nMiniaturized Hair Ratio : 28%\nObservation:\nAnalysis indicates a hair growth pattern consistent with a normal scalp profile.\n\nThis is a non-diagnostic observation for demonstration purposes ', '2026-03-18 07:48:56', NULL),
(4, 11, 'Main Result : AGA Scalp\nDensity : Low\nScalp Condition : Dry\nMiniaturized Hair Ratio : 28%\nObservation:\nAnalysis indicates patterns associated with early Androgenetic Alopecia.\n\nThis is a non-diagnostic observation for demonstration purposes only.', '2026-03-18 08:25:02', 'content://media/external_primary/images/media/1000103526'),
(5, 11, 'Main Result : Normal Scalp\nDensity : High\nScalp Condition : Oily\nMiniaturized Hair Ratio : 20%\nObservation:\nAnalysis indicates a hair growth pattern consistent with a normal scalp profile.\n\nThis is a non-diagnostic observation for demonstration purposes o', '2026-03-18 08:44:49', 'content://media/external_primary/images/media/1000103525'),
(6, 11, 'SYSTEM ERROR:\n\'charmap\' codec can\'t encode character \'\\u2192\' in position 57: character maps to <undefined>', '2026-03-18 08:55:06', 'content://media/external_primary/images/media/1000103528'),
(7, 11, 'SYSTEM ERROR:\n\'charmap\' codec can\'t encode character \'\\u2192\' in position 53: character maps to <undefined>', '2026-03-18 08:55:19', 'content://media/external_primary/images/media/1000103526'),
(8, 11, 'Main Result : Normal Scalp\nDensity : Low\nScalp Condition : Dry\nMiniaturized Hair Ratio : 3%\nObservation:\nAnalysis detects mild hair thinning patterns. Monitoring is suggested. Consult a dermatologist for professional assessment.\n\nThis is a non-diagnostic ', '2026-03-18 09:01:08', 'content://media/external_primary/images/media/1000103526'),
(9, 11, 'Main Result : Normal Scalp\nDensity : High\nScalp Condition : Normal\nMiniaturized Hair Ratio : 3%\nObservation:\nAnalysis indicates a hair growth pattern consistent with a healthy, normal scalp profile.\n\nThis is a non-diagnostic observation. Please consult a ', '2026-03-18 09:01:26', 'content://media/external_primary/images/media/1000103529'),
(10, 11, 'Main Result : Normal Scalp\nDensity : High\nScalp Condition : Normal\nMiniaturized Hair Ratio : 3%\nObservation:\nAnalysis indicates a hair growth pattern consistent with a healthy, normal scalp profile.\n\nThis is a non-diagnostic observation. Please consult a ', '2026-03-18 09:01:37', 'content://media/external_primary/images/media/1000103528'),
(11, 11, 'Main Result : Normal Scalp\nDensity : Low\nScalp Condition : Dry\nMiniaturized Hair Ratio : 5%\nObservation:\nAnalysis detects mild hair thinning patterns. Monitoring is suggested. Consult a dermatologist for professional assessment.\n\nThis is a non-diagnostic ', '2026-03-18 09:01:52', 'content://media/external_primary/images/media/1000103527'),
(12, 11, 'Invalid image. Please upload a clear scalp image.', '2026-03-18 09:02:40', 'content://media/external_primary/images/media/1000103569'),
(13, 11, 'Main Result : AGA Scalp\nDensity : Medium\nScalp Condition : Dry\nMiniaturized Hair Ratio : 40%\nObservation:\nAnalysis indicates significant patterns associated with Androgenetic Alopecia (AGA). Noticeable hair thinning and miniaturisation are evident.\n\nThis ', '2026-03-18 09:08:43', 'content://media/external_primary/images/media/1000103526'),
(14, 11, 'Main Result : Normal Scalp\nDensity : Medium\nScalp Condition : Normal\nMiniaturized Hair Ratio : 40%\nObservation:\nAnalysis detects mild hair thinning patterns. Monitoring is suggested. Consult a dermatologist for professional assessment.\n\nThis is a non-diag', '2026-03-18 09:08:54', 'content://media/external_primary/images/media/1000103528'),
(15, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:03:53', 'content://media/external_primary/images/media/1000103462'),
(16, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:04:12', 'content://media/external_primary/images/media/1000103435'),
(17, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:04:25', 'content://media/external_primary/images/media/1000103526'),
(18, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:04:39', 'content://media/external_primary/images/media/1000103585'),
(19, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:12:29', 'content://media/external_primary/images/media/1000103525'),
(20, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:12:39', 'content://media/external_primary/images/media/1000103497'),
(21, 11, 'Analysis Error: No module named \'scipy\'', '2026-03-18 15:12:54', 'content://media/external_primary/images/media/1000103601'),
(22, 11, 'Result: Normal Scalp\nDensity: High\nCondition: Healthy\nRatio: 4%\n\nObservation: Observation indicates a healthy terminal hair distribution with no significant signs of miniaturisation.\n\nThis analysis is for educational and demonstration purposes only and sh', '2026-03-18 19:08:27', 'content://media/external_primary/images/media/1000103527'),
(23, 11, 'Result: Normal Scalp\nDensity: High\nCondition: Healthy\nRatio: 4%\n\nObservation: Observation indicates a healthy terminal hair distribution with no significant signs of miniaturisation.\n\nThis analysis is for educational and demonstration purposes only and sh', '2026-03-18 19:08:50', 'content://media/external_primary/images/media/1000103529'),
(24, 11, 'Result: Normal Scalp\nDensity: High\nCondition: Healthy\nRatio: 4%\n\nObservation: Observation indicates a healthy terminal hair distribution with no significant signs of miniaturisation.\n\nThis analysis is for educational and demonstration purposes only and sh', '2026-03-18 19:09:04', 'content://media/external_primary/images/media/1000103528'),
(25, 11, 'Normal Scalp', '2026-03-18 19:26:17', 'content://media/external_primary/images/media/1000103527'),
(26, 11, 'Normal Scalp', '2026-03-18 19:26:30', 'content://media/external_primary/images/media/1000103529'),
(27, 11, 'Normal Scalp', '2026-03-18 19:26:46', 'content://media/external_primary/images/media/1000103528'),
(28, 11, 'Normal Scalp', '2026-03-18 19:28:03', 'content://media/external_primary/images/media/1000103526'),
(29, 11, 'Normal Scalp', '2026-03-18 19:36:30', 'content://media/external_primary/images/media/1000103527'),
(30, 11, 'Normal Scalp', '2026-03-18 19:36:40', 'content://media/external_primary/images/media/1000103529'),
(31, 11, 'Normal Scalp', '2026-03-18 19:58:09', 'content://media/external_primary/images/media/1000103527'),
(32, 11, 'Normal Scalp', '2026-03-18 19:58:18', 'content://media/external_primary/images/media/1000103529'),
(33, 11, 'Normal Scalp', '2026-03-18 20:07:00', 'content://media/external_primary/images/media/1000103526'),
(34, 11, 'Normal Scalp', '2026-03-18 20:07:10', 'content://media/external_primary/images/media/1000103529'),
(35, 11, 'Normal Scalp', '2026-03-18 20:07:24', 'content://media/external_primary/images/media/1000103526'),
(36, 11, 'Normal Scalp', '2026-03-18 20:27:51', 'content://media/external_primary/images/media/1000103527'),
(37, 11, 'Normal Scalp', '2026-03-18 20:28:01', 'content://media/external_primary/images/media/1000103529'),
(38, 11, 'Normal Scalp', '2026-03-18 20:35:15', 'content://media/external_primary/images/media/1000103529'),
(39, 11, 'Normal Scalp', '2026-03-18 20:35:25', 'content://media/external_primary/images/media/1000103526'),
(40, 11, 'Normal Scalp', '2026-03-24 13:50:04', 'content://media/external_primary/images/media/1000103526'),
(41, 11, 'Normal Scalp', '2026-03-24 13:50:17', 'content://media/external_primary/images/media/1000103529'),
(42, 11, 'Normal Scalp', '2026-03-24 13:54:55', 'content://media/external_primary/images/media/1000103526'),
(43, 11, 'Normal Scalp', '2026-03-24 13:55:29', 'content://media/external_primary/images/media/1000103528'),
(44, 11, 'AGA Scalp', '2026-03-24 14:00:14', 'content://media/external_primary/images/media/1000103527'),
(45, 11, 'Normal Scalp', '2026-03-24 14:00:31', 'content://media/external_primary/images/media/1000103528'),
(46, 11, 'Normal Scalp', '2026-03-24 14:00:43', 'content://media/external_primary/images/media/1000103525'),
(47, 11, 'Normal Scalp', '2026-03-24 14:01:07', 'content://media/external_primary/images/media/1000103526'),
(48, 11, 'AGA Scalp', '2026-03-24 14:01:20', 'content://media/external_primary/images/media/1000103527'),
(49, 15, 'AGA Scalp', '2026-03-24 15:22:29', 'content://media/external_primary/images/media/1000103527'),
(50, 15, 'Normal Scalp', '2026-03-24 15:25:31', 'content://media/external_primary/images/media/1000103528'),
(51, 15, 'Normal Scalp', '2026-03-24 15:27:10', 'content://media/external_primary/images/media/1000103529'),
(52, 15, 'Normal Scalp', '2026-03-24 15:27:49', 'content://media/external_primary/images/media/1000104426'),
(53, 15, 'AGA Scalp', '2026-03-24 15:32:02', 'content://media/external_primary/images/media/1000103527'),
(54, 15, 'Normal Scalp', '2026-03-25 04:53:34', 'content://media/external_primary/images/media/1000103529');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `mobile`, `dob`, `password`, `created_at`, `gender`, `age`) VALUES
(1, 'Hema Sundara Rao Ponnada', 'hemasundarponnada69@gmail.com', '9502157550', '2026-1-21', '$pbkdf2-sha256$29000$CqGU8r6XEiJEKEVobU1JqQ$Ok1G2vkamdn.5aFmRNcwI5jmPNrnqPyF.DY.qD0ziLk', '2026-01-20 19:37:33', NULL, NULL),
(3, 'Roy', 'ponnadahemasundararaoponnada585@gnail.com', '7893049596', '2026-1-24', '$5$rounds=535000$ZiWZ6KGW3zIWFRSp$pzOhAWYUgfY70/vHij7fdid59ZSjaDYHjtOoS68a5R3', '2026-01-24 16:09:23', NULL, NULL),
(4, 'Roy', 'roy123@gmail.com', '1234567891', '2026-1-25', '$5$rounds=535000$a.uGfWag33pPSQaa$j///41z8rWhfIEfq0FmXyK2tNf5UsbeoWWbQuR6Su.2', '2026-01-25 14:33:23', 'Male', '23'),
(5, 'Swamy', 'swami@gmail.com', '6304203600', '2026-1-29', '$5$rounds=535000$bYPP.Uy1uE0Xfs3Y$AYjvFJL7BiU6hEHlPqBBJvhw6YyUZyVtC9JmF79uLYA', '2026-01-29 12:22:36', 'Male', '28'),
(6, 'Raju', 'Raju@gmail.com', '7093526709', '2026-1-29', '$5$rounds=535000$NGC9RLgcRY2WGtDW$avgW9PL3SYhwVWQRcNBS6IEMPKUUcuz3GYQuTmYA854', '2026-01-29 12:25:32', 'Male', '31'),
(7, 'Hema Sundara Rao Ponnada', 'hello@gmail.com', '9502157550', '2026-3-17', '$5$rounds=535000$b3faGuzXZsBz1e2g$cxSHgK/1Y4dYr0EZ36KWaEYjZDZQRgWEWHp/IKbpqy1', '2026-03-17 14:35:25', 'Male', '29'),
(8, 'hema Sundara Rao', 'hemasundararao585@gmail.com', '7893049596', '2026-3-17', '$5$rounds=535000$7Saqr3Qzz9fcfETS$Vwhf8eJ1yuzgdzEWU2ejEnLPlrwSn4CCOBx/qkn3wlA', '2026-03-17 15:26:18', 'Male', '31'),
(9, 'Raju', 'hi@gmail.com', '1234567890', '2026-3-17', '$5$rounds=535000$BPAMbHKtZsJ5tnf2$HfTJsUvTDoyWNny73xSgpmy0sNR0kCwmzIOHKZfTg86', '2026-03-17 15:29:38', 'Male', '36'),
(10, 'Test User', 'test@test.com', '0987654321', '2000-01-01', '$5$rounds=535000$dmjIM5Lr1pU67hDb$bEQAaU0qyz4DYSFKGomaMzDxS1FcVdV1xd/OkX9dOY1', '2026-03-17 15:36:00', 'Male', '25'),
(11, 'roy', 'roy@gmail.com', '7995823016', '2003-3-17', '$pbkdf2-sha256$29000$9H5vrXUuhZByDiFEiJGSUg$atsxDPOI79WW5RIqY9uFyiArP.8ZX8fj66uJJpobJaI', '2026-03-17 16:45:23', 'Male', '31'),
(12, '&66575', '1@gmail.c', '0686832580', '2026-3-18', '$pbkdf2-sha256$29000$glBqDYHwXut9z3lvDcHYOw$I9Rp1X8foqeq6Bdne.7hKnNkQUqxs.2gQwVAGpS15HE', '2026-03-18 05:54:31', 'Other', '20'),
(13, 'Hema Sundara Rao', 'a1@gmail.com', '6231547890', '2004-12-31', '$pbkdf2-sha256$29000$SYmRUooRojTmnLMWQigF4A$qIQrVd.tBZA9D1GHLOhS9E3zaIuVtMbRrYi06hqrlcA', '2026-03-18 08:44:05', 'Male', '21'),
(14, 'kumar', 'ak@gmail.com', '9876543210', '2009-12-10', '$pbkdf2-sha256$29000$HCMEwLg3ZixlrPUeY6xV6g$XDY1mA6oFzjMqwnLCG8H7TH7jq0x/Sr6reF7oWqhrGM', '2026-03-24 13:47:00', 'Male', '16'),
(15, 'Hema Sundara Rao', 'uiop25324@gmail.com', '9502157550', '2009-12-31', '$pbkdf2-sha256$29000$i1GKEUJIyZlT6t3bm3OuNQ$QUvBtG2q9fc4aOvC9zdzL90ejlK/n.whEUzZHo9jdkI', '2026-03-24 15:19:41', 'Male', '16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ix_history_id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_users_email` (`email`),
  ADD KEY `ix_users_id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
