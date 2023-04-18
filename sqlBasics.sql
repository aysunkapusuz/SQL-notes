-- SQL is a language udes for interacting with Relational Database Management Systems
-- You can use SQL to get the RDBMS to do things for you:
-- Create, retrieve, update and delete data
-- Create and managge databases
-- Design and create databease tables 
-- Perform administration tasks (security, user management etc.)

-- SQL implementations vary between systems
-- Not all RDBMS' follow the SQL standard to a 'T' 
-- The conceopts are the same but the implementation may vary


-- SQL is actually a hybrid language, it's basically 4 types of languages in one
-- Data Query Language(DQL)
-- Data Definition Language(DDL)
-- Data Control Language(DCL)
-- Data Manipulation Language(DML)


-- Queries
-- A query is a set of intructions given to the RDBMS that tell the RDBMS what information you want it to retrieve for you
-- Tons of data in a DB
-- Often hidden in a complex schema
-- Goal is to only get the data you need

SELECT employee.name, employee.age
FROM employee
WHERE employee.salary > 3000;