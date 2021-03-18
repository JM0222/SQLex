--Q1
select employee_id, first_name, last_name, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id 
order by department_name, employee_id desc;

--Q2
select employee_id, first_name, salary, department_name,job_title
from employees emp, departments dept, jobs jb
where emp.department_id = dept.department_id and 
emp.job_id = jb.job_id
order by employee_id;

--Q2-1
select employee_id, first_name, salary, department_name,job_title
from employees emp, departments dept, jobs jb
where emp.department_id = dept.department_id(+) and 
emp.job_id = jb.job_id
order by employee_id;

--Q3
select lc.location_id, city, dp.department_name, dp.department_id
from locations lc, departments dp
where lc.location_id = dp.location_id
order by city;
--Q3-1
select lc.location_id, city, dp.department_name, dp.department_id
from locations lc left outer join departments dp
on lc.location_id = dp.location_id
order by city;

--Q4
--select * from countries;
--select * from regions;
select region_name, country_name
from regions rg, countries ct
where rg.region_id = ct.region_id
order by region_name, country_name desc;

--Q5
select ep2.employee_id, ep2.first_name, ep2.hire_date, ep2.first_name 매니저
from employees ep, employees ep2 
where ep.manager_id = ep2.employee_id
and ep.hire_date > ep2.hire_date;

--Q6
select ct.country_name, ct.country_id, lc.city, lc.location_id,
dp.department_name, dp.department_id
from countries ct, locations lc, departments dp
where ct.country_id = lc.country_id and dp.location_id = lc.location_id
order by department_name;

--Q7
select ep.employee_id, ep.first_name || ' ' || ep.last_name as "NAME",
ep.employee_id,jh.start_date, jh.end_date
from job_history jh, employees ep
where jh.job_id = 'AC_ACCOUNT' and jh.employee_id = ep.employee_id;

--Q8
select dept.department_id, dept.department_name,
    man.first_name,
    loc.city,
    c.country_name,
    reg.region_name
from departments dept, locations loc, employees man, countries c, regions reg
where dept.manager_id = man.employee_id
and dept.location_id = loc.location_id
and loc.country_id = c.country_id
and c.region_id = reg.region_id;

--Q9
select emp.employee_id, emp.first_name, dept.department_name,
man.first_name
from employees emp , employees man, departments dept
where emp.department_id = dept.department_id(+)
and emp.manager_id = man.employee_id;