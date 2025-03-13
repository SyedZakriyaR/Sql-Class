-- 1. Find the top 3 highest-paid employees in each job category using ROW_NUMBER()
SELECT EMPLOYEE_ID, JOB_ID, SALARY, ROW_NUMBER() OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC) AS rn
FROM EMPLOYEES
WHERE rn <= 3;

-- 2. Rank employees within their department by hire date using RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, HIRE_DATE, RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE) AS hire_rank
FROM EMPLOYEES;

-- 3. Identify the second-highest salary in each department using DENSE_RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY,
    DENSE_RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank
    FROM EMPLOYEES
) WHERE salary_rank = 2;

-- 4. Find employees who have the same salary rank within their department using RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank
FROM EMPLOYEES;

-- 5. Return only the employees with the lowest salary in each department using ROW_NUMBER()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    ROW_NUMBER() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC) AS rn
    FROM EMPLOYEES
) WHERE rn = 1;

-- 6. Display the cumulative salary rankings for all employees using DENSE_RANK()
SELECT EMPLOYEE_ID, SALARY, DENSE_RANK() OVER (ORDER BY SALARY DESC) AS salary_rank
FROM EMPLOYEES;

-- 7. List the employees who fall within the top 5 salaries per department using RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank
    FROM EMPLOYEES
) WHERE salary_rank <= 5;

-- 8. Find the employee with the third-highest salary in the company using ROW_NUMBER()
SELECT EMPLOYEE_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, SALARY, 
    ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS rn
    FROM EMPLOYEES
) WHERE rn = 3;

-- 9. Retrieve the most recent hire in each department using ROW_NUMBER()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, HIRE_DATE
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, HIRE_DATE, 
    ROW_NUMBER() OVER (PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE DESC) AS rn
    FROM EMPLOYEES
) WHERE rn = 1;

-- 10. Find employees ranked first in terms of salary across all departments using RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    RANK() OVER (ORDER BY SALARY DESC) AS salary_rank
    FROM EMPLOYEES
) WHERE salary_rank = 1;

-- 11. Rank employees by salary and reset the rank after each department using DENSE_RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    DENSE_RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank
FROM EMPLOYEES;

-- 12. List the top 2 earners from each department using ROW_NUMBER()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    ROW_NUMBER() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS rn
    FROM EMPLOYEES
) WHERE rn <= 2;

-- 13. Return all employees whose salary ranks in the top 10% within their department using RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank,
    COUNT(*) OVER (PARTITION BY DEPARTMENT_ID) AS total_employees
    FROM EMPLOYEES
) WHERE salary_rank <= total_employees * 0.1;

-- 14. Find employees with the same salary rank across different departments using DENSE_RANK()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    DENSE_RANK() OVER (ORDER BY SALARY DESC) AS salary_rank
FROM EMPLOYEES;

-- 15. Find the highest-paid employee in each job category using RANK()
SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, JOB_ID, SALARY, 
    RANK() OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC) AS salary_rank
    FROM EMPLOYEES
) WHERE salary_rank = 1;

-- LEAD() and LAG() Questions

-- 16. Use LAG() to find the salary difference between the current employee and the previous one within each department
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    SALARY - LAG(SALARY) OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS salary_diff
FROM EMPLOYEES;

-- 17. Retrieve each employee's salary and the next employee's salary in the same department using LEAD()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    LEAD(SALARY) OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS next_salary
FROM EMPLOYEES;

-- 18. Calculate the percentage change in salary between the current employee and the previous one using LAG()
SELECT EMPLOYEE_ID, SALARY,
    (SALARY - LAG(SALARY) OVER (ORDER BY SALARY)) / LAG(SALARY) OVER (ORDER BY SALARY) * 100 AS salary_change
FROM EMPLOYEES;

-- 19. Find the hire date of the employee who was hired immediately before each employee using LAG()
SELECT EMPLOYEE_ID, HIRE_DATE, 
    LAG(HIRE_DATE) OVER (ORDER BY HIRE_DATE) AS prev_hire_date
FROM EMPLOYEES;

-- 20. Identify employees whose salary is lower than the next employee’s salary in their department using LEAD()
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM (
    SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY, 
    LEAD(SALARY) OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS next_salary
    FROM EMPLOYEES
) WHERE SALARY < next_salary;