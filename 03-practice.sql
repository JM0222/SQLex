-- Q1
select count(salary)
from employees
where salary < (select avg(salary) from employees);

-- Q2
select employee_id, first_name, salary, avgSalary, maxSalary
from employees emp, (select round(avg(salary)) avgSalary,max(salary) maxSalary
from employees) t
where emp.salary between t.avgSalary and t.maxSalary
order by salary;

-- Q3
--select department_id from employees where first_name ='Steven'
--and last_name = 'King';
--select location_id from departments where department_id = 90;
--select location_id, city from locations where location_id =1700;
select location_id, street_address, postal_code, city, 
state_province, country_id
from locations
where location_id = (select location_id from departments
                      where department_id = (select department_id
                               from employees where first_name = 'Steven'
                                and last_name = 'King'));

-- Q4
select employee_id, first_name, salary
from employees
where salary < all (select salary  from employees where job_id ='ST_MAN')
order by salary desc;

-- Q5
select employee_id, first_name, salary, department_id
from employees
where (department_id,salary) in (select department_id ,max(salary)
from employees group by department_id)
order by salary desc;

--case2
select employee_id, first_name, salary, department_id
from employees e
where e.salary = 
(select max(salary) from employees where department_id = e.department_id);

---- Q6
--select job_id, sum(salary) sumSalary
--from employees
--group by job_id;

select j.job_title, t.sumSalary, t.job_id, j.job_id
from jobs j,(select job_id, sum(salary) sumSalary
from employees
group by job_id) t
where j.job_id = t.job_id
order by sumSalary DESC;

-- Q7
select department_id, avg(salary) from employees
group by department_id;

select employee_id, first_name, emp.salary
from employees emp, (select department_id, avg(salary) salary from employees
                        group by department_id) t
where emp.department_id = t.department_id
and emp.salary > t.salary;

-- Q8
--select rownum, employee_id, first_name, salary, hire_date
--from (select employee_id, first_name, salary, hire_date from employees order by hire_date) rn
--where rownum <=15
--order by hire_date;

select rn, employee_id, first_name salary, hire_date from
(select rownum rn, employee_id, first_name, salary, hire_date from(
select employee_id, first_name, salary, hire_date from employees order by hire_date))
where rn between 11 and 15;
