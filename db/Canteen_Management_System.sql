-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 05, 2025 at 08:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
SET
    SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

START TRANSACTION;

SET
    time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `Canteen_Management_System`;

USE `Canteen_Management_System`;

-- --------------------------------------------------------
--
-- Table structure for table `canteen_info`
--
-- Error reading structure for table Canteen_Management_System.canteen_info: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`canteen_info`
-- Error reading data for table Canteen_Management_System.canteen_info: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`canteen_info`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `categories`
--
-- Error reading structure for table Canteen_Management_System.categories: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`categories`
-- Error reading data for table Canteen_Management_System.categories: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`categories`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `customers`
--
-- Error reading structure for table Canteen_Management_System.customers: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`customers`
-- Error reading data for table Canteen_Management_System.customers: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`customers`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `customer_audit_log`
--
-- Error reading structure for table Canteen_Management_System.customer_audit_log: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`customer_audit_log`
-- Error reading data for table Canteen_Management_System.customer_audit_log: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`customer_audit_log`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `employees`
--
-- Error reading structure for table Canteen_Management_System.employees: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`employees`
-- Error reading data for table Canteen_Management_System.employees: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`employees`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `expenses`
--
-- Error reading structure for table Canteen_Management_System.expenses: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`expenses`
-- Error reading data for table Canteen_Management_System.expenses: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`expenses`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `feedback`
--
-- Error reading structure for table Canteen_Management_System.feedback: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`feedback`
-- Error reading data for table Canteen_Management_System.feedback: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`feedback`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `inventory`
--
-- Error reading structure for table Canteen_Management_System.inventory: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`inventory`
-- Error reading data for table Canteen_Management_System.inventory: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`inventory`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `menus`
--
-- Error reading structure for table Canteen_Management_System.menus: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`menus`
-- Error reading data for table Canteen_Management_System.menus: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`menus`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `menu_items`
--
-- Error reading structure for table Canteen_Management_System.menu_items: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`menu_items`
-- Error reading data for table Canteen_Management_System.menu_items: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`menu_items`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `orders`
--
-- Error reading structure for table Canteen_Management_System.orders: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`orders`
-- Error reading data for table Canteen_Management_System.orders: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`orders`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `order_items`
--
-- Error reading structure for table Canteen_Management_System.order_items: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`order_items`
-- Error reading data for table Canteen_Management_System.order_items: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`order_items`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `payments`
--
-- Error reading structure for table Canteen_Management_System.payments: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`payments`
-- Error reading data for table Canteen_Management_System.payments: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`payments`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `products`
--
-- Error reading structure for table Canteen_Management_System.products: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`products`
-- Error reading data for table Canteen_Management_System.products: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`products`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `returns`
--
-- Error reading structure for table Canteen_Management_System.returns: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`returns`
-- Error reading data for table Canteen_Management_System.returns: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`returns`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `salaries`
--
-- Error reading structure for table Canteen_Management_System.salaries: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`salaries`
-- Error reading data for table Canteen_Management_System.salaries: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`salaries`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `sales`
--
-- Error reading structure for table Canteen_Management_System.sales: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`sales`
-- Error reading data for table Canteen_Management_System.sales: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`sales`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `shifts`
--
-- Error reading structure for table Canteen_Management_System.shifts: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`shifts`
-- Error reading data for table Canteen_Management_System.shifts: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`shifts`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `suppliers`
--
-- Error reading structure for table Canteen_Management_System.suppliers: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`suppliers`
-- Error reading data for table Canteen_Management_System.suppliers: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`suppliers`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `supply_orders`
--
-- Error reading structure for table Canteen_Management_System.supply_orders: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`supply_orders`
-- Error reading data for table Canteen_Management_System.supply_orders: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`supply_orders`&#039; at line 1
-- --------------------------------------------------------
--
-- Table structure for table `users`
--
-- Error reading structure for table Canteen_Management_System.users: #1142 - SHOW command denied to user &#039;&#039;@&#039;localhost&#039; for table `Canteen_Management_System`.`users`
-- Error reading data for table Canteen_Management_System.users: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `Canteen_Management_System`.`users`&#039; at line 1
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;