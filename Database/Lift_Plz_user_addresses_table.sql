-- Lift Plz: user_addresses table
-- Stores residential, office, and other saved addresses for Seekers and Contributors.
-- Requires the existing `users` table in the `lift` database.

USE `lift`;

CREATE TABLE IF NOT EXISTS `user_addresses` (
    `address_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `address_type` ENUM('RESIDENTIAL', 'OFFICE', 'OTHER') NOT NULL DEFAULT 'RESIDENTIAL',
    `house_number` VARCHAR(100) DEFAULT NULL,
    `street` VARCHAR(200) DEFAULT NULL,
    `area` VARCHAR(150) DEFAULT NULL,
    `city` VARCHAR(100) NOT NULL,
    `district` VARCHAR(100) DEFAULT NULL,
    `state` VARCHAR(100) NOT NULL,
    `pincode` VARCHAR(10) NOT NULL,
    `landmark` VARCHAR(200) DEFAULT NULL,
    `latitude` DECIMAL(10,7) DEFAULT NULL,
    `longitude` DECIMAL(10,7) DEFAULT NULL,
    `is_default` TINYINT(1) NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`address_id`),
    KEY `idx_user_addresses_user` (`user_id`),
    KEY `idx_user_addresses_user_default` (`user_id`, `is_default`),
    CONSTRAINT `fk_user_addresses_user`
        FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
