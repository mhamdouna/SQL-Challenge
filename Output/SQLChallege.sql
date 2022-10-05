--Drop all tables if they exist
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS departments CASCADE;


--Create Table "departments"
CREATE TABLE departments (
	dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(255) NOT NULL

);

--Create Table "titles"
CREATE TABLE titles (
	title_id VARCHAR(255) PRIMARY KEY NOT NULL,
	title VARCHAR(255) NOT NULL

); 

--Create Table "employees"
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(255) NOT NULL,
	birth_date VARCHAR(255) NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)

);

--Create Table "salaries"
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY NOT NULL,
	salary INT NOT NULL
	--FOREIGN KEY (emp_no) REFERENCES employees (emp_no)

);

--Create Table "dept_emp"
CREATE TABLE dept_emp (
	emp_no INT, dept_no VARCHAR(255),
	PRIMARY KEY (emp_no, dept_no), 
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)

);

--Create Table "dept_manager"
CREATE TABLE dept_manager (
	dept_no VARCHAR(255), emp_no INT, 
	PRIMARY KEY (dept_no, emp_no), 
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
	
);

-- Data Analysis__

--List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
JOIN salaries as s ON
e.emp_no = s.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date LIKE '%1986';


--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT dp.emp_no, e.last_name, e.first_name, dp.dept_no, d.dept_name
FROM dept_manager AS dp
JOIN departments AS d ON
dp.dept_no = d.dept_no
JOIN employees AS e ON
dp.emp_no = e.emp_no;


--List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e ON
de.emp_no = e.emp_no
JOIN departments AS d ON
de.dept_no = d.dept_no;


--List first name, last name, and sex of each employee whose first name is Hercules and 
--whose last name begins with the letter B
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name
SELECT de.emp_no, e.last_name, e.first_name
FROM dept_emp AS de 
JOIN employees AS e ON
de.emp_no = e.emp_no
WHERE de.dept_no = 'd007';


--List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e ON
de.emp_no = e.emp_no
JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE de.dept_no = 'd007' OR de.dept_no = 'd005';


--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name)
SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
