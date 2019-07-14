CREATE DATABASE IF NOT EXISTS kudaki_event DEFAULT COLLATE = utf8_general_ci;
CREATE USER IF NOT EXISTS 'kudaki_event_repo' @'%' IDENTIFIED BY 'kudakieventreporocks';
GRANT ALL PRIVILEGES ON kudaki_event.* TO 'kudaki_event_repo' @'%' WITH GRANT OPTION;
USE kudaki_event;
CREATE TABLE IF NOT EXISTS kudaki_events (
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `organizer_user_uuid` VARCHAR(64) NOT NULL,
  `name` VARCHAR(255),
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `venue` VARCHAR(255),
  `description` TEXT,
  `ad_duration_from` BIGINT,
  `ad_duration` INT(20),
  `ad_duration_unit` ENUM('HOUR', 'DAY', 'WEEK', 'MONTH', 'YEAR'),
  `duration_from` BIGINT,
  `duration_to` BIGINT,
  `seen` INT(20),
  `status` ENUM('UNPUBLISHED', 'PUBLISHED', 'TAKEN_DOWN'),
  `created_at` BIGINT UNSIGNED,
  FULLTEXT(`name`, `description`, `venue`)
);
CREATE TABLE IF NOT EXISTS prices (
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `creator_user_uuid` VARCHAR(64) NOT NULL,
  `duration` BIGINT,
  `duration_unit` ENUM('HOUR', 'DAY', 'WEEK', 'MONTH', 'YEAR')
);
CREATE TABLE IF NOT EXISTS invoices (
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `kudaki_event_uuid` VARCHAR(64) NOT NULL,
  `price_uuid` VARCHAR(64) NOT NULL,
  `total_price` INT(20),
  `status` ENUM('UNPAID', 'PAID'),
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(kudaki_event_uuid) REFERENCES kudaki_events(uuid) ON DELETE CASCADE,
  FOREIGN KEY(price_uuid) REFERENCES prices(uuid)
);