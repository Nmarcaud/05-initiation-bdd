DROP DATABASE IF EXISTS `school`;
CREATE DATABASE `school` DEFAULT CHARACTER SET utf8;
USE `school`;
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `location` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(30) NOT NULL,
    `lastname` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(30) NOT NULL,
    `lastname` VARCHAR(30) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB;
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `subject_id` INT NOT NULL,
    `room_id` INT NOT NULL,
    `teacher_id` INT NOT NULL,
    `start_time` DATETIME NOT NULL,
    `end_time` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
    FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
)ENGINE = InnoDB;
DROP TABLE IF EXISTS `course_student`;
CREATE TABLE `course_student`(
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    PRIMARY KEY (`student_id`, `course_id`),
    FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
    FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE = InnoDB;



-- INSERT DATA
-- SUBJECT
INSERT `subject` (id, name) 
VALUES (1, 'French');
INSERT `subject` (id,name) 
VALUES (2, 'English');
INSERT `subject` (id,name) 
VALUES (3, 'Maths');
INSERT `subject` (id,name) 
VALUES (4, 'Geo');

INSERT `room` (id, name, location) 
VALUES (1, 'R011', 'Floor1');
INSERT `room` (id, name, location) 
VALUES (2, 'R021','Floor2');
INSERT `room` (id, name, location) 
VALUES (3, 'R022','Floor2');

INSERT `student` (id, firstname,lastname) 
VALUES (1, 'Bruno','Salomone');
INSERT `student` (id, firstname,lastname) 
VALUES (2, 'Jean','Dujardin');
INSERT `student` (id, firstname,lastname) 
VALUES (3, 'Albert','Sorelle');

INSERT `teacher` (id, firstname,lastname) 
VALUES (1, 'Alan','Salomone');
INSERT `teacher` (id, firstname,lastname) 
VALUES (2, 'Stephen','Dujardin');
INSERT `teacher` (id, firstname,lastname) 
VALUES (3, 'Maxime','Viel');

INSERT `course` (subject_id,room_id,start_time,end_time,teacher_id) 
VALUES (1,1,'2021-02-02 08:59:59.99','2021-02-02 10:59:59.99',1);
INSERT `course` (subject_id,room_id,start_time,end_time,teacher_id) 
VALUES (2,2,'2021-02-03 10:59:59.99','2021-02-03 14:59:59.99',2);

INSERT `course_student` (student_id,course_id) 
VALUES (1,1);
INSERT `course_student` (student_id,course_id) 
VALUES (1,2);
INSERT `course_student` (student_id,course_id) 
VALUES (2,1);
INSERT `course_student` (student_id,course_id) 
VALUES (2,2);

