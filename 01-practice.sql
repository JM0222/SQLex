-- Q1
select first_name || ' ' || last_name as 이름,
    salary 월급, phone_number 전화번호, hire_date 입사일
from employees
order by hire_date;

-- Q2 
-- 업무별로 업무이름과 최고월급을 월급의 내림차순으로 정렬하세요.
select job_title, max_salary
from jobs
order by max_salary desc;

-- Q3
select first_name, manager_id, commission_pct, salary
from employees
where salary > 3000 and commission_pct is null and manager_id is not null;

-- Q4
--최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과
--최고월급(max_salary)을 최고 월급의 내림차순으로 정렬하여 출력하세요.
select job_title, max_salary
from jobs
where max_salary >= 10000
order by max_salary desc;

-- Q5
select first_name, salary, nvl(commission_pct,0)
from employees
where salary >= 10000 and salary < 14000
order by salary desc;

-- Q6
select first_name, salary, to_char(hire_date,'YYYY-MM'), department_id
from employees
where department_id in (10,90,100);

-- Q7
select first_name, salary
from employees
where first_name like '%S%' or first_name like '%s%';

-- Q8
select department_name
from departments
order by length(department_name) desc;

-- Q9
--정확하지 않지만 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
--올림차순으로 정렬해 보세요.
select initcap(country_id)
from locations
order by country_id;

-- Q10
select first_name, salary, replace(phone_number,'.','-')as phone_number, hire_date
from employees
where hire_date < '03/12/31';