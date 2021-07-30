
-- Création de la bdd
DROP DATABASE IF EXISTS `shopping`;
CREATE DATABASE IF NOT EXISTS `shopping` DEFAULT CHARACTER SET utf8;

USE `shopping`;

-- Création table user
DROP TABLE IF EXISTS `shopping`.`user`;
CREATE TABLE IF NOT EXISTS `shopping`.`user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(45) NOT NULL,
    `lastname` VARCHAR(45) NOT NULL,
    `age` INT NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `shopping`.`food`;
CREATE TABLE IF NOT EXISTS `shopping`.`food` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `description` TEXT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `shopping`.`store`;
CREATE TABLE IF NOT EXISTS `shopping`.`store` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `address` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `shopping`.`stock`;
CREATE TABLE IF NOT EXISTS `shopping`.`stock` (
    `food_id` INT NOT NULL,
    `store_id` INT NOT NULL,
    `quantity` INT NULL,
    `price` DECIMAL,
    -- Le couple de ces 2 clefs étrangères fait l'id primaire
    PRIMARY KEY (`store_id`, `food_id`),
    FOREIGN KEY (`food_id`) REFERENCES `food`(`id`),
    FOREIGN KEY (`store_id`) REFERENCES `store`(`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `shopping`.`shopping_cart`;
CREATE TABLE IF NOT EXISTS `shopping`.`shopping_cart` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `food_id` INT NOT NULL,
    `store_id` INT NOT NULL,
    `quantity` INT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
    FOREIGN KEY (`food_id`) REFERENCES `food` (`id`),
    FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE = InnoDB;