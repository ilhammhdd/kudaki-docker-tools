CREATE DATABASE IF NOT EXISTS kudaki_order DEFAULT COLLATE = utf8_general_ci;
CREATE USER IF NOT EXISTS 'kudaki_order_repo' @'%' IDENTIFIED BY 'kudakiorderreporocks';
GRANT ALL PRIVILEGES ON kudaki_order.* TO 'kudaki_order_repo' @'%' WITH GRANT OPTION;
USE kudaki_order;
CREATE TABLE IF NOT EXISTS orders (
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `cart_uuid` VARCHAR(64) NOT NULL,
  `tenant_uuid` VARCHAR(64) NOT NULL,
  `order_num` VARCHAR(255),
  `status` ENUM(
    'PENDING',
    'APPROVED',
    'DISAPPROVED',
    'RENTED',
    'DONE'
  ),
  `shipment_fee` INT(20),
  `delivered` TINYINT(1),
  `created_at` BIGINT UNSIGNED
);
CREATE TABLE IF NOT EXISTS item_feedbacks(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `order_uuid` VARCHAR(64) NOT NULL,
  `rating` DECIMAL(4, 3),
  `description` TEXT,
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(order_uuid) REFERENCES orders(uuid) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS owner_feedbacks(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `user_uuid` VARCHAR(64) NOT NULL,
  `order_uuid` VARCHAR(64) NOT NULL,
  `rating` DECIMAL(4, 3),
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(order_uuid) REFERENCES orders(uuid) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS kudaki_order.owner_orders(
  `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uuid` VARCHAR(64) NOT NULL UNIQUE,
  `order_uuid` VARCHAR(64) NOT NULL,
  `owner_uuid` VARCHAR(64) NOT NULL,
  `total_price` INT(20),
  `total_quantity` INT(20),
  `status` ENUM(
    'PENDING',
    'APPROVED',
    'DISAPPROVED',
    'RENTED',
    'DONE'
  ),
  `created_at` BIGINT UNSIGNED,
  FOREIGN KEY(order_uuid) REFERENCES orders(uuid) ON DELETE CASCADE
);