CREATE TABLE IF NOT EXISTS emp_manager (
emp_no INT(11) NOT NULL,
dept_no CHAR(4) NULL,
dept_name VARCHAR(20) NULL,
manager_no INT(11) NOT NULL
);


INSERT INTO emp_manager
SELECT
	U.*
FROM 
		(SELECT a.* from
			(SELECT 
				distinct e.emp_no Employee_ID
			,    MIN(d.dept_no) Department_Code
			,	d.dept_name Deparmtent_Name -- Code Enhancement on top of the main task
			,	(SELECT emp_no	FROM dept_manager WHERE	emp_no = 110022) Manager_ID
			FROM employees e
			JOIN dept_emp de ON e.emp_no = de.emp_no 
			JOIN departments d on d.dept_no = de.dept_no -- Code Enhancement on top of the main task
			WHERE e.emp_no <= 10020
			GROUP BY e.emp_no, d.dept_name -- Code Enhancement on top of the main task
			ORDER BY e.emp_no) a
		UNION
		SELECT b.* from
			(SELECT 
				e.emp_no Employee_ID
			,    MIN(de.dept_no) Department_Code
			,	d.dept_name Deparmtent_Name -- Code Enhancement on top of the main task
			,	(SELECT emp_no	FROM dept_manager WHERE	emp_no = 110039) Manager_ID
			FROM employees e
			JOIN dept_emp de ON e.emp_no = de.emp_no 
			JOIN departments d on d.dept_no = de.dept_no -- Code Enhancement on top of the main task
			WHERE e.emp_no > 10020 AND e.emp_no <= 10040
			GROUP BY e.emp_no, d.dept_name -- Code Enhancement on top of the main task
			ORDER BY e.emp_no
			LIMIT 20) b
		UNION
		SELECT c.* from
			(SELECT 
				e.emp_no Employee_ID
			,    MIN(de.dept_no) Department_Code
			,	d.dept_name Deparmtent_Name -- Code Enhancement on top of the main task
			,	(SELECT emp_no	FROM dept_manager WHERE	emp_no = 110039) Manager_ID
			FROM employees e
			JOIN dept_emp de ON e.emp_no = de.emp_no 
			JOIN departments d on d.dept_no = de.dept_no -- Code Enhancement on top of the main task
			WHERE e.emp_no = 110022
			GROUP BY e.emp_no, d.dept_name -- Code Enhancement on top of the main task
			ORDER BY e.emp_no
			LIMIT 20) c
		UNION
		SELECT d.* from
			(SELECT 
				e.emp_no Employee_ID
			,    MIN(de.dept_no) Department_Code
			,	d.dept_name Deparmtent_Name -- Code Enhancement on top of the main task
			,	(SELECT emp_no	FROM dept_manager WHERE	emp_no = 110022) Manager_ID
			FROM employees e
			JOIN dept_emp de ON e.emp_no = de.emp_no 
			JOIN departments d on d.dept_no = de.dept_no -- Code Enhancement on top of the main task
			WHERE e.emp_no = 110039
			GROUP BY e.emp_no, d.dept_name -- Code Enhancement on top of the main task
			ORDER BY e.emp_no
			LIMIT 20) d)
    U;
    
    -- Unfortunately, such solution has limitations.
    -- Despite supposed 42 rows the query returns 44 with 2 additionals rows with dept_no duplicates.alter
    -- The solution proposed by the task creator return the same numbers of rows
    -- The reason for that is because ,    MIN(de.dept_no) Department_Code query 
    -- that supposed to filter out duplicate dept_no values does not work as intended resulting in 2 extra records
    -- You can find evidence of that by analysing the "Creator's Solution query"
    -- Future investigation as well as solution search is required in order to correct this issue
    

