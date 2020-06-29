--CHALLENGE

--Deliverable 1: Number of Retiring Employees by Title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	sa.from_date,
	sa.salary
INTO silver_tsunami
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
INNER JOIN salaries as sa
ON e.emp_no = sa.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

SELECT * FROM silver_tsunami

-- Partition the data to show only most recent title per employee
SELECT emp_no,
first_name,
last_name,
title,
from_date,
salary
INTO new_retirees
FROM
 (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM silver_tsunami
 ) 
tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM new_retirees

-- Employee count by title
SELECT COUNT(ce.emp_no), ti.title
INTO emp_title_count
FROM current_emp as ce
LEFT JOIN titles as ti
ON ce.emp_no = ti.emp_no
GROUP BY ti.title
ORDER BY ti.title;

Select * from emp_title_count;

--Deliverable 2: Mentorship Eligibility

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	de.from_date,
	de.to_date
INTO mentorship
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM mentorship;

-- Partition the data to resolve duplicates

SELECT emp_no,
first_name,
last_name,
title,
from_date,
to_date
INTO elig_mentors
FROM
 (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentorship
 ) 
tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM elig_mentors;


-- Employee count by title
SELECT COUNT(ce.emp_no), ti.title
INTO emp_title_count
FROM current_emp as ce
LEFT JOIN titles as ti
ON ce.emp_no = ti.emp_no
GROUP BY ti.title
ORDER BY ti.title;

Select * from emp_title_count;






