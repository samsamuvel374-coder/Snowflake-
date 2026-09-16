-- ============================================================================
-- SQL TUTORIAL & PRACTICE SCRIPT
-- Compatible with: PostgreSQL, Snowflake, MySQL, and SQLite
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. DATABASE OBJECT CREATION (DDL)
-- ----------------------------------------------------------------------------

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ----------------------------------------------------------------------------
-- 2. DATA INSERTION (DML)
-- ----------------------------------------------------------------------------

INSERT INTO departments (department_id, department_name, location) VALUES
(101, 'Engineering', 'New York'),
(102, 'Sales', 'Chicago'),
(103, 'Marketing', 'San Francisco'),
(104, 'Human Resources', 'New York');

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_title, salary, department_id) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '2021-03-15', 'Software Engineer', 95000.00, 101),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '2019-07-22', 'Engineering Manager', 130000.00, 101),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com', '2020-11-01', 'Sales Executive', 65000.00, 102),
(4, 'Diana', 'Prince', 'diana.prince@example.com', '2022-01-10', 'Sales Representative', 55000.00, 102),
(5, 'Evan', 'Wright', 'evan.wright@example.com', '2018-05-19', 'Marketing Lead', 88000.00, 103),
(6, 'Fiona', 'Gallagher', 'fiona.g@example.com', '2023-04-01', 'HR Specialist', 60000.00, 104);

-- ----------------------------------------------------------------------------
-- 3. CORE QUERIES (SELECT, WHERE, ORDER BY, GROUP BY)
-- ----------------------------------------------------------------------------

-- Simple Filter and Sort
SELECT first_name, last_name, salary, hire_date
FROM employees
WHERE salary > 60000.00
ORDER BY salary DESC;

-- Aggregation by Department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    AVG(e.salary) AS average_salary,
    MAX(e.salary) AS highest_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 0;

-- ----------------------------------------------------------------------------
-- 4. ADVANCED QUERIES (WINDOW FUNCTIONS & DATA UPDATES)
-- ----------------------------------------------------------------------------

-- Rank Employees by Salary within Each Department
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Update Record
UPDATE employees
SET salary = 98000.00
WHERE employee_id = 1;

-- Delete Record
DELETE FROM employees
WHERE employee_id = 6;

-- Verify Final Dataset
SELECT * FROM employees;
