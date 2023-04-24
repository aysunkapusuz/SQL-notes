-- create employee table
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

-- create branch table
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);
-- add branch_id as a foreign key to the employee table
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

-- add super_id as a foreign key to the employee table
ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- create client table
CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- create works_with table
CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- create branch_supplier table
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);



-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);


-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- MORE BASIC QUERIES;

-- let's see the employee table 
SELECT * 
FROM employee;

-- and let's see all the clients
SELECT * 
FROM clients;

-- Find all employees ordered by salary(from the richest)
SELECT *
FROM employee
ORDER BY salary DESC;

-- Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- Find the first five employees in the table
SELECT *
FROM employee
LIMIT 5;

-- Find the first and last names of all employees
SELECT firts_name, last_name
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, employee.last_name AS surname
FROM employee;

--Find out all the different genders, distinct is usefull to find different values in a particular column
SELECT DISTINCT sex 
FROM employee;

-- IN OPERATOR
SELECT *
FROM employee
WHERE sex IN ('F', 'M')

-- FUNCTIONS 
-- find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1971-01-01';

-- find the average of all employees salaries
SELECT AVG(salary)
FROM employee;


-- find the average of all male employees salaries
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- female employees
SELECT AVG(salary)
FROM employee
WHERE NOT sex = 'M';

-- find the SUM of all employees salaries
SELECT SUM(salary)
FROM employee;

-- find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- find how much each client spent
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;



-- WILDCARDS
-- % = any # characters,  _ = one character

-- Find any client's who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE aupplier_name LIKE '% Label%';

-- Find any employee born in October
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';

-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- REGEXP 
SELECT *
FROM branch_supplier
-- WHERE applier_name LIKE '%Label%'
WHERE applier_name REGEXP 'Label'; -- same thing with line 242
-- applier name must start with label
WHERE applier_name REGEXP '^label';
-- applier name must end with label
WHERE applier_name REGEXP 'label$';
-- we can also use | to reperesent multipe patterns
WHERE applier_name REGEXP 'label|hey|yo';
-- ge ie me
WHERE applier_name REGEXP '[gim]e';
WHERE applier_name REGEXP '[a-h]e';


-- UNION 
-- union is a special SQL operator

-- find a list of employee and branch names
-- they have to have same number of column, simiar data types
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;
--

SELECT first_name AS company_names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

-- find a list of all clients and branch suppliers' names
SELECT client_name
FROM client 
UNION
SELECT supplier_name
FROM branch_supplier;

--
SELECT client_name, client.branch_id
FROM client 
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- JOINS
-- IT IS USED TO COMBINE ROWS FROM TWO OR MORE TABLES BASED ON A RELATED COLUMN BETWEEN THEM

--insert value into branch table
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);


-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch    -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;


SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch    -- ALL THE EMPLOYEES ARE ADDED
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch    -- ALL THE BRANCHES ADDED
ON employee.emp_id = branch.mgr_id;

-- NESTED QUERIES
-- Find names of all employees who have sold over 30,000 to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN(
                        SELECT works_with.emp_id
                        FROM works_with
                        WHERE works_with.total_sales > 30000
);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_name
FROM client
WHERE client.branch_id = (
                        SELECT branch.branch_id
                        FROM branch
                        WHERE branch.mgr_id = 102
                        LIMIT 1
);

-- ON DELETE
DELETE FROM employee
WHERE emp_id = 102;


-- TRIGGERS
CREATE TABLE trigger_test (
     message VARCHAR(100)
);

-- DELIMITER $$ -- CHANGE THE MYSQL DELIMITER 
-- CREATE
--     TRIGGER my_trigger BEFORE INSERT
--     ON employee
--     FOR EACH ROW BEGIN
--         INSERT INTO trigger_test VALUES('added new employee');
--     END$$
-- DELIMITER ;
-- INSERT INTO employee
-- VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;
-- 'added new employee' shows up

-- DELIMITER $$
-- CREATE
--     TRIGGER my_trigger BEFORE INSERT
--     ON employee
--     FOR EACH ROW BEGIN
--         INSERT INTO trigger_test VALUES(NEW.first_name);
--     END$$
-- DELIMITER ;
-- INSERT INTO employee
-- VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);
--name shows up

-- ELSE IF STATEMENT
-- DELIMITER $$
-- CREATE
--     TRIGGER my_trigger BEFORE INSERT    --AFTER, UPDATE, DELETE 
--     ON employee
--     FOR EACH ROW BEGIN
--          IF NEW.sex = 'M' THEN
--                INSERT INTO trigger_test VALUES('added male employee');
--          ELSEIF NEW.sex = 'F' THEN
--                INSERT INTO trigger_test VALUES('added female');
--          ELSE
--                INSERT INTO trigger_test VALUES('added other employee');
--          END IF;
--     END$$
-- DELIMITER ;
-- INSERT INTO employee
-- VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

