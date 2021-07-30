-- JOINTURES

-- liste des différentes matières
SELECT `name` FROM `subject`;

-- liste des matières enseignées par enseignant 2
SELECT s.name 
FROM `teacher` AS t
LEFT JOIN `course`AS c ON t.id = c.teacher_id
INNER JOIN `subject`AS s ON s.id = c.subject_id
WHERE t.id = 2;

-- Nombre de cours ou bruno participe
SELECT s.firstname, COUNT(cs.course_id)
FROM `student` AS s
LEFT JOIN `course_student` AS cs ON cs.student_id = s.id
WHERE s.firstname = 'Bruno'
GROUP BY s.id;

--date du dernier cours le l’etudiant 2
SELECT c.id, c.end_time
FROM `course` AS c
LEFT JOIN `course_student` AS cs ON c.id = cs.course_id
WHERE cs.student_id = 2 
ORDER BY end_time DESC
LIMIT 1;

--trier les matieres par le plus grand nombre d’étudiant
SELECT s.name, count(cs.student_id)
FROM `subject`AS s
INNER JOIN `course` AS c ON c.subject_id = s.id
INNER JOIN `course_student`AS cs ON cs.course_id = c.id
GROUP BY s.name
ORDER BY count(cs.student_id) DESC;

--nom des profs qui n’ont aucun cours
SELECT CONCAT(t.`lastname`, ' ' , t.`firstname`) AS `name`, subject_id
FROM `teacher` AS t 
LEFT JOIN `course` AS c ON t.id = c.teacher_id
WHERE c.teacher_id IS NULL;



-- modifier nom prof Dujardin en Dujardin-Lamy
UPDATE teacher SET lastname = "Dujardin-Lamy" WHERE lastname = "Dujardin" ;

-- faire en sorte qu'un cours puisse se passer sans professeur
ALTER TABLE `course` MODIFY `teacher_id` INT(11) NULL;

-- nom de la salle id 3 "esxtérieur" en nom et Exceptionnel en location
UPDATE room SET name = "Extérieur", location = "Excetpionnel" WHERE id = 3;

-- + cours "minute de silence" 0 prof et salle 3
INSERT INTO subject (`name`) VALUES ('Minute de Silence');
INSERT INTO course (`subject_id`, `room_id`, `start_time`, `end_time`) VALUES (5,3,'2020-07-23 10:00:00','2020-07-23 11:00:00');

-- y insérer les 2 premier élèves avec les id
INSERT INTO course_student (`student_id`, `course_id`) VALUES (1,3),(2,3);

-- faire en sorte de pouvoir supprimer les élèves et que cela supprime les incricptions associées
-- Droper la foreign key d'abord
ALTER TABLE `course_student` DROP FOREIGN KEY course_student_ibfk_1;
-- puis la recréer
ALTER TABLE `course_student` 
ADD CONSTRAINT course_student_ibfk_1 
FOREIGN KEY (student_id) 
REFERENCES `student` (`id`) 
ON DELETE CASCADE;
-- Test
DELETE FROM student WHERE id = 3;




