-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2026 at 01:02 PM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lift`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_logs`
--

CREATE TABLE `admin_activity_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `admin_user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `affected_table` varchar(100) DEFAULT NULL,
  `affected_record_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_id` bigint(20) UNSIGNED NOT NULL,
  `setting_key` varchar(120) NOT NULL,
  `setting_value` text NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_id`, `setting_key`, `setting_value`, `description`, `updated_by`, `updated_at`) VALUES
(1, 'initial_search_radius_meters', '500', 'Initial ride/contributor search radius', NULL, '2026-11-18 11:26:56'),
(2, 'expanded_search_radius_meters', '1000', 'Expanded search radius if initial search finds no suitable match', NULL, '2026-11-18 11:26:56');

-- --------------------------------------------------------

--
-- Table structure for table `communities`
--

CREATE TABLE `communities` (
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `community_name` varchar(150) NOT NULL,
  `community_type` enum('COLLEGE','COMPANY','RESIDENTIAL','LOCAL','OTHER') NOT NULL DEFAULT 'OTHER',
  `description` varchar(1000) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `community_status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community_announcements`
--

CREATE TABLE `community_announcements` (
  `announcement_id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `published_at` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `announcement_status` enum('DRAFT','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community_members`
--

CREATE TABLE `community_members` (
  `community_member_id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `member_role` enum('MEMBER','COORDINATOR','ADMIN') NOT NULL DEFAULT 'MEMBER',
  `membership_status` enum('PENDING','ACTIVE','REJECTED','LEFT') NOT NULL DEFAULT 'PENDING',
  `joined_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contributor_profiles`
--

CREATE TABLE `contributor_profiles` (
  `contributor_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `driving_experience_years` tinyint(3) UNSIGNED DEFAULT NULL,
  `verification_status` enum('NOT_SUBMITTED','PENDING','VERIFIED','REJECTED') NOT NULL DEFAULT 'NOT_SUBMITTED',
  `contributor_status` enum('ACTIVE','INACTIVE','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `participant_one_id` bigint(20) UNSIGNED NOT NULL,
  `participant_two_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `conversation_status` enum('ACTIVE','CLOSED','BLOCKED') NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emergency_contacts`
--

CREATE TABLE `emergency_contacts` (
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `contact_name` varchar(120) NOT NULL,
  `relationship` varchar(60) DEFAULT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `email` varchar(190) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleets`
--

CREATE TABLE `fleets` (
  `fleet_id` bigint(20) UNSIGNED NOT NULL,
  `fleet_name` varchar(150) NOT NULL,
  `organization_name` varchar(150) DEFAULT NULL,
  `contact_person` varchar(120) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `fleet_status` enum('ACTIVE','INACTIVE','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleet_assignments`
--

CREATE TABLE `fleet_assignments` (
  `assignment_id` bigint(20) UNSIGNED NOT NULL,
  `fleet_id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `driver_user_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_from` datetime NOT NULL,
  `assigned_to` datetime DEFAULT NULL,
  `assignment_status` enum('ACTIVE','COMPLETED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guardian_consents`
--

CREATE TABLE `guardian_consents` (
  `consent_id` bigint(20) UNSIGNED NOT NULL,
  `minor_user_id` bigint(20) UNSIGNED NOT NULL,
  `guardian_name` varchar(150) NOT NULL,
  `relationship` varchar(50) NOT NULL,
  `guardian_mobile` varchar(20) NOT NULL,
  `guardian_email` varchar(190) DEFAULT NULL,
  `consent_status` enum('PENDING','APPROVED','REJECTED','REVOKED') NOT NULL DEFAULT 'PENDING',
  `consent_method` enum('OTP','DIGITAL_CONSENT','DOCUMENT','MANUAL') NOT NULL DEFAULT 'OTP',
  `consent_document` varchar(500) DEFAULT NULL,
  `consent_requested_at` datetime NOT NULL DEFAULT current_timestamp(),
  `approved_at` datetime DEFAULT NULL,
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verification_notes` varchar(500) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incident_reports`
--

CREATE TABLE `incident_reports` (
  `incident_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reported_by` bigint(20) UNSIGNED NOT NULL,
  `reported_against` bigint(20) UNSIGNED DEFAULT NULL,
  `incident_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `incident_datetime` datetime DEFAULT NULL,
  `incident_status` enum('OPEN','UNDER_REVIEW','RESOLVED','CLOSED','REJECTED') NOT NULL DEFAULT 'OPEN',
  `resolution_notes` text DEFAULT NULL,
  `assigned_admin` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membership_plans`
--

CREATE TABLE `membership_plans` (
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `duration_days` smallint(5) UNSIGNED NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'INR',
  `plan_status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_plans`
--

INSERT INTO `membership_plans` (`plan_id`, `plan_name`, `description`, `duration_days`, `price`, `currency`, `plan_status`, `created_at`) VALUES
(1, 'Monthly Seeker', 'Monthly Lift Plz membership for Seekers', 30, 100.00, 'INR', 'ACTIVE', '2026-11-18 11:26:56'),
(2, 'Annual Seeker', 'Annual Lift Plz membership for Seekers', 365, 1000.00, 'INR', 'ACTIVE', '2026-11-18 11:26:56');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `message_text` text DEFAULT NULL,
  `attachment_path` varchar(500) DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT current_timestamp(),
  `message_status` enum('SENT','DELIVERED','READ','DELETED') NOT NULL DEFAULT 'SENT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `notification_type` varchar(60) DEFAULT NULL,
  `related_record_type` varchar(60) DEFAULT NULL,
  `related_record_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `membership_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_reference` varchar(150) DEFAULT NULL,
  `payment_gateway` varchar(80) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'INR',
  `payment_status` enum('PENDING','SUCCESS','FAILED','REFUNDED') NOT NULL DEFAULT 'PENDING',
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings_reviews`
--

CREATE TABLE `ratings_reviews` (
  `review_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `reviewer_id` bigint(20) UNSIGNED NOT NULL,
  `reviewee_id` bigint(20) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rides`
--

CREATE TABLE `rides` (
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `contributor_id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `source_location` varchar(255) NOT NULL,
  `source_latitude` decimal(10,7) DEFAULT NULL,
  `source_longitude` decimal(10,7) DEFAULT NULL,
  `destination_location` varchar(255) NOT NULL,
  `destination_latitude` decimal(10,7) DEFAULT NULL,
  `destination_longitude` decimal(10,7) DEFAULT NULL,
  `departure_datetime` datetime NOT NULL,
  `estimated_distance_km` decimal(9,2) DEFAULT NULL,
  `estimated_duration_minutes` int(10) UNSIGNED DEFAULT NULL,
  `total_seats` tinyint(3) UNSIGNED NOT NULL,
  `available_seats` tinyint(3) UNSIGNED NOT NULL,
  `ride_status` enum('DRAFT','PUBLISHED','IN_PROGRESS','COMPLETED','CANCELLED') NOT NULL DEFAULT 'DRAFT',
  `notes` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_bookings`
--

CREATE TABLE `ride_bookings` (
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `seeker_id` bigint(20) UNSIGNED NOT NULL,
  `booked_seats` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `booking_status` enum('CONFIRMED','CANCELLED','COMPLETED','NO_SHOW') NOT NULL DEFAULT 'CONFIRMED',
  `booked_at` timestamp NULL DEFAULT current_timestamp(),
  `cancelled_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_requests`
--

CREATE TABLE `ride_requests` (
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `seeker_id` bigint(20) UNSIGNED NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `pickup_latitude` decimal(10,7) DEFAULT NULL,
  `pickup_longitude` decimal(10,7) DEFAULT NULL,
  `drop_location` varchar(255) NOT NULL,
  `drop_latitude` decimal(10,7) DEFAULT NULL,
  `drop_longitude` decimal(10,7) DEFAULT NULL,
  `requested_seats` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `request_status` enum('PENDING','ACCEPTED','REJECTED','CANCELLED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `requested_at` timestamp NULL DEFAULT current_timestamp(),
  `responded_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_stops`
--

CREATE TABLE `ride_stops` (
  `stop_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `stop_type` enum('START','PICKUP','INTERMEDIATE','DROPOFF','END') NOT NULL,
  `sequence_number` smallint(5) UNSIGNED NOT NULL,
  `planned_arrival_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_tracking`
--

CREATE TABLE `ride_tracking` (
  `tracking_id` bigint(20) UNSIGNED NOT NULL,
  `ride_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `accuracy_meters` decimal(8,2) DEFAULT NULL,
  `recorded_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` smallint(5) UNSIGNED NOT NULL,
  `role_name` varchar(60) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`, `status`, `created_at`) VALUES
(1, 'SEEKER', 'User who searches for and requests available rides', 'ACTIVE', '2026-11-18 11:26:56'),
(2, 'CONTRIBUTOR', 'User who offers available seats on a journey', 'ACTIVE', '2026-11-18 11:26:56'),
(3, 'SUPER_ADMIN', 'Platform super administrator', 'ACTIVE', '2026-11-18 11:26:56'),
(4, 'REGIONAL_ADMIN', 'Administrator responsible for a region', 'ACTIVE', '2026-11-18 11:26:56'),
(5, 'COMMUNITY_COORDINATOR', 'Coordinator for a Lift Plz community', 'ACTIVE', '2026-11-18 11:26:56'),
(6, 'FLEET_MANAGER', 'Manager responsible for an organization fleet', 'ACTIVE', '2026-11-18 11:26:56');

-- --------------------------------------------------------

--
-- Table structure for table `seeker_profiles`
--

CREATE TABLE `seeker_profiles` (
  `seeker_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `preferred_gender` enum('ANY','MALE','FEMALE') NOT NULL DEFAULT 'ANY',
  `accessibility_requirements` varchar(500) DEFAULT NULL,
  `profile_status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subject` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `priority` enum('LOW','MEDIUM','HIGH','URGENT') NOT NULL DEFAULT 'MEDIUM',
  `ticket_status` enum('OPEN','IN_PROGRESS','WAITING_FOR_USER','RESOLVED','CLOSED') NOT NULL DEFAULT 'OPEN',
  `assigned_admin` bigint(20) UNSIGNED DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(190) NOT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('MALE','FEMALE','OTHER','PREFER_NOT_TO_SAY') DEFAULT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `account_status` enum('PENDING','ACTIVE','SUSPENDED','BLOCKED','DELETED') NOT NULL DEFAULT 'PENDING',
  `email_verified_at` datetime DEFAULT NULL,
  `mobile_verified_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_documents`
--

CREATE TABLE `user_documents` (
  `document_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `document_type` enum('AADHAAR','DRIVING_LICENCE','VOTER_ID','PASSPORT','OTHER') NOT NULL,
  `document_number_encrypted` varchar(500) DEFAULT NULL,
  `file_path` varchar(500) NOT NULL,
  `verification_status` enum('PENDING','VERIFIED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `rejection_reason` varchar(500) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_memberships`
--

CREATE TABLE `user_memberships` (
  `membership_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `membership_status` enum('PENDING','ACTIVE','EXPIRED','CANCELLED','SUSPENDED') NOT NULL DEFAULT 'PENDING',
  `auto_renewal` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `mapping_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` smallint(5) UNSIGNED NOT NULL,
  `assigned_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `registration_number` varchar(30) NOT NULL,
  `vehicle_type` enum('CAR','SUV','VAN','MOTORCYCLE','OTHER') NOT NULL,
  `brand` varchar(80) DEFAULT NULL,
  `model` varchar(80) DEFAULT NULL,
  `manufacturing_year` year(4) DEFAULT NULL,
  `seating_capacity` tinyint(3) UNSIGNED NOT NULL,
  `vehicle_status` enum('PENDING','ACTIVE','INACTIVE','REJECTED') NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_documents`
--

CREATE TABLE `vehicle_documents` (
  `document_id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `document_type` enum('REGISTRATION_CERTIFICATE','INSURANCE','POLLUTION_CERTIFICATE','OTHER') NOT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `file_path` varchar(500) NOT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `verification_status` enum('PENDING','VERIFIED','REJECTED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_admin_logs_admin_time` (`admin_user_id`,`created_at`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `fk_app_settings_updater` (`updated_by`);

--
-- Indexes for table `communities`
--
ALTER TABLE `communities`
  ADD PRIMARY KEY (`community_id`),
  ADD KEY `fk_communities_creator` (`created_by`);

--
-- Indexes for table `community_announcements`
--
ALTER TABLE `community_announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `idx_announcements_community_status` (`community_id`,`announcement_status`),
  ADD KEY `fk_announcements_creator` (`created_by`);

--
-- Indexes for table `community_members`
--
ALTER TABLE `community_members`
  ADD PRIMARY KEY (`community_member_id`),
  ADD UNIQUE KEY `uq_community_user` (`community_id`,`user_id`),
  ADD KEY `idx_community_members_user` (`user_id`);

--
-- Indexes for table `contributor_profiles`
--
ALTER TABLE `contributor_profiles`
  ADD PRIMARY KEY (`contributor_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`conversation_id`),
  ADD KEY `idx_conversations_user_one` (`participant_one_id`),
  ADD KEY `idx_conversations_user_two` (`participant_two_id`);

--
-- Indexes for table `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `idx_emergency_contacts_user` (`user_id`);

--
-- Indexes for table `fleets`
--
ALTER TABLE `fleets`
  ADD PRIMARY KEY (`fleet_id`),
  ADD KEY `fk_fleets_creator` (`created_by`);

--
-- Indexes for table `fleet_assignments`
--
ALTER TABLE `fleet_assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `idx_fleet_assignment_vehicle` (`vehicle_id`),
  ADD KEY `idx_fleet_assignment_driver` (`driver_user_id`),
  ADD KEY `fk_fa_fleet` (`fleet_id`);

--
-- Indexes for table `guardian_consents`
--
ALTER TABLE `guardian_consents`
  ADD PRIMARY KEY (`consent_id`),
  ADD KEY `idx_guardian_minor_user` (`minor_user_id`),
  ADD KEY `idx_guardian_status` (`consent_status`),
  ADD KEY `idx_guardian_verified_by` (`verified_by`);

--
-- Indexes for table `incident_reports`
--
ALTER TABLE `incident_reports`
  ADD PRIMARY KEY (`incident_id`),
  ADD KEY `idx_incidents_ride` (`ride_id`),
  ADD KEY `idx_incidents_reporter` (`reported_by`),
  ADD KEY `idx_incidents_status` (`incident_status`),
  ADD KEY `fk_incidents_against` (`reported_against`),
  ADD KEY `fk_incidents_admin` (`assigned_admin`);

--
-- Indexes for table `membership_plans`
--
ALTER TABLE `membership_plans`
  ADD PRIMARY KEY (`plan_id`),
  ADD UNIQUE KEY `plan_name` (`plan_name`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `idx_messages_conversation_time` (`conversation_id`,`sent_at`),
  ADD KEY `fk_messages_sender` (`sender_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_notifications_user_read` (`user_id`,`is_read`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `transaction_reference` (`transaction_reference`),
  ADD KEY `idx_payments_user` (`user_id`),
  ADD KEY `fk_payments_membership` (`membership_id`);

--
-- Indexes for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `uq_ride_reviewer_reviewee` (`ride_id`,`reviewer_id`,`reviewee_id`),
  ADD KEY `idx_reviews_reviewee` (`reviewee_id`),
  ADD KEY `fk_reviews_reviewer` (`reviewer_id`);

--
-- Indexes for table `rides`
--
ALTER TABLE `rides`
  ADD PRIMARY KEY (`ride_id`),
  ADD KEY `idx_rides_contributor` (`contributor_id`),
  ADD KEY `idx_rides_vehicle` (`vehicle_id`),
  ADD KEY `idx_rides_departure_status` (`departure_datetime`,`ride_status`);

--
-- Indexes for table `ride_bookings`
--
ALTER TABLE `ride_bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD UNIQUE KEY `request_id` (`request_id`),
  ADD KEY `idx_bookings_ride` (`ride_id`),
  ADD KEY `idx_bookings_seeker` (`seeker_id`);

--
-- Indexes for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_requests_ride_status` (`ride_id`,`request_status`),
  ADD KEY `idx_requests_seeker` (`seeker_id`);

--
-- Indexes for table `ride_stops`
--
ALTER TABLE `ride_stops`
  ADD PRIMARY KEY (`stop_id`),
  ADD UNIQUE KEY `uq_ride_stop_sequence` (`ride_id`,`sequence_number`);

--
-- Indexes for table `ride_tracking`
--
ALTER TABLE `ride_tracking`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `idx_tracking_ride_time` (`ride_id`,`recorded_at`),
  ADD KEY `fk_tracking_user` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `seeker_profiles`
--
ALTER TABLE `seeker_profiles`
  ADD PRIMARY KEY (`seeker_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `idx_support_tickets_user` (`user_id`),
  ADD KEY `idx_support_tickets_status` (`ticket_status`),
  ADD KEY `fk_support_admin` (`assigned_admin`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`),
  ADD KEY `idx_users_status` (`account_status`);

--
-- Indexes for table `user_documents`
--
ALTER TABLE `user_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `idx_user_documents_user` (`user_id`),
  ADD KEY `idx_user_documents_status` (`verification_status`),
  ADD KEY `fk_user_documents_verifier` (`verified_by`);

--
-- Indexes for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD PRIMARY KEY (`membership_id`),
  ADD KEY `idx_memberships_user_status` (`user_id`,`membership_status`),
  ADD KEY `idx_memberships_expiry` (`expiry_date`),
  ADD KEY `fk_memberships_plan` (`plan_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`mapping_id`),
  ADD UNIQUE KEY `uq_user_role` (`user_id`,`role_id`),
  ADD KEY `fk_user_roles_role` (`role_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `registration_number` (`registration_number`),
  ADD KEY `idx_vehicles_user` (`user_id`);

--
-- Indexes for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `idx_vehicle_documents_vehicle` (`vehicle_id`),
  ADD KEY `fk_vehicle_doc_verifier` (`verified_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `communities`
--
ALTER TABLE `communities`
  MODIFY `community_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `community_announcements`
--
ALTER TABLE `community_announcements`
  MODIFY `announcement_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `community_members`
--
ALTER TABLE `community_members`
  MODIFY `community_member_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contributor_profiles`
--
ALTER TABLE `contributor_profiles`
  MODIFY `contributor_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `conversation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  MODIFY `contact_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fleets`
--
ALTER TABLE `fleets`
  MODIFY `fleet_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fleet_assignments`
--
ALTER TABLE `fleet_assignments`
  MODIFY `assignment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guardian_consents`
--
ALTER TABLE `guardian_consents`
  MODIFY `consent_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incident_reports`
--
ALTER TABLE `incident_reports`
  MODIFY `incident_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membership_plans`
--
ALTER TABLE `membership_plans`
  MODIFY `plan_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  MODIFY `review_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rides`
--
ALTER TABLE `rides`
  MODIFY `ride_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_bookings`
--
ALTER TABLE `ride_bookings`
  MODIFY `booking_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_requests`
--
ALTER TABLE `ride_requests`
  MODIFY `request_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_stops`
--
ALTER TABLE `ride_stops`
  MODIFY `stop_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_tracking`
--
ALTER TABLE `ride_tracking`
  MODIFY `tracking_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `seeker_profiles`
--
ALTER TABLE `seeker_profiles`
  MODIFY `seeker_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `ticket_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_documents`
--
ALTER TABLE `user_documents`
  MODIFY `document_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_memberships`
--
ALTER TABLE `user_memberships`
  MODIFY `membership_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `mapping_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  MODIFY `document_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  ADD CONSTRAINT `fk_admin_logs_user` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD CONSTRAINT `fk_app_settings_updater` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `communities`
--
ALTER TABLE `communities`
  ADD CONSTRAINT `fk_communities_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `community_announcements`
--
ALTER TABLE `community_announcements`
  ADD CONSTRAINT `fk_announcements_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`community_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_announcements_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `community_members`
--
ALTER TABLE `community_members`
  ADD CONSTRAINT `fk_community_members_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`community_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_community_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contributor_profiles`
--
ALTER TABLE `contributor_profiles`
  ADD CONSTRAINT `fk_contributor_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `fk_conversations_user_one` FOREIGN KEY (`participant_one_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_conversations_user_two` FOREIGN KEY (`participant_two_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  ADD CONSTRAINT `fk_emergency_contacts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fleets`
--
ALTER TABLE `fleets`
  ADD CONSTRAINT `fk_fleets_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `fleet_assignments`
--
ALTER TABLE `fleet_assignments`
  ADD CONSTRAINT `fk_fa_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fa_fleet` FOREIGN KEY (`fleet_id`) REFERENCES `fleets` (`fleet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fa_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON UPDATE CASCADE;

--
-- Constraints for table `guardian_consents`
--
ALTER TABLE `guardian_consents`
  ADD CONSTRAINT `fk_guardian_minor_user` FOREIGN KEY (`minor_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guardian_verified_by` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `incident_reports`
--
ALTER TABLE `incident_reports`
  ADD CONSTRAINT `fk_incidents_admin` FOREIGN KEY (`assigned_admin`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_incidents_against` FOREIGN KEY (`reported_against`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_incidents_reporter` FOREIGN KEY (`reported_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_incidents_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_messages_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`conversation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_membership` FOREIGN KEY (`membership_id`) REFERENCES `user_memberships` (`membership_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  ADD CONSTRAINT `fk_reviews_reviewee` FOREIGN KEY (`reviewee_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_reviewer` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON UPDATE CASCADE;

--
-- Constraints for table `rides`
--
ALTER TABLE `rides`
  ADD CONSTRAINT `fk_rides_contributor` FOREIGN KEY (`contributor_id`) REFERENCES `contributor_profiles` (`contributor_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rides_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ride_bookings`
--
ALTER TABLE `ride_bookings`
  ADD CONSTRAINT `fk_bookings_request` FOREIGN KEY (`request_id`) REFERENCES `ride_requests` (`request_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bookings_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bookings_seeker` FOREIGN KEY (`seeker_id`) REFERENCES `seeker_profiles` (`seeker_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD CONSTRAINT `fk_requests_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_requests_seeker` FOREIGN KEY (`seeker_id`) REFERENCES `seeker_profiles` (`seeker_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ride_stops`
--
ALTER TABLE `ride_stops`
  ADD CONSTRAINT `fk_ride_stops_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ride_tracking`
--
ALTER TABLE `ride_tracking`
  ADD CONSTRAINT `fk_tracking_ride` FOREIGN KEY (`ride_id`) REFERENCES `rides` (`ride_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tracking_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `seeker_profiles`
--
ALTER TABLE `seeker_profiles`
  ADD CONSTRAINT `fk_seeker_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `fk_support_admin` FOREIGN KEY (`assigned_admin`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_support_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_documents`
--
ALTER TABLE `user_documents`
  ADD CONSTRAINT `fk_user_documents_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_documents_verifier` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD CONSTRAINT `fk_memberships_plan` FOREIGN KEY (`plan_id`) REFERENCES `membership_plans` (`plan_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_memberships_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `fk_vehicles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  ADD CONSTRAINT `fk_vehicle_doc_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vehicle_doc_verifier` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
