select * from employees where year(hire_date) = 2000 order by first_name ;

select * from employees;
select * from salaries;
select * from dept_emp;

select e.gender, avg(s.salary), d.dept_name from salaries s
join employees e on e.emp_no = s.emp_no
join dept_emp de on de.emp_no = e.emp_no
join departments d on de.dept_no = d.dept_no
group by e.gender, d.dept_name;



Drop procedure if exists last_dept;

DELIMITER $$
CREATE PROCEDURE last_dept (IN p_emp_no INTEGER)
BEGIN
SELECT 
e.emp_no, d.dept_no, d.dept_name
FROM employees e 
join dept_emp de on e.emp_no = de.emp_no 
join departments d on de.dept_no = d.dept_no
where e.emp_no = p_emp_no
and de.from_date = ( select max(from_date) from dept_emp where emp_no = p_emp_no);
end$$
delimiter ;


set @p_emp_no = null;
call last_dept(10100);
select @p_emp_no

DELIMITER $$
CREATE TRIGGER check_employee_hire_date
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > sysdate() THEN
		SET NEW.hire_date = sysdate();
        END IF;
END$$
DELIMITER ;

SELECT * FROM EMPLOYEES WHERE emp_no = 10001;

update employees set hire_date = '1986-06-26' where emp_no = 10001
	
