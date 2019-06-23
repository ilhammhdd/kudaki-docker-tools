CREATE DATABASE IF NOT EXISTS kudaki_rental DEFAULT COLLATE = utf8_general_ci;
CREATE USER IF NOT EXISTS 'kudaki_rental_repo' @'localhost' IDENTIFIED BY 'kudakirentalreporocks';
GRANT ALL PRIVILEGES ON kudaki_rental.* TO 'kudaki_rental_repo' @'localhost' WITH GRANT OPTION;
USE kudaki_rental;
CREATE TABLE IF NOT EXISTS carts(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL UNIQUE,
  `user_uuid` VARCHAR(255),
  `total_price` INT(20) UNSIGNED,
  `total_items` INT(20) UNSIGNED,
  `open` TINYINT(1),
  `created_at` BIGINT UNSIGNED
);
CREATE TABLE IF NOT EXISTS cart_items(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL UNIQUE,
  `cart_uuid` VARCHAR(255),
  `item_uuid` VARCHAR(255),
  `total_item` INT(20),
  `total_price` INT(20) UNSIGNED,
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(cart_uuid) REFERENCES carts(uuid) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS checkouts(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL UNIQUE,
  `cart_uuid` VARCHAR(255),
  `issued_at` DATETIME,
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(cart_uuid) REFERENCES carts(uuid) ON DELETE CASCADE
);
