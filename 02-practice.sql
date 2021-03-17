--Q1
select count(manager_id) as haveMngCnt from employees;
--Q2
select max(salary) as "최고임금",min(salary) as "최저임금",
(max(salary)-min(salary)) as "두 금액의 차"
from employees;
--Q3
select max(hire_date) from employees;
--Q4
select department_id, round(avg(salary)),max(salary),min(salary)
from employees
group by department_id
order by department_id;
--Q5
select job_id, round(avg(salary),0), max(salary), min(salary)
from employees
group by job_id
order by min(salary) desc, avg(salary) asc;
--Q6
select to_char(min(hire_date),'YYYY-MM-DD-DY') from employees;
--Q7
select department_id,round(avg(salary)), min(salary),round(avg(salary)-min(salary))
from employees
group by department_id
having round(avg(salary)-min(salary)) < 2000
order by round(avg(salary)-min(salary));
--Q8
select job_id, (max(max_salary)-min(min_salary)) as "차"
from jobs
group by job_id
order by 차 desc;
--Q9
select manager_id, round(avg(salary)),max(salary),min(salary)
from employees
where hire_date >= '05/01/01'
group by manager_id
having avg(salary) > 5000
order by round(avg(salary),2);
--Q10
SELECT  employee_id,
        salary,
        CASE WHEN hire_date <= '02/12/31' THEN '창립맴버'
             WHEN hire_date BETWEEN '03/01/01' and '03/12/31' THEN '03년'
             WHEN hire_date BETWEEN '04/01/01' and '04/12/31' THEN '04년'
             ELSE '상장이후'
        END optDate,
        hire_date
FROM employees
order by hire_date asc;