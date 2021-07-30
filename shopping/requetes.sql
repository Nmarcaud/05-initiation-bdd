SELECT * FROM user WHERE firstname = 'Romain' AND age = 28;

-- tous les stocks avec prix supérieur à 35 et inférieur à 58
SELECT * FROM stock WHERE price > 35 AND price < 58;

-- moyenne des prix des aliments dispos
SELECT AVG(price) FROM stock WHERE quantity > 0;



-- nom des magasins , aliments et users
SELECT `name` FROM `store` UNION SELECT `name` FROM `food` UNION SELECT `firstname` FROM `user`;

-- liste des pays avec nbre utilisateurs
SELECT COUNT(`id`), `country` FROM `user` GROUP BY `country`;

-- aliment avec origine 
SELECT * FROM `food` WHERE `description` LIKE '%origine%' AND NOT `description` LIKE '%origine inconnue%';

-- commandes passées entre janv 2020 et dec 2020
SELECT * FROM `shopping_cart` WHERE `date` BETWEEN '2020-01-01' AND '2020-12-31';



-- JOINTURES
-- toutes les commandes passées par user exist avec nom et prénom user
SELECT sc.`id`, CONCAT(u.`lastname`, ' ' , u.`firstname`) AS `name` FROM `shopping_cart` AS sc INNER JOIN `user` AS u ON sc.`user_id`= u.`id` ORDER BY sc.`id`;

-- toutes les commandes passées même quand il n'y a pas d'utilisateur 
-- avec nom aliment, nom magasin et nom user
SELECT f.`name`, s.`name`, CONCAT(u.`lastname`, ' ' , u.`firstname`) AS `name` 
FROM `shopping_cart` AS sc 
LEFT JOIN `user` AS u ON sc.`user_id`= u.`id`
INNER JOIN `store` AS s ON sc.`store_id`= s.`id`
INNER JOIN `food` AS f ON sc.`food_id`= f.`id`;

-- toutes les commandes passées utilisateur français
SELECT CONCAT(u.`lastname`, ' ' , u.`firstname`) AS `name` 
FROM `shopping_cart` AS sc 
INNER JOIN `user` AS u ON sc.`user_id`= u.`id`
WHERE u.`country` = 'france'
ORDER BY sc.`id`;

-- Compteur max tous les magasins ont tous les produits
-- Ma solution
SELECT COUNT(*) FROM `store` CROSS JOIN `food`;
-- Solution de Nico BB avec une sous-requete
SELECT COUNT(*)
FROM (
    SELECT s.id as store_id, f.id as food_id
    FROM store as s
    CROSS JOIN food as f
) as cj;



-- liste des aliments à auchan
SELECT f.name, s.name
FROM `stock` AS stock
INNER JOIN `food` AS f ON stock.`food_id`= f.`id`
INNER JOIN `store` AS s ON stock.`store_id`= s.`id` WHERE s.`name` = 'Auchan';

-- somme des prix des commandes de l'utilisateur 2
SELECT SUM(sc.quantity * s.price) AS 'Somme user 2'
FROM `shopping_cart` AS sc
-- Bien prendre les 2 ids pour la clef primaire (sinon on ne sélectionne pas toujours le bon magasin)
INNER JOIN `stock` AS s ON sc.`food_id` = s.`food_id` AND sc.`store_id` = s.`store_id`
WHERE sc.`user_id` = 2;

-- liste des noms et prénoms des utilisateurs ayant dépenser plus de 30
SELECT CONCAT(u.`lastname`, ' ' , u.`firstname`) AS `name`, SUM(sc.quantity * s.price) AS 'somme'
FROM `shopping_cart` AS sc
LEFT JOIN `stock` AS s ON sc.`food_id` = s.`food_id` AND sc.`store_id` = s.`store_id`
INNER JOIN `user` AS u ON sc.`user_id` = u.`id`
GROUP BY u.`id`
HAVING SUM(sc.quantity * s.price) > 30;

-- 
SELECT *
FROM user
NATURAL JOIN account



-- SUPPRESSIONS

-- Supprimer les commandes de user non enregistré
DELETE FROM shopping_cart WHERE user_id IS NULL

-- Mettre à jour le prénom de l'utilisateur 2 Lucas -> Paul
UPDATE user SET firstname = "Paul" WHERE id = 2;

-- Mettre à jour la quantité de viande chez auchan à 60
UPDATE stock AS st
INNER JOIN food AS f ON f.id = st.food_id
INNER JOIN store AS s ON s.id = st.store_id
SET quantity = 60 
WHERE s.name = 'Auchan' 
AND f.name = 'Steack';

-- Faire en sorte que l'adresse d'un magasin ne soit pas obligatoire
ALTER TABLE `store` MODIFY `address` VARCHAR(100) NULL;

-- Ajouter une colonne sur table shopping_cart pour note
ALTER TABLE shopping_cart
ADD rating INT NULL;

-- mettre à jour toute les notes commandes pour les mettre à 10
UPDATE shopping_cart SET rating = 10;



-- Créer une transaction qui va créer une commande et retrirer l'équivalent des quantités dans le stock du magasin de manière atomique
START TRANSACTION;
    INSERT INTO shopping_cart (user_id, food_id, store_id, quantity, date) VALUES (5,6,1,4,NOW());
    UPDATE stock SET quantity = quantity - 4 WHERE food_id = 6 AND store_id = 1;
COMMIT;


-- créer une procédure pour lister les N dernières commandes
DELIMITER //
CREATE PROCEDURE list_commands(IN nombre_commandes INT)
BEGIN
    SELECT * FROM shopping_cart
    ORDER BY `date` DESC
    AND id DESC
    LIMIT nombre_commandes;
END //
DELIMITER ;
-- test
CALL list_commands(5);

-- pour drop une procédure : Drop Procedure YourProcedureName  


-- Créer une vue pour les stocks qui va ajouter un champ "total-value"
CREATE VIEW v AS
SELECT *, quantity * price AS total_value
FROM stock;
-- DROP VIEW v

-- Créer une vue des commandes contenant toutes les infos des tables liées (nom/prénom acheteur nom du magasin et nom aliment)
CREATE VIEW v_commandes AS
SELECT CONCAT(u.lastname, ' ', u.firstname) AS user_name, s.name AS store_name, f.name AS food_name
FROM shopping_cart AS sc
LEFT JOIN user AS u ON sc.user_id = u.id
INNER JOIN store AS s ON sc.store_id = s.id
INNER JOIN food AS f ON sc.food_id = f.id;
