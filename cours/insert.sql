-- Insertion de données dans notre bdd
-- subjects
INSERT INTO subjects (`name`) VALUES ('French');
INSERT INTO subjects (`name`) VALUES ('English');
INSERT INTO subjects (`name`) VALUES ('Maths');
INSERT INTO subjects (`name`) VALUES ('Physique');

-- room
INSERT INTO room (`location`, `name`) VALUES ('Floor 1', 'R001');
INSERT INTO room (`location`, `name`) VALUES ('Floor 1', 'R002');
INSERT INTO room (`location`, `name`) VALUES ('Floor 2', 'R101');
INSERT INTO room (`location`, `name`) VALUES ('Floor 2', 'R102');

-- student
INSERT INTO student (`firstname`, `lastname`) VALUES ('Bruno', 'Batman');
INSERT INTO student (`firstname`, `lastname`) VALUES ('Jean', 'Superman');
INSERT INTO student (`firstname`, `lastname`) VALUES ('Louis', 'Iron Man');
INSERT INTO student (`firstname`, `lastname`) VALUES ('Rachid', 'Indestructible');

-- student
INSERT INTO teacher (`firstname`, `lastname`) VALUES ('Alan', 'Turing');
INSERT INTO teacher (`firstname`, `lastname`) VALUES ('Stephen', 'Hawking');
INSERT INTO teacher (`firstname`, `lastname`) VALUES ('Thomas', 'Edison');
INSERT INTO teacher (`firstname`, `lastname`) VALUES ('Nicolas', 'Tesla');


-- course
INSERT INTO course (`subject_id`, `room_id`, `start_time`, `end_time`, `teacher_id`) VALUES (1,1,'2020-07-23 10:00:00','2020-07-23 11:00:00',1);
INSERT INTO course (`subject_id`, `room_id`, `start_time`, `end_time`, `teacher_id`) VALUES (2,3,'2020-07-23 11:00:00','2020-07-23 13:00:00',4);
INSERT INTO course (`subject_id`, `room_id`, `start_time`, `end_time`, `teacher_id`) VALUES (3,2,'2020-07-23 09:00:00','2020-07-23 11:00:00',3);
INSERT INTO course (`subject_id`, `room_id`, `start_time`, `end_time`, `teacher_id`) VALUES (4,4,'2020-07-23 09:00:00','2020-07-23 12:00:00',2);

-- course_student
INSERT INTO course_student (`student_id`, `course_id`) VALUES (1,1);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (1,2);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (1,4);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (2,2);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (2,3);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (2,4);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (3,1);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (3,4);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (4,1);
INSERT INTO course_student (`student_id`, `course_id`) VALUES (4,2);