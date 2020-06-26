-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

SELECT * FROM departments;

Copy departments FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/departments.csv' DELIMITER ',' CSV HEADER;


-- Creating table for Employees
CREATE TABLE employees (
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

SELECT * FROM employees;

Copy employees FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/employees.csv' DELIMITER ',' CSV HEADER;


-- Creating table for Department Managers
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_manager;

Copy dept_manager FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/dept_manager.csv' DELIMITER ',' CSV HEADER;

-- Creating table for Salaries
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

SELECT * FROM salaries;

Copy salaries FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/salaries.csv' DELIMITER ',' CSV HEADER;


DROP TABLE employees CASCADE;

DROP TABLE dept_emp CASCADE;

-- Creating table for Department Employees
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_emp;

Copy dept_emp FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/dept_emp.csv' DELIMITER ',' CSV HEADER;

-- Creating table for Titles
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM titles;


Copy titles FROM '/Users/argecardenas/Public/Analysis_Projects/Pewlett-Hackard-Analysis/Data/titles.csv' DELIMITER ',' CSV HEADER;