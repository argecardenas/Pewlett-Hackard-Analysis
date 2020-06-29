## Challenge

-- Number of [titles] retiring
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO ret_titles
FROM current_emp as ce
	INNER JOIN titles as ti
		ON (ce.emp_no = ti.emp_no)
ORDER BY ce.emp_no;

SELECT * FROM ret_titles;
ORDER BY ret_titles.emp_no;

--Partition the data to show most recent titles
SELECT emp_no,
	first_name,
	last_name, 
	to_date,
	title
INTO unique_titles
FROM (
	SELECT emp_no,
		first_name,
		last_name,
		to_date,
		title, ROW_NUMBER() OVER
		(PARTITION BY (emp_no)
		ORDER BY to_date DESC) rn
		FROM ret_titles
		) tmp WHERE rn = 1 
ORDER BY emp_no;

SELECT * FROM unique_titles;

-- Counting the number of employees per title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

SELECT * FROM retiring_titles; 

-- Total of 33118 employees retiring--

-- Creating a list of employees eligible for mentorship program
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentors_prog
FROM employees as e
INNER JOIN dept_emp as de

SELECT * FROM mentors_prog;

-- Filter duplicates 
SELECT emp_no,
first_name,
last_name,
title,
from_date,
to_date
INTO mentors_p
FROM
 (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentors_prog
 ) 
tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM mentors_p;