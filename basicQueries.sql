CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20)
);

SELECT name, major
FROM student; 

-- ORDER BY -- alphabetic order 
-- DESC make des. order 
SELECT student.name, student.major
FROM student
ORDER BY name DESC; 

SELECT *
FROM student
ORDER BY student_id ASC; 

SELECT *
FROM student
ORDER BY major, student_id; 


SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2;


-- FILTERING 

SELECT *
FROM student
WHERE major = 'Biology'; 


SELECT name, major
FROM student
WHERE major = 'Biology' OR major = 'Chemistry'; 

-- <, >, <=, >=, =, <>, AND, OR

SELECT name, major
FROM student
WHERE major <> 'Biology'; 


SELECT name, major
FROM student
WHERE student_id < 3; 

SELECT *
FROM student
WHERE name IN('Claire', 'Kate'); 