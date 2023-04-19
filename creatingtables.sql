-- DATA TYPES 
-- INT              -whoe numbers
-- DECIMAL(M,N)     -decimal numbers - exact value
-- VARCHAR(1)       -string of text of length 1
-- BLOB             -Binary large object, stores large data
-- DATE             -'YYYY-MM-DD'
-- TIMESTAMP        -'YYYY-MM-DD HH:MM:SS' -used for recording 

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20)
);


-- CREATE TABLE student (
--     student_id INT,
--     name VARCHAR(20),
--     major VARCHAR(20),
--     PRIMARY KEY(student_id)
-- ); 

-- describe a table 
-- DESCRIBE student;  

-- delete a table 
-- DROP TABLE student;


-- modify the table
-- ALTER TABLE student ADD gpa DECIMAL(3,2);     (Aadds a column)

-- you can also drop column
-- ALTER TABLE student DROP COLUMN gpa;


-- INSERTING DATA 
SELECT * FROM student;
INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student(student_id, name) VALUES(2, 'Sierra'); /* major is NULL */


-- NOT NULL AND UNIQUE 
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20) UNIQUE
);
-- DEFAULT
CREATE TABLE student (
    student_id INT,
    name VARCHAR(20) ,
    major VARCHAR(20) DEFAULT 'undecided'
);
-- AUTO_INCREMENT
CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'undecided'
);
SELECT * FROM student;
INSERT INTO student(name, major) VALUES('Jack', 'Biology');
INSERT INTO student(name, major) VALUES('Sierra', 'Math');

-- UPDATE AND DELETE 

UPDATE student
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student
SET major = 'Bio'
WHERE student_id = 4;

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

UPDATE student
SET name = 'Tom', major = 'undecided'
WHERE student_id = 2;

-- all majors will be undecided
UPDATE student
SET major = 'undecided';


DELETE FROM student
WHERE student_id = 5;


DELETE FROM student
WHERE name = 'Tom' AND major = 'undecided';

-- delete everything 
DELETE FROM student;

