-- 6. Assign a rank to employees based on their salary within each department.
select department_id, employee_id, salary,
rank() over (PARTITION by department_id order by salary DESC) as salary_rank
from hr.employees;

-- 7. Find the top 3 highest-paid employees in each department.
SELECT department_id, employee_id, salary, salary_rank
from(
    select department_id, employee_id, salary,
    rank() over(PARTITION by department_id order by salary desc) as salary_rank
    from hr.employees
)where salary_rank <= 3;

-- 8. Identify the second highest salary in each department using DENSE_RANK().
select department_id, employee_id, salary, salary_rank
from (
    select department_id, employee_id, salary,
    DENSE_RANK() over(PARTITION by department_id order by salary DESC) as salary_rank
    from hr.employees
)WHERE salary_rank = 2;

-- 9. Compute the cumulative total salary of employees ordered by hire date.
select department_id, hire_date, salary,
    sum(salary) over(order by hire_date) as cumulative_salary
    from hr.employees;

-- 10. Assign a row number to each employee in each department.
select department_id, employee_id, 
ROW_NUMBER() over(PARTITION by department_id ORDER by hire_date) as row_num
from hr.EMPLOYEES;

-- 11. Find the salary difference between each employee and the next highest-paid employee.
select EMPLOYEE_ID, salary,
lead(salary) over(order by salary desc) - salary as salary_diff
from hr.employees;

-- 12. Calculate the previous month’s salary for each employee using LAG().
select EMPLOYEE_ID, salary, HIRE_DATE,
lag(salary) over(partition by employee_id order by HIRE_DATE) as prev_salary
from hr.employees;

-- 13. Identify employees whose salaries increased over time.
select employee_id, hire_date, salary, 
LAG(salary) OVER (PARTITION by employee_id ORDER BY hire_date) AS prev_salary,
case when salary > LAG(salary) OVER (PARTITION BY employee_id ORDER BY hire_date) 
then 'Increased' ELSE 'Decreased' END AS salary_trend
from HR.employees;
