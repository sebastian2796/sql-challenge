-- Drop tables if they exist (to avoid errors on rerun)
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;
 
-- Create departments table
-- Stores department information with a unique identifier
CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL,    -- Department number, using VARCHAR for alphanumeric codes
    dept_name VARCHAR(40) NOT NULL, -- Department name, changed from TEXT for better performance
    PRIMARY KEY (dept_no)          -- Set dept_no as primary key
);
 
-- Create titles table
-- Stores employee title information
CREATE TABLE titles (
    title_id VARCHAR(5) NOT NULL,   -- Title identifier
    title VARCHAR(50) NOT NULL,     -- Actual title name, changed from TEXT
    PRIMARY KEY (title_id)
);
 
-- Create employees table
-- Main employee information storage
CREATE TABLE employees (
    emp_no INT NOT NULL,            -- Employee number (unique identifier)
    emp_title_id VARCHAR(5) NOT NULL, -- Reference to titles table
    birth_date DATE NOT NULL,       -- Changed to DATE type for proper date handling
    first_name VARCHAR(50) NOT NULL, -- First name, changed from TEXT
    last_name VARCHAR(50) NOT NULL,  -- Last name, changed from TEXT
    sex CHAR(1) NOT NULL,           -- Changed to CHAR(1) as it's only 'M' or 'F'
    hire_date DATE NOT NULL,        -- Changed to DATE type
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
 
-- Create department employee junction table
-- Maps employees to departments (many-to-many relationship)
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,            -- Employee number
    dept_no VARCHAR(4) NOT NULL,    -- Department number
    PRIMARY KEY (emp_no, dept_no),  -- Composite primary key
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
 
-- Create department manager table
-- Tracks department managers
CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,    -- Department number
    emp_no INT NOT NULL,            -- Employee number (manager)
    PRIMARY KEY (emp_no),           -- Each manager manages one department
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
 
-- Create salaries table
-- Stores employee salary information
CREATE TABLE salaries (
    emp_no INT NOT NULL,            -- Employee number
    salary INT NOT NULL,            -- Annual salary
    PRIMARY KEY (emp_no),          -- One salary per employee
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
 
-- Import data from CSV files
-- Note: Update the file paths according to your system
COPY departments FROM 'data/departments.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM 'data/titles.csv' DELIMITER ',' CSV HEADER;
COPY employees FROM 'data/employees.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM 'data/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM 'data/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM 'data/salaries.csv' DELIMITER ',' CSV HEADER;