-- 1. Compter l’ensemble des articles publiés depuis la création du blog
SELECT COUNT(*) FROM article;

-- 2. Lister la totalité des articles (actuellement en ligne) écrits par des utilisateurs non-bannis.
SELECT a.*
FROM `article` AS a
LEFT JOIN `user` AS u ON a.user_id = u.id
WHERE u.ban = 0;

-- 3. Rechercher un article dont le nom contient “Javascript” et présent dans la catégorie “Tech”
SELECT *
FROM `article` AS a 
LEFT JOIN `article_category` AS ac ON a.id = ac.article_id
LEFT JOIN `category` AS cat ON cat.id = ac.category_id
WHERE a.title LIKE '%Javascript%'
AND cat.name  LIKE '%Tech%'
LIMIT 1;

-- 4. Trouver les 3 articles les plus “likés”
SELECT a.*, COUNT(l.article_id)
FROM `article` AS a 
LEFT JOIN `likes` AS l ON l.article_id = a.id
GROUP BY a.id
LIMIT 3;


-- 5. Ajouté la catégorie “Top reactions” à l’article ayant le plus de commentaires
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


-- 6. Trier les utilisateurs par la date de leur dernier commentaire
SELECT u.name, MAX(c.created)
FROM user AS u
LEFT JOIN comments AS c ON c.user_id = u.id
GROUP BY u.id
ORDER BY MAX(c.created) DESC;


-- 7. Supprimer les articles ayant été lus 0 fois
DELETE FROM `article`
WHERE article.id IN (
    SELECT * FROM (
        SELECT a.id
        FROM `article` AS a 
        LEFT JOIN `views` AS v ON v.article_id = a.id
        GROUP BY a.id
        HAVING COUNT(v.article_id) = 0
    ) AS ids
);


-- Help
/*
DELETE FROM posts WHERE id IN (
    SELECT * FROM (
        SELECT id FROM posts GROUP BY id HAVING ( COUNT(id) > 1 )
    ) AS p
)*/


-- 8. Bannir l’utilisateur ayant écrit un commentaire contenant le mot “merde”
UPDATE user
SET ban = TRUE
WHERE id IN
    (
    SELECT * FROM
        (
        SELECT u.id
        FROM user AS u
        INNER JOIN comments AS c ON u.id = c.user_id
        WHERE c.comment LIKE '%merde%'
        ) AS id
    );


-- 9. Supprimer les utilisateurs ayant été bannis
DELETE FROM user
WHERE ban IS TRUE;

-- 10. Faire en sorte que la suppression d’un commentaire soit faite par un admin, et non pas par un utilisateur classique
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

-- Toolkit
DROP PROCEDURE delete_com;
CALL delete_com(5,1);

-- 11. Créer une visualisation de la liste des articles avec un maximum d’infos intéressantes (nom/prénom de l’auteur, nombre de vues, nombre de likes, nombre de commentaires , nom des catégories,...)
CREATE VIEW v AS
SELECT 
    a.id, 
    a.title,
    u.name AS writer, 
    COUNT(DISTINCT v.id) AS vues, 
    COUNT(DISTINCT l.article_id, l.user_id) AS likes, 
    COUNT(DISTINCT c.id) AS comments,
    GROUP_CONCAT(DISTINCT cat.name SEPARATOR ' ') AS categories
FROM `article` AS a 
LEFT JOIN `user` AS u ON u.id = a.user_id
LEFT JOIN `views` AS v ON v.article_id = a.id
LEFT JOIN `comments` AS c ON c.article_id = a.id
LEFT JOIN `likes` AS l ON l.article_id = a.id
LEFT JOIN `article_category` AS ac ON ac.article_id = a.id 
LEFT JOIN `category` AS cat ON cat.id = ac.category_id
GROUP BY a.id;
