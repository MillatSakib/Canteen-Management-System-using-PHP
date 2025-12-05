-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 05, 2025 at 04:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
CREATE DATABASE `Canteen_Management_System`;

USE `Canteen_Management_System`;
--

-- --------------------------------------------------------

--
-- Table structure for table `canteen_info`
--

CREATE TABLE `canteen_info` (
  `canteen_info_id` int(11) NOT NULL,
  `canteen_name` varchar(255) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `opening_time` time DEFAULT NULL,
  `closing_time` time DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `canteen_info`
--

INSERT INTO `canteen_info` (`canteen_info_id`, `canteen_name`, `location`, `opening_time`, `closing_time`, `contact_email`) VALUES
(1, 'Main Campus Canteen', 'NX_Bulding', '09:00:00', '21:00:00', 'contact@canteen.com');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Breakfast', 'Morning meal items'),
(2, 'Lunch', 'Main course meals'),
(3, 'Snacks', 'Light meal and fast food'),
(4, 'Beverages', 'Hot and cold drinks'),
(5, 'Desserts', 'Sweet items and puddings'),
(6, 'Fast Food', 'Quick and easy meals like burgers, sandwiches, and fries'),
(7, 'Juices & Drinks', 'Fresh juices, cold drinks, and shakes'),
(8, 'Desserts & Sweets', 'Cakes, muffins, ice cream, and other sweet items'),
(9, 'Main Course', 'Lunch and dinner main course items like rice, curry, pasta, pizza'),
(10, 'Snacks & Starters', 'Light bites and snacks like samosa, nuggets, rolls');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `password`, `role`, `phone_number`, `address`, `created_at`, `deleted`) VALUES
(1, 'Akash Ahmed', 'akash.ahmed@example.com', 'login', 'user', '01711223344', 'Mirpur, Dhaka', '2025-08-18 22:30:51', '1'),
(2, 'Bithi Khan', 'bithi.khan@example.com', 'login', 'admin', '01811223344', 'Gulshan, Dhaka', '2025-08-18 22:30:51', '0'),
(3, 'Tanim Islam', 'tanim.islam@example.com', 'login', 'admin', '01911223344', 'Uttara, Dhaka', '2025-08-18 22:30:51', '0'),
(4, 'Sadia Rahman', 'sadia.rahman@example.com', 'login', 'user', '01611223344', 'Dhanmondi, Dhaka', '2025-08-18 22:30:51', '0'),
(5, 'Rajib Hossain', 'rajib.hossain@example.com', 'login', 'user', '01511223344', 'Banani, Dhaka', '2025-08-18 22:30:51', '0'),
(6, 'Mitu Akhtar', 'mitu.akhtar@example.com', 'login', 'user', '01411223344', 'Motijheel, Dhaka', '2025-08-18 22:30:51', '0'),
(7, 'Nurul Amin', 'nurul.amin@example.com', 'login', 'user', '01311223344', 'Mohammadpur, Dhaka', '2025-08-18 22:30:51', '0'),
(8, 'Rakib Hasan', 'rakib1@gmail.com', 'login', 'user', '01710000001', 'Dhaka', '2025-08-19 11:27:23', '0'),
(9, 'Sabbir Ahmed', 'sabbir2@gmail.com', 'login', 'user', '01710000002', 'Chittagong', '2025-08-19 11:27:23', '0'),
(10, 'Nusrat Jahan', 'nusrat3@gmail.com', 'login', 'user', '01710000003', 'Rajshahi', '2025-08-19 11:27:23', '0'),
(11, 'Mehedi Hasan', 'mehedi4@gmail.com', 'login', 'user', '01710000004', 'Khulna', '2025-08-19 11:27:23', '0'),
(12, 'Tania Akter', 'tania5@gmail.com', 'login', 'user', '01710000005', 'Sylhet', '2025-08-19 11:27:23', '0'),
(13, 'Mahfuz Rahman', 'mahfuz6@gmail.com', 'login', 'user', '01710000006', 'Barisal', '2025-08-19 11:27:23', '0'),
(14, 'Faria Sultana', 'faria7@gmail.com', 'login', 'user', '01710000007', 'Rangpur', '2025-08-19 11:27:23', '0'),
(15, 'Imran Hossain', 'imran8@gmail.com', 'login', 'user', '01710000008', 'Comilla', '2025-08-19 11:27:23', '0'),
(16, 'Shahadat Karim', 'karim9@gmail.com', 'login', 'user', '01710000009', 'Mymensingh', '2025-08-19 11:27:23', '0'),
(17, 'Sadman Sakib', 'sadman10@gmail.com', 'login', 'user', '01710000010', 'Dhaka', '2025-08-19 11:27:23', '0'),
(18, 'Nadia Haque', 'nadia11@gmail.com', 'login', 'user', '01710000011', 'Gazipur', '2025-08-19 11:27:23', '0'),
(19, 'Arif Chowdhury', 'arif12@gmail.com', 'login', 'user', '01710000012', 'Sylhet', '2025-08-19 11:27:23', '0'),
(20, 'Rumi Akter', 'rumi13@gmail.com', 'login', 'user', '01710000013', 'Rajshahi', '2025-08-19 11:27:23', '0'),
(21, 'Tanvir Alam', 'tanvir14@gmail.com', 'login', 'user', '01710000014', 'Khulna', '2025-08-19 11:27:23', '0'),
(22, 'Rashedul Islam', 'rashed15@gmail.com', 'login', 'user', '01710000015', 'Barisal', '2025-08-19 11:27:23', '0'),
(23, 'Farhana Kabir', 'farhana16@gmail.com', 'login', 'user', '01710000016', 'Rangpur', '2025-08-19 11:27:23', '0'),
(24, 'Ashraful Hoque', 'ashraf17@gmail.com', 'login', 'user', '01710000017', 'Bogura', '2025-08-19 11:27:23', '0'),
(25, 'Sumaiya Khatun', 'sumaiya18@gmail.com', 'login', 'user', '01710000018', 'Dhaka', '2025-08-19 11:27:23', '0'),
(26, 'Ahsan Ullah', 'ahsan19@gmail.com', 'login', 'user', '01710000019', 'Sylhet', '2025-08-19 11:27:23', '0'),
(27, 'Rony Sarker', 'rony20@gmail.com', 'login', 'user', '01710000020', 'Mymensingh', '2025-08-19 11:27:23', '0'),
(28, 'Shila Akter', 'shila21@gmail.com', 'login', 'user', '01710000021', 'Rajbari', '2025-08-19 11:27:23', '0'),
(29, 'Samiul Haque', 'samiul22@gmail.com', 'login', 'user', '01710000022', 'Dhaka', '2025-08-19 11:27:23', '0'),
(30, 'Nafisa Jahan', 'nafisa23@gmail.com', 'login', 'user', '01710000023', 'Chittagong', '2025-08-19 11:27:23', '0'),
(31, 'Parvez Hossain', 'parvez24@gmail.com', 'login', 'user', '01710000024', 'Khulna', '2025-08-19 11:27:23', '0'),
(32, 'Shuvo Roy', 'shuvo25@gmail.com', 'login', 'user', '01710000025', 'Sylhet', '2025-08-19 11:27:23', '0'),
(33, 'Raihan Kabir', 'raihan26@gmail.com', 'login', 'user', '01710000026', 'Cumilla', '2025-08-19 11:27:23', '0'),
(34, 'Fahmida Islam', 'fahmida27@gmail.com', 'login', 'user', '01710000027', 'Rajshahi', '2025-08-19 11:27:23', '0'),
(35, 'Iqbal Hossain', 'iqbal28@gmail.com', 'login', 'user', '01710000028', 'Barisal', '2025-08-19 11:27:23', '0'),
(36, 'Sadia Rahman', 'sadia29@gmail.com', 'login', 'user', '01710000029', 'Gazipur', '2025-08-19 11:27:23', '0'),
(37, 'Hasibul Islam', 'hasib30@gmail.com', 'login', 'user', '01710000030', 'Dhaka', '2025-08-19 11:27:23', '0'),
(38, 'Sharmin Akter', 'sharmin31@gmail.com', 'login', 'user', '01710000031', 'Sylhet', '2025-08-19 11:27:23', '0'),
(39, 'Mizanur Rahman', 'mizan32@gmail.com', 'login', 'user', '01710000032', 'Khulna', '2025-08-19 11:27:23', '0'),
(40, 'Lubna Chowdhury', 'lubna33@gmail.com', 'login', 'user', '01710000033', 'Rajshahi', '2025-08-19 11:27:23', '0'),
(41, 'Tareq Aziz', 'tareq34@gmail.com', 'login', 'user', '01710000034', 'Bogura', '2025-08-19 11:27:23', '0'),
(42, 'Anika Haque', 'anika35@gmail.com', 'login', 'user', '01710000035', 'Dhaka', '2025-08-19 11:27:23', '0'),
(43, 'Sajid Rahman', 'sajid36@gmail.com', 'login', 'user', '01710000036', 'Mymensingh', '2025-08-19 11:27:23', '0'),
(44, 'Shanta Akter', 'shanta37@gmail.com', 'login', 'user', '01710000037', 'Rajbari', '2025-08-19 11:27:23', '0'),
(45, 'Jahidul Islam', 'jahid38@gmail.com', 'login', 'user', '01710000038', 'Barisal', '2025-08-19 11:27:23', '0'),
(46, 'Samira Khan', 'samira39@gmail.com', 'login', 'user', '01710000039', 'Sylhet', '2025-08-19 11:27:23', '0'),
(1003, 'Sorojontro', 'sorojontro@gmail.com', 'login', 'user', '01581', 'Chottogram', '2025-11-22 08:35:32', '0'),
(1008, 'saka', 'saka@gmail.com', 'login', 'user', '01581321', 'saka', '2025-11-22 08:38:18', '0'),
(1009, 'neka', 'neka@gmail.com', 'login', 'user', '6546524', 'neka', '2025-11-22 08:42:42', '1'),
(1011, 'sohan', 'gubtopper@gmail.com', '123', 'admin', '014567', 'pabna', '2025-11-22 09:30:10', '0'),
(1015, 'abc@gmail.com', 'abc@gmail.com', 'abc@gmail.com', 'user', '43214', 'abc@gmail.com', '2025-11-22 14:00:42', '0'),
(1016, 'Md Ekra Islam Ohi', 'ekraislamohi@2023.gmail.com', '01581828741', 'user', '01581828741', 'Lama,Bandarban', '2025-11-22 14:32:25', '0');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `log_new_customer` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO customer_audit_log (customer_id, action, log_date)
    VALUES (NEW.customer_id, 'New Customer Added', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_audit_log`
--

CREATE TABLE `customer_audit_log` (
  `log_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `log_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_audit_log`
--

INSERT INTO `customer_audit_log` (`log_id`, `customer_id`, `action`, `log_date`) VALUES
(1, 8, 'New Customer Added', '2025-08-19 17:27:23'),
(2, 9, 'New Customer Added', '2025-08-19 17:27:23'),
(3, 10, 'New Customer Added', '2025-08-19 17:27:23'),
(4, 11, 'New Customer Added', '2025-08-19 17:27:23'),
(5, 12, 'New Customer Added', '2025-08-19 17:27:23'),
(6, 13, 'New Customer Added', '2025-08-19 17:27:23'),
(7, 14, 'New Customer Added', '2025-08-19 17:27:23'),
(8, 15, 'New Customer Added', '2025-08-19 17:27:23'),
(9, 16, 'New Customer Added', '2025-08-19 17:27:23'),
(10, 17, 'New Customer Added', '2025-08-19 17:27:23'),
(11, 18, 'New Customer Added', '2025-08-19 17:27:23'),
(12, 19, 'New Customer Added', '2025-08-19 17:27:23'),
(13, 20, 'New Customer Added', '2025-08-19 17:27:23'),
(14, 21, 'New Customer Added', '2025-08-19 17:27:23'),
(15, 22, 'New Customer Added', '2025-08-19 17:27:23'),
(16, 23, 'New Customer Added', '2025-08-19 17:27:23'),
(17, 24, 'New Customer Added', '2025-08-19 17:27:23'),
(18, 25, 'New Customer Added', '2025-08-19 17:27:23'),
(19, 26, 'New Customer Added', '2025-08-19 17:27:23'),
(20, 27, 'New Customer Added', '2025-08-19 17:27:23'),
(21, 28, 'New Customer Added', '2025-08-19 17:27:23'),
(22, 29, 'New Customer Added', '2025-08-19 17:27:23'),
(23, 30, 'New Customer Added', '2025-08-19 17:27:23'),
(24, 31, 'New Customer Added', '2025-08-19 17:27:23'),
(26, 33, 'New Customer Added', '2025-08-19 17:27:23'),
(27, 34, 'New Customer Added', '2025-08-19 17:27:23'),
(28, 35, 'New Customer Added', '2025-08-19 17:27:23'),
(29, 36, 'New Customer Added', '2025-08-19 17:27:23'),
(30, 37, 'New Customer Added', '2025-08-19 17:27:23'),
(31, 38, 'New Customer Added', '2025-08-19 17:27:23'),
(32, 39, 'New Customer Added', '2025-08-19 17:27:23'),
(33, 40, 'New Customer Added', '2025-08-19 17:27:23'),
(34, 41, 'New Customer Added', '2025-08-19 17:27:23'),
(35, 42, 'New Customer Added', '2025-08-19 17:27:23'),
(36, 43, 'New Customer Added', '2025-08-19 17:27:23'),
(37, 44, 'New Customer Added', '2025-08-19 17:27:23'),
(38, 45, 'New Customer Added', '2025-08-19 17:27:23'),
(39, 46, 'New Customer Added', '2025-08-19 17:27:23'),
(40, 47, 'New Customer Added', '2025-08-19 17:27:23'),
(41, 48, 'New Customer Added', '2025-08-20 02:07:40'),
(42, 1000, 'New Customer Added', '2025-08-20 14:11:08'),
(43, 1001, 'New Customer Added', '2025-11-22 14:25:28'),
(44, 1002, 'New Customer Added', '2025-11-22 14:26:22'),
(45, 1003, 'New Customer Added', '2025-11-22 14:35:32'),
(46, 1008, 'New Customer Added', '2025-11-22 14:38:18'),
(47, 1009, 'New Customer Added', '2025-11-22 14:42:42'),
(48, 1010, 'New Customer Added', '2025-11-22 14:54:11'),
(49, 1011, 'New Customer Added', '2025-11-22 15:30:10'),
(50, 1015, 'New Customer Added', '2025-11-22 20:00:42'),
(51, 1016, 'New Customer Added', '2025-11-22 20:32:25');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `employee_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `employee_name`, `email`, `phone_number`, `position`, `salary`, `hire_date`, `created_at`) VALUES
(1, 'Fahim Hossain', 'fahim.hossain@canteen.com', '01512345678', 'Manager', 35000.00, '2023-01-15', '2025-08-18 22:30:51'),
(2, 'Jannat Sultana', 'jannat.sultana@canteen.com', '01612345678', 'Cashier', 18000.00, '2023-03-20', '2025-08-18 22:30:51'),
(3, 'Kamal Mia', 'kamal.mia@canteen.com', '01712345678', 'Cook', 22000.00, '2022-05-10', '2025-08-18 22:30:51'),
(4, 'Shabana Begum', 'shabana.b@canteen.com', '01812345678', 'Assistant Cook', 20000.00, '2023-08-01', '2025-08-18 22:30:51'),
(5, 'Rifat Ahmed', 'rifat.ahmed@canteen.com', '01912345678', 'Waiter', 15000.00, '2024-02-10', '2025-08-18 22:30:51'),
(6, 'Abdul Karim', 'abdul1@gmail.com', '01810000001', 'Manager', 40000.00, NULL, '2025-08-19 11:28:25'),
(7, 'Mokbul Hossain', 'mokbul2@gmail.com', '01810000002', 'Chef', 30000.00, NULL, '2025-08-19 11:28:25'),
(8, 'Jannatul Ferdous', 'jannat3@gmail.com', '01810000003', 'Waiter', 15000.00, NULL, '2025-08-19 11:28:25'),
(9, 'Sohag Mia', 'sohag4@gmail.com', '01810000004', 'Waiter', 16000.00, NULL, '2025-08-19 11:28:25'),
(10, 'Rubel Khan', 'rubel5@gmail.com', '01810000005', 'Cashier', 18000.00, NULL, '2025-08-19 11:28:25'),
(11, 'Rumana Akter', 'rumana6@gmail.com', '01810000006', 'Cleaner', 12000.00, NULL, '2025-08-19 11:28:25'),
(12, 'Imtiaz Rahman', 'imtiaz7@gmail.com', '01810000007', 'Chef', 32000.00, NULL, '2025-08-19 11:28:25');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `expense_date` date NOT NULL,
  `category` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expense_id`, `description`, `amount`, `expense_date`, `category`) VALUES
(1, 'Rent for May 2024', 15000.00, '2024-05-01', 'Rent'),
(2, 'Electricity bill', 2500.00, '2024-05-05', 'Utilities'),
(3, 'Groceries purchase', 12000.00, '2024-05-02', 'Supplies');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `feedback_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `customer_id`, `rating`, `comment`, `feedback_date`) VALUES
(1, 1, 5, 'Great food and fast service!', '2025-08-18 22:30:52'),
(2, 2, 4, 'Biryani was a little too spicy.', '2025-08-18 22:30:52'),
(3, 3, 5, 'Good value for money.', '2025-08-18 22:30:52'),
(4, 4, 3, 'Service was a bit slow today.', '2025-08-18 22:30:52'),
(5, 1011, 5, 'That\'s a great experience.', '2025-11-22 13:07:12'),
(6, 1011, 4, 'Quia officia saepe t', '2025-11-22 13:11:46'),
(7, 1011, 4, 'Quia officia saepe t', '2025-11-22 13:12:21'),
(9, 1015, 4, 'Good Food', '2025-11-22 14:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `stock_quantity`, `last_updated`) VALUES
(1, 1, 32, '2025-12-05 14:52:03'),
(2, 2, 20, '2025-11-22 14:01:47'),
(3, 3, 164, '2025-11-22 14:01:47'),
(4, 4, 61, '2025-11-22 14:01:09'),
(5, 5, 107, '2025-11-22 13:35:24'),
(6, 6, 48, '2025-08-19 11:54:34'),
(7, 7, 132, '2025-08-19 11:54:34'),
(8, 8, 58, '2025-08-19 11:54:34'),
(9, 9, 150, '2025-08-19 11:42:32'),
(10, 10, 0, '2025-08-19 11:43:27'),
(11, 11, 80, '2025-08-19 11:42:32'),
(12, 12, 0, '2025-08-19 11:43:27'),
(13, 13, 196, '2025-11-22 14:33:19'),
(14, 14, 180, '2025-08-19 11:42:32'),
(15, 15, 50, '2025-12-05 14:52:47'),
(16, 16, 75, '2025-08-19 11:42:32'),
(17, 17, 20, '2025-12-05 14:52:32'),
(18, 18, 110, '2025-08-19 11:42:32'),
(19, 19, 95, '2025-08-19 11:42:32'),
(20, 20, 0, '2025-08-19 11:43:27'),
(21, 21, 160, '2025-08-19 11:42:32'),
(22, 22, 100, '2025-08-19 11:42:32'),
(23, 23, 150, '2025-08-19 11:42:32'),
(24, 24, 85, '2025-08-19 11:42:32'),
(25, 25, 120, '2025-08-19 11:42:32'),
(26, 42, 457, '2025-12-05 14:38:25'),
(27, 43, 200, '2025-12-05 14:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `menu_id` int(11) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`menu_id`, `menu_name`, `start_date`, `end_date`, `description`) VALUES
(1, 'Ramadan Special', '2024-03-10', '2024-04-10', 'Special items for Ramadan'),
(2, 'Winter Warmers', '2023-12-01', '2024-02-28', 'Hot beverages and soups'),
(3, 'Student Combo', '2024-05-01', '2024-05-31', 'Affordable combo meals for students');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `menu_item_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`menu_item_id`, `menu_id`, `product_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 2, 4),
(4, 2, 5),
(5, 3, 1),
(6, 3, 3),
(7, 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `order_date` datetime NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `order_status` enum('Pending','Delivered','Rejected') NOT NULL DEFAULT 'Pending',
  `status` varchar(20) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `employee_id`, `order_date`, `total_amount`, `order_status`, `status`) VALUES
(1, 1, 2, '2024-05-01 10:00:00', 55.00, 'Rejected', 'Pending'),
(2, 2, 2, '2024-05-01 12:30:00', 150.00, 'Pending', 'Pending'),
(3, 3, 1, '2024-05-02 09:45:00', 70.00, 'Pending', 'Pending'),
(4, 4, 3, '2024-05-02 11:15:00', 30.00, 'Pending', 'Pending'),
(5, 5, 2, '2024-05-02 13:00:00', 160.00, 'Pending', 'Pending'),
(6, 6, 3, '2024-05-03 10:30:00', 25.00, 'Pending', 'Pending'),
(7, 7, 1, '2024-05-03 14:00:00', 180.00, 'Pending', 'Pending'),
(8, 10, 4, '2025-08-02 10:45:00', 320.00, 'Pending', 'Completed'),
(9, 3, 2, '2025-08-02 11:15:00', 220.00, 'Pending', 'Pending'),
(10, 14, 1, '2025-08-02 11:45:00', 185.00, 'Pending', 'Completed'),
(11, 18, 5, '2025-08-03 09:30:00', 265.00, 'Pending', 'Completed'),
(12, 7, 2, '2025-08-03 10:00:00', 195.00, 'Pending', 'Completed'),
(13, 22, 3, '2025-08-03 11:30:00', 280.00, 'Pending', 'Pending'),
(14, 4, 4, '2025-08-03 12:00:00', 305.00, 'Pending', 'Completed'),
(15, 16, 1, '2025-08-03 12:45:00', 175.00, 'Pending', 'Completed'),
(16, 11, 2, '2025-08-04 10:15:00', 240.00, 'Pending', 'Completed'),
(17, 19, 3, '2025-08-04 10:45:00', 200.00, 'Pending', 'Completed'),
(18, 2, 5, '2025-08-04 11:30:00', 160.00, 'Pending', 'Cancelled'),
(19, 21, 1, '2025-08-04 12:00:00', 230.00, 'Pending', 'Completed'),
(20, 13, 4, '2025-08-04 12:30:00', 270.00, 'Pending', 'Completed'),
(21, 6, 2, '2025-08-05 09:30:00', 195.00, 'Pending', 'Pending'),
(22, 10, 3, '2025-08-05 10:15:00', 310.00, 'Pending', 'Completed'),
(23, 9, 1, '2025-08-05 11:00:00', 285.00, 'Pending', 'Completed'),
(24, 12, 5, '2025-08-05 11:30:00', 125.00, 'Pending', 'Completed'),
(25, 17, 4, '2025-08-05 12:15:00', 350.00, 'Pending', 'Completed'),
(26, 1, 2, '2025-08-06 09:45:00', 175.00, 'Pending', 'Completed'),
(27, 8, 3, '2025-08-06 10:30:00', 215.00, 'Pending', 'Completed'),
(28, 14, 5, '2025-08-06 11:15:00', 195.00, 'Pending', 'Pending'),
(29, 20, 4, '2025-08-06 11:45:00', 285.00, 'Pending', 'Completed'),
(30, 3, 1, '2025-08-06 12:15:00', 325.00, 'Pending', 'Completed'),
(31, 11, 2, '2025-08-07 09:30:00', 140.00, 'Pending', 'Completed'),
(32, 16, 3, '2025-08-07 10:15:00', 195.00, 'Pending', 'Completed'),
(33, 5, 4, '2025-08-07 10:45:00', 270.00, 'Pending', 'Completed'),
(34, 18, 1, '2025-08-07 11:30:00', 310.00, 'Pending', 'Completed'),
(35, 7, 2, '2025-08-07 12:00:00', 190.00, 'Pending', 'Cancelled'),
(36, 13, 5, '2025-08-08 09:30:00', 245.00, 'Pending', 'Completed'),
(37, 2, 3, '2025-08-08 10:00:00', 260.00, 'Pending', 'Pending'),
(38, 19, 4, '2025-08-08 10:45:00', 175.00, 'Pending', 'Completed'),
(39, 21, 1, '2025-08-08 11:15:00', 225.00, 'Pending', 'Completed'),
(40, 15, 2, '2025-08-08 11:45:00', 315.00, 'Pending', 'Completed'),
(61, 3, 2, '2025-08-12 10:00:00', 500.00, 'Pending', 'Pending'),
(62, 7, 1, '2025-08-12 10:30:00', 450.00, 'Pending', 'Pending'),
(63, 12, 4, '2025-08-12 11:00:00', 600.00, 'Pending', 'Pending'),
(64, 15, 3, '2025-08-12 11:30:00', 550.00, 'Pending', 'Pending'),
(65, 18, 2, '2025-08-12 12:00:00', 480.00, 'Pending', 'Pending'),
(66, 4, 2, '2025-08-13 09:30:00', 700.00, 'Pending', 'Pending'),
(67, 6, 3, '2025-08-13 10:00:00', 650.00, 'Pending', 'Pending'),
(68, 8, 1, '2025-08-13 10:30:00', 720.00, 'Pending', 'Pending'),
(69, 10, 4, '2025-08-13 11:00:00', 680.00, 'Pending', 'Pending'),
(70, 12, 2, '2025-08-13 11:30:00', 600.00, 'Pending', 'Pending'),
(71, 14, 3, '2025-08-13 12:00:00', 750.00, 'Pending', 'Pending'),
(72, 16, 1, '2025-08-13 12:30:00', 800.00, 'Pending', 'Pending'),
(73, 18, 4, '2025-08-14 09:30:00', 670.00, 'Pending', 'Pending'),
(74, 20, 2, '2025-08-14 10:00:00', 710.00, 'Pending', 'Pending'),
(75, 22, 3, '2025-08-14 10:30:00', 690.00, 'Pending', 'Pending'),
(76, 5, 2, '2025-08-15 09:30:00', 800.00, 'Pending', 'Pending'),
(77, 7, 3, '2025-08-15 10:00:00', 750.00, 'Pending', 'Pending'),
(78, 9, 1, '2025-08-15 10:30:00', 820.00, 'Pending', 'Pending'),
(79, 11, 4, '2025-08-15 11:00:00', 780.00, 'Pending', 'Pending'),
(80, 13, 2, '2025-08-15 11:30:00', 850.00, 'Pending', 'Pending'),
(81, 15, 3, '2025-08-15 12:00:00', 900.00, 'Pending', 'Pending'),
(82, 17, 1, '2025-08-15 12:30:00', 870.00, 'Pending', 'Pending'),
(83, 19, 4, '2025-08-16 09:30:00', 940.00, 'Pending', 'Pending'),
(84, 21, 2, '2025-08-16 10:00:00', 880.00, 'Pending', 'Pending'),
(85, 23, 3, '2025-08-16 10:30:00', 920.00, 'Pending', 'Pending'),
(86, 25, 1, '2025-08-16 11:00:00', 860.00, 'Pending', 'Pending'),
(87, 2, 4, '2025-08-16 11:30:00', 890.00, 'Pending', 'Pending'),
(88, 4, 2, '2025-08-16 12:00:00', 930.00, 'Pending', 'Pending'),
(89, 6, 3, '2025-08-16 12:30:00', 970.00, 'Pending', 'Pending'),
(90, 8, 1, '2025-08-17 09:30:00', 940.00, 'Pending', 'Pending'),
(91, 10, 4, '2025-08-17 10:00:00', 960.00, 'Pending', 'Pending'),
(92, 12, 2, '2025-08-17 10:30:00', 990.00, 'Pending', 'Pending'),
(93, 14, 3, '2025-08-17 11:00:00', 1000.00, 'Pending', 'Pending'),
(94, 16, 1, '2025-08-17 11:30:00', 1020.00, 'Pending', 'Pending'),
(95, 18, 4, '2025-08-17 12:00:00', 1050.00, 'Pending', 'Pending'),
(96, 1, 2, '2025-08-18 09:30:00', 1100.00, 'Pending', 'Pending'),
(97, 3, 3, '2025-08-18 10:00:00', 1150.00, 'Pending', 'Pending'),
(98, 5, 1, '2025-08-18 10:30:00', 1200.00, 'Pending', 'Pending'),
(99, 7, 4, '2025-08-18 11:00:00', 1080.00, 'Pending', 'Pending'),
(100, 9, 2, '2025-08-18 11:30:00', 1120.00, 'Pending', 'Pending'),
(101, 11, 3, '2025-08-18 12:00:00', 1180.00, 'Pending', 'Pending'),
(102, 13, 1, '2025-08-18 12:30:00', 1250.00, 'Pending', 'Pending'),
(103, 15, 4, '2025-08-19 09:30:00', 1170.00, 'Pending', 'Pending'),
(104, 17, 2, '2025-08-19 10:00:00', 1230.00, 'Pending', 'Pending'),
(105, 19, 3, '2025-08-19 10:30:00', 1190.00, 'Pending', 'Pending'),
(106, 21, 1, '2025-08-19 11:00:00', 1210.00, 'Pending', 'Pending'),
(107, 23, 4, '2025-08-19 11:30:00', 1260.00, 'Pending', 'Pending'),
(108, 1, 2, '2025-08-20 09:30:00', 630.00, 'Pending', 'Pending'),
(109, 2, 3, '2025-08-20 10:00:00', 765.00, 'Pending', 'Pending'),
(110, 3, 1, '2025-08-20 10:30:00', 1320.00, 'Pending', 'Pending'),
(111, 4, 4, '2025-08-20 11:00:00', 325.00, 'Pending', 'Pending'),
(112, 5, 2, '2025-08-20 11:30:00', 950.00, 'Pending', 'Pending'),
(113, 6, 3, '2025-08-20 12:00:00', 820.00, 'Pending', 'Pending'),
(114, 7, 1, '2025-08-20 12:30:00', 740.00, 'Pending', 'Pending'),
(115, 8, 4, '2025-08-21 09:30:00', 1250.00, 'Pending', 'Pending'),
(116, 9, 2, '2025-08-21 10:00:00', 840.00, 'Pending', 'Pending'),
(117, 10, 3, '2025-08-21 10:30:00', 1000.00, 'Pending', 'Pending'),
(118, 1, 2, '2025-08-20 09:30:00', 300.00, 'Pending', 'Pending'),
(119, 2, 3, '2025-08-20 10:00:00', 1060.00, 'Pending', 'Pending'),
(120, 3, 1, '2025-08-20 10:30:00', 735.00, 'Pending', 'Pending'),
(121, 4, 4, '2025-08-20 11:00:00', 970.00, 'Pending', 'Pending'),
(122, 5, 2, '2025-08-20 11:30:00', 825.00, 'Pending', 'Pending'),
(123, 6, 3, '2025-08-20 12:00:00', 620.00, 'Pending', 'Pending'),
(124, 7, 1, '2025-08-20 12:30:00', 770.00, 'Pending', 'Pending'),
(125, 8, 4, '2025-08-21 09:30:00', 1040.00, 'Pending', 'Pending'),
(126, 9, 2, '2025-08-21 10:00:00', 720.00, 'Pending', 'Pending'),
(127, 10, 3, '2025-08-21 10:30:00', 900.00, 'Pending', 'Pending'),
(128, 11, 2, '2025-08-21 11:00:00', 550.00, 'Pending', 'Pending'),
(129, 12, 3, '2025-08-21 11:30:00', 620.00, 'Pending', 'Pending'),
(130, 13, 4, '2025-08-21 12:00:00', 710.00, 'Pending', 'Pending'),
(131, 14, 5, '2025-08-21 12:30:00', 480.00, 'Pending', 'Pending'),
(132, 15, 6, '2025-08-22 09:30:00', 690.00, 'Pending', 'Pending'),
(133, 16, 7, '2025-08-22 10:00:00', 730.00, 'Pending', 'Pending'),
(134, 17, 8, '2025-08-22 10:30:00', 810.00, 'Pending', 'Pending'),
(135, 18, 9, '2025-08-22 11:00:00', 900.00, 'Pending', 'Pending'),
(136, 19, 10, '2025-08-22 11:30:00', 660.00, 'Pending', 'Pending'),
(137, 20, 1, '2025-08-22 12:00:00', 720.00, 'Pending', 'Pending'),
(138, 1011, NULL, '2025-11-22 19:35:24', 940.00, 'Pending', 'active'),
(139, 1011, 11, '2025-11-22 19:48:11', 650.00, 'Pending', 'active'),
(140, 1011, 8, '2025-11-22 19:49:17', 350.00, 'Pending', 'active'),
(141, 1011, 3, '2025-11-22 19:49:50', 330.00, 'Rejected', 'active'),
(142, 1011, 1, '2025-11-22 19:52:06', 210.00, 'Rejected', 'active'),
(143, 1011, 3, '2025-11-22 19:54:05', 100.00, 'Rejected', 'active'),
(144, 1011, 2, '2025-11-22 19:58:32', 280.00, 'Rejected', 'active'),
(145, 1015, 9, '2025-11-22 20:01:09', 460.00, 'Rejected', 'active'),
(146, 1011, 4, '2025-11-22 20:01:47', 680.00, 'Rejected', 'active'),
(147, 1011, 3, '2025-11-22 20:11:51', 50.00, 'Delivered', 'active'),
(148, 1015, 11, '2025-11-22 20:24:22', 100.00, 'Delivered', 'active'),
(149, 1016, 7, '2025-11-22 20:33:19', 360.00, 'Pending', 'active'),
(150, 1016, 3, '2025-12-01 01:21:17', 150.00, 'Pending', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 1, 25.00),
(2, 1, 5, 1, 20.00),
(3, 1, 7, 1, 15.00),
(4, 2, 2, 1, 150.00),
(5, 3, 1, 2, 25.00),
(6, 3, 3, 1, 15.00),
(7, 4, 4, 1, 30.00),
(8, 5, 2, 1, 150.00),
(9, 5, 7, 1, 15.00),
(10, 6, 1, 1, 25.00),
(11, 7, 6, 2, 80.00),
(12, 7, 4, 1, 30.00),
(13, 108, 2, 2, 150.00),
(14, 108, 4, 1, 30.00),
(15, 109, 6, 3, 80.00),
(16, 109, 3, 5, 15.00),
(17, 110, 2, 4, 150.00),
(18, 110, 8, 6, 20.00),
(19, 111, 1, 3, 25.00),
(20, 112, 5, 5, 20.00),
(21, 112, 7, 10, 15.00),
(22, 113, 6, 4, 80.00),
(23, 114, 3, 6, 15.00),
(24, 115, 2, 3, 150.00),
(25, 116, 4, 4, 30.00),
(26, 117, 8, 5, 20.00),
(27, 119, 2, 3, 150.00),
(28, 119, 6, 2, 80.00),
(29, 120, 3, 5, 15.00),
(30, 120, 4, 2, 30.00),
(31, 121, 2, 4, 150.00),
(32, 121, 8, 6, 20.00),
(33, 122, 1, 5, 25.00),
(34, 123, 5, 6, 20.00),
(35, 124, 7, 8, 15.00),
(36, 125, 6, 3, 80.00),
(37, 138, 1, 12, 25.00),
(38, 138, 2, 1, 150.00),
(39, 138, 5, 1, 20.00),
(40, 139, 1, 1, 25.00),
(41, 139, 2, 1, 150.00),
(42, 139, 4, 5, 30.00),
(43, 140, 1, 1, 25.00),
(44, 140, 2, 1, 150.00),
(45, 141, 2, 1, 150.00),
(46, 141, 3, 1, 15.00),
(47, 142, 3, 7, 15.00),
(48, 143, 1, 2, 25.00),
(49, 144, 1, 5, 25.00),
(50, 144, 3, 1, 15.00),
(51, 145, 1, 2, 25.00),
(52, 145, 2, 1, 150.00),
(53, 145, 4, 1, 30.00),
(54, 146, 1, 1, 25.00),
(55, 146, 2, 2, 150.00),
(56, 146, 3, 1, 15.00),
(57, 147, 1, 1, 25.00),
(58, 148, 1, 2, 25.00),
(59, 149, 13, 2, 90.00),
(60, 150, 1, 3, 25.00);

--
-- Triggers `order_items`
--
DELIMITER $$
CREATE TRIGGER `restore_inventory_on_order_delete` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
    UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE product_id = OLD.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_inventory_on_order` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    UPDATE inventory
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_order_total_on_delete` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders
    SET total_amount = total_amount - (OLD.quantity * OLD.unit_price)
    WHERE order_id = OLD.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_order_total_on_insert` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders
    SET total_amount = total_amount + (NEW.quantity * NEW.unit_price)
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_order_total_on_update` AFTER UPDATE ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders
    SET total_amount = total_amount + (NEW.quantity * NEW.unit_price) - (OLD.quantity * OLD.unit_price)
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `sales_id`, `amount`, `payment_date`, `method`) VALUES
(1, 1, 55.00, '2024-05-01 10:05:00', 'Cash'),
(2, 2, 150.00, '2024-05-01 12:35:00', 'Card'),
(3, 3, 70.00, '2024-05-02 09:50:00', 'Cash'),
(4, 4, 160.00, '2024-05-02 13:05:00', 'Card'),
(5, 5, 25.00, '2024-05-03 10:35:00', 'Cash');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `deleted` enum('0','1') NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `category_id`, `deleted`, `created_at`) VALUES
(1, 'Paratha', 'Plain paratha with dal', 25.00, 1, '0', '2025-08-18 22:30:51'),
(2, 'Chicken Biryani', 'Spicy chicken biryani', 150.00, 2, '0', '2025-08-18 22:30:51'),
(3, 'Samosa', 'Potato-filled fried pastry', 15.00, 3, '0', '2025-08-18 22:30:51'),
(4, 'Coffee', 'Hot black coffee', 30.00, 4, '0', '2025-08-18 22:30:51'),
(5, 'Tea', 'Hot milk tea', 20.00, 4, '0', '2025-08-18 22:30:51'),
(6, 'Chicken Sandwich', 'Grilled chicken sandwich with cheese', 80.00, 3, '0', '2025-08-18 22:30:51'),
(7, 'Plain Water', 'Bottled mineral water', 15.00, 4, '0', '2025-08-18 22:30:51'),
(8, 'Roshogolla', 'Sweet syrupy dumpling', 20.00, 5, '0', '2025-08-18 22:30:51'),
(9, 'Veg Burger', 'Grilled vegetable burger with cheese', 85.00, 3, '0', '2025-08-19 11:40:29'),
(10, 'Beef Burger', 'Grilled beef burger with lettuce and tomato', 120.00, 3, '0', '2025-08-19 11:40:29'),
(11, 'Mango Juice', 'Fresh mango juice', 60.00, 4, '0', '2025-08-19 11:40:29'),
(12, 'Orange Juice', 'Freshly squeezed orange juice', 55.00, 4, '0', '2025-08-19 11:40:29'),
(13, 'Chocolate Cake', 'Rich chocolate layered cake', 90.00, 5, '0', '2025-08-19 11:40:29'),
(14, 'Vanilla Ice Cream', 'Creamy vanilla ice cream scoop', 45.00, 5, '0', '2025-08-19 11:40:29'),
(15, 'Pasta Alfredo', 'Creamy white sauce pasta', 150.00, 2, '0', '2025-08-19 11:40:29'),
(16, 'Chicken Nuggets', 'Crispy fried chicken nuggets', 70.00, 3, '0', '2025-08-19 11:40:29'),
(17, 'French Fries', 'Golden fried potato fries', 40.00, 3, '0', '2025-08-19 11:40:29'),
(18, 'Egg Roll', 'Spicy egg roll with vegetables', 30.00, 1, '0', '2025-08-19 11:40:29'),
(19, 'Paneer Tikka', 'Grilled paneer with spices', 110.00, 2, '0', '2025-08-19 11:40:29'),
(20, 'Chicken Shawarma', 'Chicken wrapped in pita with veggies', 130.00, 3, '0', '2025-08-19 11:40:29'),
(21, 'Coke', 'Chilled Coca-Cola', 25.00, 4, '0', '2025-08-19 11:40:29'),
(22, 'Pepsi', 'Chilled Pepsi', 25.00, 4, '0', '2025-08-19 11:40:29'),
(23, 'Brownie', 'Chocolate fudge brownie', 50.00, 5, '0', '2025-08-19 11:40:29'),
(24, 'Fruit Salad', 'Mixed fresh fruits with honey', 60.00, 5, '0', '2025-08-19 11:40:29'),
(25, 'Veg Sandwich', 'Grilled vegetables sandwich', 65.00, 3, '0', '2025-08-19 11:40:29'),
(26, 'Chicken Sandwich Deluxe', 'Chicken sandwich with extra cheese', 100.00, 3, '1', '2025-08-19 11:40:29'),
(27, 'Cheese Pizza', 'Medium pizza with mozzarella cheese', 180.00, 2, '1', '2025-08-19 11:40:29'),
(28, 'Pepperoni Pizza', 'Medium pizza with pepperoni', 200.00, 2, '1', '2025-08-19 11:40:29'),
(29, 'Lemonade', 'Fresh lemon drink', 35.00, 4, '1', '2025-08-19 11:40:29'),
(30, 'Iced Coffee', 'Cold coffee with ice', 70.00, 4, '1', '2025-08-19 11:40:29'),
(31, 'Muffin', 'Chocolate chip muffin', 40.00, 5, '1', '2025-08-19 11:40:29'),
(32, 'Cupcake', 'Vanilla cupcake with cream', 45.00, 5, '1', '2025-08-19 11:40:29'),
(33, 'Veg Wrap', 'Healthy veg wrap with sauces', 60.00, 3, '1', '2025-08-19 11:40:29'),
(34, 'Testy food', 'This is very testy food', 100.00, 8, '1', '2025-11-22 10:51:31'),
(41, 'Carson Barber', 'Odio dolore vero nos', 489.00, 8, '1', '2025-12-05 14:33:19'),
(42, 'Aphrodite Sexton', 'Temporibus molestiae', 397.00, 10, '1', '2025-12-05 14:38:25'),
(43, 'Vapa Pitha', 'Very testy cake for winter', 15.00, 8, '0', '2025-12-05 14:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `return_id` int(11) NOT NULL,
  `sales_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`return_id`, `sales_id`, `product_id`, `quantity`, `reason`, `return_date`) VALUES
(1, 1, 5, 1, 'Wrong order item', '2024-05-01'),
(2, 3, 3, 1, 'Item was cold', '2024-05-02');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `salary_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`salary_id`, `employee_id`, `amount`, `payment_date`) VALUES
(1, 1, 35000.00, '2024-04-30'),
(2, 2, 18000.00, '2024-04-30'),
(3, 3, 22000.00, '2024-04-30'),
(4, 4, 20000.00, '2024-04-30'),
(5, 5, 15000.00, '2024-04-30');

--
-- Triggers `salaries`
--
DELIMITER $$
CREATE TRIGGER `prevent_salary_decrease` BEFORE UPDATE ON `salaries` FOR EACH ROW BEGIN
    IF NEW.amount < OLD.amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be decreased.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sales_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sales_date` datetime NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sales_id`, `order_id`, `sales_date`, `total_amount`, `payment_method`) VALUES
(1, 1, '2024-05-01 10:05:00', 55.00, 'Cash'),
(2, 2, '2024-05-01 12:35:00', 150.00, 'Card'),
(3, 3, '2024-05-02 09:50:00', 70.00, 'Cash'),
(4, 5, '2024-05-02 13:05:00', 160.00, 'Card'),
(5, 6, '2024-05-03 10:35:00', 25.00, 'Cash'),
(39, 66, '2025-08-13 09:35:00', 700.00, 'Card'),
(40, 67, '2025-08-13 10:05:00', 650.00, 'Cash'),
(48, 75, '2025-08-14 10:35:00', 690.00, 'Cash'),
(49, 76, '2025-08-15 09:35:00', 800.00, 'Card'),
(50, 77, '2025-08-15 10:05:00', 750.00, 'Cash'),
(54, 81, '2025-08-15 12:05:00', 900.00, 'Cash'),
(55, 82, '2025-08-15 12:35:00', 870.00, 'Card'),
(56, 83, '2025-08-16 09:35:00', 940.00, 'Cash'),
(57, 84, '2025-08-16 10:05:00', 880.00, 'Card'),
(58, 85, '2025-08-16 10:35:00', 920.00, 'Cash'),
(59, 86, '2025-08-16 11:05:00', 860.00, 'Card'),
(63, 90, '2025-08-17 09:35:00', 940.00, 'Card'),
(64, 91, '2025-08-17 10:05:00', 960.00, 'Cash'),
(65, 92, '2025-08-17 10:35:00', 990.00, 'Card'),
(66, 93, '2025-08-17 11:05:00', 1000.00, 'Cash'),
(67, 94, '2025-08-17 11:35:00', 1020.00, 'Card'),
(68, 95, '2025-08-17 12:05:00', 1050.00, 'Cash'),
(69, 96, '2025-08-18 09:35:00', 1100.00, 'Card'),
(70, 97, '2025-08-18 10:05:00', 1150.00, 'Cash'),
(71, 98, '2025-08-18 10:35:00', 1200.00, 'Card'),
(72, 99, '2025-08-18 11:05:00', 1080.00, 'Cash'),
(73, 100, '2025-08-18 11:35:00', 1120.00, 'Card'),
(74, 101, '2025-08-18 12:05:00', 1180.00, 'Cash'),
(75, 102, '2025-08-18 12:35:00', 1250.00, 'Card'),
(76, 103, '2025-08-19 09:35:00', 1170.00, 'Cash'),
(77, 104, '2025-08-19 10:05:00', 1230.00, 'Card'),
(78, 105, '2025-08-19 10:35:00', 1190.00, 'Cash'),
(79, 106, '2025-08-19 11:05:00', 1210.00, 'Card'),
(80, 107, '2025-08-19 11:35:00', 1260.00, 'Cash'),
(81, 18, '2025-08-21 11:05:00', 690.00, 'Cash'),
(82, 19, '2025-08-21 11:35:00', 720.00, 'Card'),
(83, 20, '2025-08-21 12:05:00', 830.00, 'Cash'),
(84, 21, '2025-08-21 12:35:00', 480.00, 'Card'),
(85, 22, '2025-08-22 09:35:00', 690.00, 'Cash'),
(86, 23, '2025-08-22 10:05:00', 810.00, 'Card'),
(87, 24, '2025-08-22 10:35:00', 810.00, 'Cash'),
(88, 25, '2025-08-22 11:05:00', 900.00, 'Card'),
(89, 26, '2025-08-22 11:35:00', 660.00, 'Cash'),
(90, 27, '2025-08-22 12:05:00', 720.00, 'Card');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `shift_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`shift_id`, `employee_id`, `shift_date`, `start_time`, `end_time`) VALUES
(1, 1, '2024-05-01', '09:00:00', '17:00:00'),
(2, 2, '2024-05-01', '10:00:00', '18:00:00'),
(3, 3, '2024-05-02', '08:00:00', '16:00:00'),
(4, 1, '2024-05-02', '10:00:00', '18:00:00'),
(5, 2, '2024-05-03', '09:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `contact_person`, `phone_number`, `email`, `address`, `created_at`) VALUES
(1, 'Fresh Foods Ltd.', 'Mr. Alam', '01898765432', 'info@freshfoods.com', 'Tejgaon, Dhaka', '2025-08-18 22:30:51'),
(2, 'Dairy Delights', 'Ms. Soma', '01998765432', 'contact@dairydelights.com', 'Mohakhali, Dhaka', '2025-08-18 22:30:51'),
(3, 'Spice World', 'Mr. Rahim', '01798765432', 'sales@spiceworld.com', 'Karwan Bazar, Dhaka', '2025-08-18 22:30:51');

-- --------------------------------------------------------

--
-- Table structure for table `supply_orders`
--

CREATE TABLE `supply_orders` (
  `supply_order_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','delivered','cancelled') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supply_orders`
--

INSERT INTO `supply_orders` (`supply_order_id`, `supplier_id`, `order_date`, `delivery_date`, `total_amount`, `status`) VALUES
(1, 1, '2024-04-28', '2024-04-30', 5000.00, 'delivered'),
(2, 2, '2024-05-01', '2024-05-03', 3000.00, 'pending'),
(3, 3, '2024-05-01', '2024-05-04', 8000.00, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Admin', 'admin@example.com', '$2y$10$wQ9j7jQxYFxH6ZtW6j1G2e6cQx1o4pN0w4lJg4E8H3C0R3H8Vf7iK', 'admin', '2025-11-22 07:52:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `canteen_info`
--
ALTER TABLE `canteen_info`
  ADD PRIMARY KEY (`canteen_info_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `customer_audit_log`
--
ALTER TABLE `customer_audit_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD UNIQUE KEY `product_id` (`product_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`menu_item_id`),
  ADD KEY `menu_id` (`menu_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `sales_id` (`sales_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`return_id`),
  ADD KEY `sales_id` (`sales_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`salary_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`shift_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `supply_orders`
--
ALTER TABLE `supply_orders`
  ADD PRIMARY KEY (`supply_order_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `canteen_info`
--
ALTER TABLE `canteen_info`
  MODIFY `canteen_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1017;

--
-- AUTO_INCREMENT for table `customer_audit_log`
--
ALTER TABLE `customer_audit_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `menu_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `salary_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `supply_orders`
--
ALTER TABLE `supply_orders`
  MODIFY `supply_order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`),
  ADD CONSTRAINT `menu_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `returns`
--
ALTER TABLE `returns`
  ADD CONSTRAINT `returns_ibfk_1` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`),
  ADD CONSTRAINT `returns_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `salaries`
--
ALTER TABLE `salaries`
  ADD CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `supply_orders`
--
ALTER TABLE `supply_orders`
  ADD CONSTRAINT `supply_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
