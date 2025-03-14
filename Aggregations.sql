-- 1. Count the number of employees in each department
-- finding the number of emp based on department
select department_id, COUNT(*) as total_employees
from HR.employees
group by department_id;

-- 2. Find the average salary in each department
-- finding the average of salary based on department
select department_id, avg(salary) as avg_salary
from hr.EMPLOYEES
group by DEPARTMENT_ID;

-- 3. Find the maximum and minimum salary in each department
-- finding the  max_number and min_number of salary based on department
select department_id, min(salary) as min_salary, max(salary) as max_salary
from hr.EMPLOYEES
group by DEPARTMENT_ID;

-- 4. Find the total salary paid in each department
-- finding the tot_number of salary paid by emp based on department
select department_id, sum(salary) as total_salary
from hr.EMPLOYEES
group by DEPARTMENT_ID;

-- 5. Count the number of employees in each job role
-- finding the number of emp based on job roles
select job_id, count(*) as total_employees
from hr.EMPLOYEES
group by job_id;

-- 6. Find the average salary for each job role
-- finding the average salary of emp based on job roles
select job_id, avg(salary) as avg_salary 
from hr.EMPLOYEES
group by job_id;

-- 7. Find the maximum salary for each job role
-- finding the max_number of salary based on job roles
select job_id, max(salary) as max_salary
from hr.EMPLOYEES
group by job_id;

-- 8. Find the minimum salary for each job role
-- finding the min_number of salary based on job roles
select job_id, MIN(salary) as min_salary
from hr.employees
group by job_id;

-- 9. Find the total salary paid for each job role
-- finding the total of salary paid by emp based on job roles
select job_id, sum(salary) AS total_salary
from hr.EMPLOYEES
group by JOB_ID;

-- 10. Count the number of employees hired in each year
-- finding the number of emp hired in each year using extract operator
select EXTRACT(year from hire_date) as  hire_year, count(*) as total_employees
from hr.EMPLOYEES
group by EXTRACT(year from HIRE_DATE)
order by hire_year;

-- 11. Find the total salary paid in each location
-- finding the total_number of salary paid by emp based on location using join operator to combine both table and fetch output
select d.location_id, sum(e.salary) as total_salary
from hr.EMPLOYEES e
join hr.departments d on e.department_id = d.department_id
group by d.location_id;

-- 12. Find the number of employees in each manager's team
-- finding the number of emp based on manager_id
select manager_id, count(*) as team_size
from hr.EMPLOYEES
where MANAGER_ID is not null 
group by manager_id;

-- 13. Find the highest salary for each manager
-- finding the highest salary of emp based on manager_id
select manager_id, max(salary) as max_salary
from hr.EMPLOYEES
where MANAGER_ID is not null 
group by MANAGER_ID;

-- 14. Find the average salary for each manager's team
-- finding the average salary of emp based on manager_id
select manager_id, avg(salary) as avg_salary
from hr.EMPLOYEES
where manager_id is not NULL
group by manager_id;

-- 15. Count the number of employees hired in each month of the year
-- finding the number of emp hires based on each month using extraxt operator
select extract(MONTH from HIRE_DATE) as hire_month, count(*) as total_hired
from hr.EMPLOYEES
group by EXTRACT(MONTH from HIRE_DATE)
order by hire_month;

-- 16. Find the department with the highest total salary
-- finding the highest total salary based on department and to fetch the highest one salary
select department_id, sum(salary) as  total_salary
from hr.employees
group by department_id
order by total_salary DESC
fetch first 1 row only;

-- 17. Find the job role with the highest average salary
-- finding the highest average salary based on job roles and to fetch the highest one salary
select job_id, avg(salary) as avg_salary
from  hr.EMPLOYEES
group by job_id
order by avg_salary DESC
fetch first 1 row only;

-- 18. Find the number of employees in each city
-- finding the number_emp based on city and to used join function to fetch the result
select l.city, count(*) as total_employees
from hr.EMPLOYEES e
join hr.departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
join HR.locations l on d.LOCATION_ID = l.location_id
group by l.city;

-- 19. Find the number of employees who have a commission, grouped by department
-- finding the number of emp based on commission and grouping by department
select department_id, COUNT(*) as employees_with_commission
from hr.EMPLOYEES
where COMMISSION_PCT is not NULL
group by DEPARTMENT_ID;

-- 20. Find the sum of salaries for employees who have a commission, grouped by department
-- finding the highest total salary based on commission and grouping by dept
select department_id, sum(salary) as total_salary_with_commission
from hr.EMPLOYEES
where COMMISSION_PCT is not null
group by DEPARTMENT_ID;

-- # Oracle SQL Aggregation Questions for Sales History Table

-- 1. Count the number of sales transactions for each product. 
select prod_id, count(*) a