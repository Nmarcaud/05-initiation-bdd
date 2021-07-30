-- Création de la bdd
DROP DATABASE IF EXISTS `blog`;
CREATE DATABASE IF NOT EXISTS `blog` DEFAULT CHARACTER SET utf8;

USE `blog`;

-- Tables Satellites
-- Création table Role
DROP TABLE IF EXISTS `blog`.`role`;
CREATE TABLE IF NOT EXISTS `blog`.`role` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `role` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Création table Catégorie
DROP TABLE IF EXISTS `blog`.`category`;
CREATE TABLE IF NOT EXISTS `blog`.`category` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Création table Status
DROP TABLE IF EXISTS `blog`.`status`;
CREATE TABLE IF NOT EXISTS `blog`.`status` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `status` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- Tables Principales
-- Création table User
DROP TABLE IF EXISTS `blog`.`user`;
CREATE TABLE IF NOT EXISTS `blog`.`user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `mail` VARCHAR(100) NOT NULL,
    `password` VARCHAR(45) NOT NULL,
    `ban` TINYINT NOT NULL DEFAULT 0,
    `role_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`role_id`) REFERENCES `role`(`id`)
) ENGINE = InnoDB;


-- Création table Article
DROP TABLE IF EXISTS `blog`.`article`;
CREATE TABLE IF NOT EXISTS `blog`.`article` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(250) NOT NULL,
    `slug` VARCHAR(250) NOT NULL,
    `text` TEXT NOT NULL,
    `created` DATETIME NOT NULL,
    `user_id` INT NOT NULL,
    `status_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`status_id`) REFERENCES `status`(`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Création table Comments
DROP TABLE IF EXISTS `blog`.`comments`;
CREATE TABLE IF NOT EXISTS `blog`.`comments` (
    -- Id car plusieurs comments possibles par user et par articles
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `article_id` INT NOT NULL,
    `comment` TEXT NOT NULL,
    `created` DATETIME NOT NULL,
    `status_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`status_id`) REFERENCES `status`(`id`)
) ENGINE = InnoDB;


-- Tables Relationnelles
-- Views
DROP TABLE IF EXISTS `blog`.`views`;
CREATE TABLE IF NOT EXISTS `blog`.`views` (
    -- Peut être null
    `id`INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NULL,             
    `article_id` INT NOT NULL,
    `created` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Likes
DROP TABLE IF EXISTS `blog`.`likes`;
CREATE TABLE IF NOT EXISTS `blog`.`likes` (
    `user_id` INT NOT NULL,             
    `article_id` INT NOT NULL,
    `created` DATETIME NOT NULL,
    PRIMARY KEY (`user_id`, `article_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Article category
DROP TABLE IF EXISTS `blog`.`article_category`;
CREATE TABLE IF NOT EXISTS `blog`.`article_category` (
    `article_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    PRIMARY KEY (`article_id`, `category_id`),
    FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB;



-- INSERTIONS 
-- Roles
INSERT INTO `role` (`role`) VALUES ('Écrivain');
INSERT INTO `role` (`role`) VALUES ('Administrateur');
INSERT INTO `role` (`role`) VALUES ('Nicolas');
INSERT INTO `role` (`role`) VALUES ('Président de la République');

-- Catégorie
INSERT INTO `category` (`name`) VALUES ('tech');
INSERT INTO `category` (`name`) VALUES ('health');
INSERT INTO `category` (`name`) VALUES ('forme');
INSERT INTO `category` (`name`) VALUES ('sport');
INSERT INTO `category` (`name`) VALUES ('food');
INSERT INTO `category` (`name`) VALUES ('sorties');
INSERT INTO `category` (`name`) VALUES ('top reactions');

-- Status
-- En attente
INSERT INTO `status` (`status`) VALUES ('Brouillon');
-- En ligne
INSERT INTO `status` (`status`) VALUES ('Publié');
-- Supprimé
INSERT INTO `status` (`status`) VALUES ('Archivé');



-- User
INSERT INTO `user` (`name`, `mail`, `password`, `role_id`)
VALUES ('Nicolas', 'nicolas@gmail.com', 'NicolasBoGoss37', 2);
INSERT INTO `user` (`name`, `mail`, `password`, `role_id`)
VALUES ('Alan', 'alan@gmail.com', 'AlanBoGoss37', 1);
INSERT INTO `user` (`name`, `mail`, `password`, `ban`,`role_id`)
VALUES ('Patrick', 'patou@gmail.com', 'OnAttendPasPatrick',1, 2);
INSERT INTO `user` (`name`, `mail`, `password`, `role_id`)
VALUES ('Baptiste', 'bapt@gmail.com', 'Baptman', 1);
INSERT INTO `user` (`name`, `mail`, `password`, `role_id`)
VALUES ('Manu', 'manu_macron@gmail.com', 'MacronFever', 4);


-- Articles
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un premier titre super génial Javascript', 'un-premier-titre-super-genial', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor nisi vitae arcu suscipit semper ac vulputate tellus. Nam vitae augue hendrerit, cursus sem in, vestibulum felis. Nam porttitor, turpis in tempor mattis, mi augue iaculis nulla, non vehicula nisl purus ac ex. Maecenas ut erat sit amet nulla consequat lacinia.',NOW(), 1, 2);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un second titre super génial', 'un-second-titre-super-genial', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor nisi vitae arcu suscipit semper ac vulputate tellus. Nam vitae augue hendrerit, cursus sem in, vestibulum felis. Nam porttitor, turpis in tempor mattis, mi augue iaculis nulla, non vehicula nisl purus ac ex. Maecenas ut erat sit amet nulla consequat lacinia.',NOW(), 2, 2);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un article archivé', 'un-article-archive', 'Phasellus aliquet mi sed sem faucibus volutpat. Fusce sed arcu rutrum, aliquet elit et, mattis mi. Cras ut sagittis neque. Integer sed justo sodales orci blandit convallis. Praesent imperdiet sodales turpis, ac pellentesque lorem pulvinar vitae. Maecenas pharetra lorem nulla, a condimentum nibh bibendum at. Aenean quam quam, luctus vitae lorem eget, porta sodales turpis. Suspendisse non mattis mauris. Nulla vel vehicula nunc, nec molestie tortor. Aliquam cursus ipsum at orci molestie, at viverra urna commodo.',NOW(), 3, 3);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un article brouillon', 'un-article-brouillon', 'Phasellus aliquet mi sed sem faucibus volutpat. Fusce sed arcu rutrum, aliquet elit et, mattis mi. Cras ut sagittis neque. Integer sed justo sodales orci blandit convallis. Praesent imperdiet sodales turpis, ac pellentesque lorem pulvinar vitae. Maecenas pharetra lorem nulla, a condimentum nibh bibendum at. Aenean quam quam, luctus vitae lorem eget, porta sodales turpis. Suspendisse non mattis mauris. Nulla vel vehicula nunc, nec molestie tortor. Aliquam cursus ipsum at orci molestie, at viverra urna commodo.',NOW(), 4, 1);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un second article brouillon', 'un-second-article-brouillon', 'Phasellus aliquet mi sed sem faucibus volutpat. Fusce sed arcu rutrum, aliquet elit et, mattis mi. Cras ut sagittis neque. Integer sed justo sodales orci blandit convallis. Praesent imperdiet sodales turpis, ac pellentesque lorem pulvinar vitae. Maecenas pharetra lorem nulla, a condimentum nibh bibendum at. Aenean quam quam, luctus vitae lorem eget, porta sodales turpis. Suspendisse non mattis mauris. Nulla vel vehicula nunc, nec molestie tortor. Aliquam cursus ipsum at orci molestie, at viverra urna commodo.',NOW(), 5, 1);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un article sans likes', 'un-second-article-brouillon', 'Phasellus aliquet mi sed sem faucibus volutpat. Fusce sed arcu rutrum, aliquet elit et, mattis mi. Cras ut sagittis neque. Integer sed justo sodales orci blandit convallis. Praesent imperdiet sodales turpis, ac pellentesque lorem pulvinar vitae. Maecenas pharetra lorem nulla, a condimentum nibh bibendum at. Aenean quam quam, luctus vitae lorem eget, porta sodales turpis. Suspendisse non mattis mauris. Nulla vel vehicula nunc, nec molestie tortor. Aliquam cursus ipsum at orci molestie, at viverra urna commodo.',NOW(), 5, 2);
INSERT INTO `article` (`title`, `slug`, `text`, `created`, `user_id`, `status_id`)
VALUES ('Un deuxième article sans likes', 'un-second-article-brouillon', 'Phasellus aliquet mi sed sem faucibus volutpat. Fusce sed arcu rutrum, aliquet elit et, mattis mi. Cras ut sagittis neque. Integer sed justo sodales orci blandit convallis. Praesent imperdiet sodales turpis, ac pellentesque lorem pulvinar vitae. Maecenas pharetra lorem nulla, a condimentum nibh bibendum at. Aenean quam quam, luctus vitae lorem eget, porta sodales turpis. Suspendisse non mattis mauris. Nulla vel vehicula nunc, nec molestie tortor. Aliquam cursus ipsum at orci molestie, at viverra urna commodo.',NOW(), 3, 2);

-- Comments
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (1, 1, 'Un premier commentaire sur le article 1 en brouillon', '2021-07-01 15:19:28', 1);
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (2, 1, 'Un second commentaire sur le article 1 en publié merde putain de bique', '2021-07-05 15:19:28', 2);
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (4, 2, 'Un premier commentaire sur le article 2 en publié', '2021-04-05 15:19:28', 2);
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (3, 2, 'Un second commentaire sur le article 2 en publié', '2021-06-05 15:19:28', 2);
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (5, 2, 'Un troisième commentaire sur le article 2 en archivé', '2021-07-20 15:19:28', 3);
INSERT INTO `comments` (`user_id`, `article_id`, `comment`, `created`, `status_id`)
VALUES (4, 3, 'Un autre commentaire sur le article 3 en publié', '2021-07-20 15:19:28', 2);


-- Views
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (1, 1, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (1, 2, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (1, 2, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (2, 1, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (2, 3, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (3, 1, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (3, 2, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (3, 3, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (4, 4, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (4, 5, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (5, 4, NOW());
INSERT INTO `views` (`user_id`, `article_id`, `created`) VALUES (5, 5, NOW());

-- Likes
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (1, 1, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (1, 2, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (1, 3, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (2, 1, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (2, 3, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (3, 1, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (3, 2, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (3, 3, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (4, 4, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (4, 5, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (5, 4, NOW());
INSERT INTO `likes` (`user_id`, `article_id`, `created`) VALUES (5, 5, NOW());

-- Article category
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (1,1);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (1,2);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (1,3);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (2,2);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (2,5);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (3,6);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (3,1);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (4,3);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (4,5);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,1);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,2);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,3);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,4);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,5);
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (5,6);


-- Ajout du point 5
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES (
    -- Select l'ID de l'article le plus liker
    (
    SELECT a.id
    FROM article AS a
    LEFT JOIN comments AS c ON a.id = c.article_id
    GROUP BY a.id 
    ORDER BY COUNT(c.id) DESC
    LIMIT 1
    )
,
    -- Select catégorie avec le nom Top Réaction
    (
    SELECT c.id
    FROM category AS c
    WHERE c.name LIKE '%Top reactions%'
    LIMIT 1
    )
);


-- ajout du point 10 
DROP PROCEDURE IF EXISTS delete_com;
DELIMITER //
CREATE PROCEDURE delete_com(IN `comment_id` INT, IN `user_id` INT)
BEGIN
    DELETE FROM comments
    WHERE comments.id = `comment_id` 
    AND `user_id` IN (
        SELECT id 
        FROM user AS u
        WHERE u.id = `user_id` 
        AND u.role_id = 2 
        AND u.ban = 0
    );
END //
DELIMITER ;