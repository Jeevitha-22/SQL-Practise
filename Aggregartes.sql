USE HR
--1)Display the maximum, minimum and average salary and commission earned.
select max(salary) as maximum_sal,min(salary) as min_sal,avg(salary) as avg_sal,
max(commission_pct) as maximum_cmn,min(commission_pct) as min_cmn,avg(commission_pct) as avg_cmn
from [dbo].[employees]


--2)Display the department number, total salary payout and total commission payout for each department.
select department_id, sum(salary) as tot_sal,sum(commission_pct) as tot_cmn from [dbo].[employees]
group by department_id

--3)Display the department number and number of employees in each department
select department_id,count(employee_id)as no_emp from [dbo].[employees]
group by department_id

--4)Display the department number and total salary of employees in each department.
select department_id,sum(salary) as tot_sal from [dbo].[employees]
group by department_id
--5)Display the employee’s name who doesn't earn a commission. 
--Order the result set without using the column name
select first_name,last_name from [dbo].[employees]
where commission_pct is null
order by 1
-- 6)Display the employees name, department id and commission. If an Employee doesn't 
--earn the commission, then display as 'No commission'. Name the columns appropriately
select first_name,last_name,department_id,
case 
when commission_pct is null then 'No Commission'
else 'commission'
end as commission
from [dbo].[employees]

--7)Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn 
--the commission, then display as 'No commission'. Name the columns appropriately
select first_name,last_name,salary,
case 
when commission_pct is null then 'No Commission'
else cast((commission_pct*2) as varchar)
end as new_commission
from [dbo].[employees]

--8)Display the employee's name, department id who have the first name same as another employee 
--in the same department 
select e.first_name,d.first_name,e.department_id
from  [dbo].[employees] e
join [dbo].[employees] d
on e.first_name=d.first_name and e.department_id=d.department_id and e.employee_id<>d.employee_id
group by e.first_name,d.first_name,e.department_id
order by  e.department_id


--9)Display the sum of salaries of the employees working under each Manager.

select mgr.manager_id , sum(emp.salary) as sal
from [dbo].[employees] emp
left join [dbo].[employees] mgr
on mgr.employee_id = emp.manager_id
where mgr.employee_id is not null
group by mgr.manager_id

--10)Select the Managers name, the count of employees working under and the department ID 
--of the manager.
SELECT m.employee_id as managerID,m.first_name,m.last_name,COUNT (e.employee_id) AS number_of_employees
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name,m.last_name;

--11)Select the employee name, department id, and the salary. 
--Group the result with the manager name and the employee last name should have second letter 'a'. 
select e.last_name as emp_lastname,e.department_id,e.salary,m.manager_id
from employees e
join employees m
on e.manager_id=m.employee_id
where e.last_name like '_a%'
group by e.department_id,e.salary,m.manager_id,e.last_name


--12)Display the average of sum of the salaries and group the result with the department id. 
--Order the result with the department id.
select avg(salary) as avg_salary,department_id from employees 
group by department_id
order by department_id

--13)Select the maximum salary of each department along with the department id
select max(salary)as max_sal,department_id from employees e
group by department_id

--14)Display the commission, if not null display 10% of salary, if null display a default value 1
select employee_id,
case 
when commission_pct is not null then (salary*0.1)
else 1
end as commission
from employees 






select * from [dbo].[employees]
order by manager_id
select * from [dbo].[departments]