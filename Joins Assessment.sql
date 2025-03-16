-- 1. retrieve employee names and their department names using inner join
select e.employee_id, e.first_name, d.department_name
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id;

-- 2. retrieve all employees and their respective department names (including those without a department) using left join
select e.employee_id, e.first_name, d.department_name
from hr.employees e
left join hr.departments d on e.department_id = d.department_id;

-- 3. retrieve all departments and employees (including departments without employees) using right join
select e.employee_id, e.first_name, d.department_name
from hr.employees e
right join hr.departments d on e.department_id = d.department_id;

-- 4. retrieve all employees and their department names using full outer join
select e.employee_id, e.first_name, d.department_name
from hr.employees e
full outer join hr.departments d on e.department_id = d.department_id;

-- 5. retrieve employees who do not belong to any department using left join with null check
select e.employee_id, e.first_name
from hr.employees e
left join hr.departments d on e.department_id = d.department_id
where d.department_id is null;

-- 6. retrieve departments that have no employees using right join with null check
select d.department_id, d.department_name
from hr.employees e
right join hr.departments d on e.department_id = d.department_id
where e.employee_id is null;

-- 7. retrieve employees along with their manager names using self join
select e.employee_id, e.first_name, m.first_name as manager_name
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

-- 8. retrieve employees along with their job title using inner join
select e.employee_id, e.first_name, j.job_title
from hr.employees e
inner join hr.jobs j on e.job_id = j.job_id;

-- 9. retrieve employees along with the location of their department using inner join
select e.employee_id, e.first_name, d.department_name, l.city
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id
inner join hr.locations l on d.location_id = l.location_id;

-- 10. retrieve employees and the projects they are assigned to using inner join
select e.employee_id, e.first_name, p.name
from hr.employees e
inner join projects.projects p on e.employee_id = p.id;

-- 11. retrieve employees who have not been assigned to any project using left join
select e.employee_id, e.first_name
from hr.employees e
left join projects.projects p on e.employee_id = p.id
where p.id is null;

-- 12. retrieve project names along with the department handling them using inner join
select p.name, d.department_name
from projects.projects p
inner join hr.departments d on p.id = d.department_id;

-- 13. retrieve employees along with the names of their training programs using inner join
-- select e.employee_id, e.first_name, t.training_name
-- from hr.employees e
-- inner join training_programs t on e.training_id = t.training_id;

-- 14. retrieve employees who have not attended any training programs using left join
-- select e.employee_id, e.first_name
-- from employees e
-- left join training_programs t on e.training_id = t.training_id
-- where t.training_id is null;

-- 15. retrieve employee names and their assigned shifts using inner join
-- select e.employee_id, e.first_name, s.shift_timing
-- from employees e
-- inner join shifts s on e.shift_id = s.shift_id;

-- 16. retrieve employees who do not have an assigned shift using left join
-- select e.employee_id, e.first_name
-- from employees e
-- left join shifts s on e.shift_id = s.shift_id
-- where s.shift_id is null;

-- 17. retrieve employees, their department names, and their assigned project names using multiple inner joins
select e.employee_id, e.first_name, d.department_name, p.name
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id
inner join projects.projects p on e.employee_id = p.id;

-- 18. retrieve employees who have worked on more than one project using inner join and group by
select e.employee_id, e.first_name, count(p.id) as project_count
from hr.employees e
inner join projects.projects p on e.employee_id = p.id
group by e.employee_id, e.first_name
having count(p.id) > 1;

-- 19. retrieve employees along with their salaries and their department budget using inner join
-- select e.employee_id, e.first_name, e.salary, d.budget
-- from hr.employees e
-- inner join hr.departments d on e.department_id = d.department_id;

-- 20. retrieve employees who earn more than their department’s average salary using inner join and a subquery
select e.employee_id, e.first_name, e.salary
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id
where e.salary > (select avg(salary) from hr.employees where department_id = e.department_id);

-- 21. retrieve employees who have the same job role as another employee using self join
select e1.employee_id, e1.first_name, e2.first_name as coworker_name, e1.job_id
from hr.employees e1
inner join hr.employees e2 on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id;

-- 22. retrieve employees and their department names, but show "not assigned" if an employee has no department using left join and coalesce
select e.employee_id, e.first_name, coalesce(d.department_name, 'not assigned') as department_name
from hr.employees e
left join hr.departments d on e.department_id = d.department_id;

-- 23. retrieve employees and their assigned projects, including employees who are not assigned to any project using full outer join
select e.employee_id, e.first_name, p.name
from hr.employees e
full outer join projects.projects p on e.employee_id = p.id;

-- 24. retrieve employees who work in a city where their department is located using inner join
select e.employee_id, e.first_name, l.city
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id
inner join hr.locations l on d.location_id = l.location_id;

-- 25. retrieve employees and their total bonus amount using inner join with a bonus table
-- select e.employee_id, e.first_name, sum(b.bonus_amount) as total_bonus
-- from hr.employees e
-- inner join hr.bonuses b on e.employee_id = b.employee_id
-- group by e.employee_id, e.first_name;

-- 26. retrieve employees who do not have any recorded bonuses using left join
-- select e.employee_id, e.first_name
-- from hr.employees e
-- left join bonuses b on e.employee_id = b.employee_id
-- where b.bonus_amount is null;

-- 27. retrieve employees and their department names where employees belong to a specific region using inner join
-- select e.employee_id, e.first_name, d.department_name, r.region_name
-- from hr.employees e
-- inner join hr.departments d on e.department_id = d.department_id
-- inner join hr.locations l on d.location_id = l.location_id
-- inner join hr.regions r on l.region_id = r.region_id;

-- 28. retrieve employees and their project details, even if they are not assigned to a project using left join
select e.employee_id, e.first_name, p.name
from hr.employees e
left join projects.projects p on e.employee_id = p.id;

-- 29. retrieve departments and the count of employees in each department using inner join and group by
select d.department_id, d.department_name, count(e.employee_id) as employee_count
from hr.departments d
left join hr.employees e on d.department_id = e.department_id
group by d.department_id, d.department_name;

-- 30. retrieve employees who work on projects located in a different city than their department using inner join
select e.employee_id, e.first_name, d.department_name, p.name, l.city as project_city
from hr.employees e
inner join projects.projects p on e.employee_id = p.id
inner join hr.departments d on e.department_id = d.department_id
inner join hr.locations l on p.id = l.location_id
where d.location_id <> p.id;
