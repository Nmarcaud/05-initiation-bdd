-- Création de la bdd
DROP DATABASE IF EXISTS `school`;
CREATE DATABASE IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8;

USE `school`;

-- Création table subjects
DROP TABLE IF EXISTS `school`.`subjects`;
CREATE TABLE IF NOT EXISTS `school`.`subjects` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Création table room
DROP TABLE IF EXISTS `school`.`room`;
CREATE TABLE IF NOT EXISTS `school`.`room` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `location` VARCHAR(45) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Création table Student
DROP TABLE IF EXISTS `school`.`student`;
CREATE TABLE IF NOT EXISTS `school`.`student` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(45) NOT NULL,
    `lastname` VARCHAR(45) NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Création table Teacher
DROP TABLE IF EXISTS `school`.`teacher`;
CREATE TABLE IF NOT EXISTS `school`.`teacher` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(45) NOT NULL,
    `lastname` VARCHAR(45) NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE = InnoDB;



DROP TABLE IF EXISTS `school`.`course`;
CREATE TABLE IF NOT EXISTS `school`.`course` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `subject_id` INT NOT NULL,
    `room_id` INT NOT NULL,
    `start_time` DATETIME NOT NULL,
    `end_time` DATETIME NOT NULL,
    `teacher_id` INT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`subject_id`) REFERENCES `subjects`(`id`),
    FOREIGN KEY (`room_id`) REFERENCES `room`(`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE = InnoDB;


DROP TABLE IF EXISTS `school`.`course_student`;
CREATE TABLE IF NOT EXISTS `school`.`course_student` (
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    -- Le couple de ces 2 clefs étrangères fait l'id primaire
    PRIMARY KEY (`student_id`, `course_id`),
    FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE = InnoDB;


