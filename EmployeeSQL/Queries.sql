-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

Select * from titles

Select * from employees

Select * from dept_manager

Select * from dept_emp

Select * from departments

Select * from "Salaries"
Select COUNT(*) from "Salaries"
DELETE FROM "Salaries";

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e 
INNER JOIN "Salaries" AS s ON
e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT last_name, first_name, hire_date
FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dm.emp_no, dm.dept_no, dept.dept_name, e.last_name, e.first_name 
FROM dept_manager AS dm 
INNER JOIN departments AS dept ON
dm.dept_no = dept.dept_no
INNER JOIN employees AS e ON
dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, de.dept_no, dept.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS dept ON
dept.dept_no = de.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name, dept.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS dept ON
de.dept_no = dept.dept_no
WHERE de.dept_no = 'd007';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dept.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS dept ON
de.dept_no = dept.dept_no
WHERE de.dept_no = 'd007' OR de.dept_no = 'd005';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;