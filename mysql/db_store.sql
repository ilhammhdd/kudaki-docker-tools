CREATE DATABASE IF NOT EXISTS kudaki_store DEFAULT COLLATE = utf8_general_ci;
CREATE USER IF NOT EXISTS 'kudaki_store_repo' @'localhost' IDENTIFIED BY 'kudakistorereporocks';
GRANT ALL PRIVILEGES ON kudaki_store.* TO 'kudaki_store_repo' @'localhost' WITH GRANT OPTION;
USE kudaki_store;
CREATE TABLE IF NOT EXISTS storefronts(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `user_uuid` VARCHAR(64),
  `total_item` INT(20),
  `rating` DECIMAL(4, 3),
  `created_at` BIGINT UNSIGNED
);
CREATE TABLE IF NOT EXISTS items(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `storefront_uuid` VARCHAR(64),
  `name` VARCHAR(255),
  `amount` INT(20),
  `unit` VARCHAR(255),
  `price` INT(20),
  `description` TEXT,
  `photo` VARCHAR(255),
  `rating` DECIMAL(4, 3),
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(storefront_uuid) REFERENCES storefronts(uuid) ON DELETE CASCADE
);
