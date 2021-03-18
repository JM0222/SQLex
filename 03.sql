--ROLL UP
--  group by 절과 함께 사용, 결과에 좀더 상세한 요약을 제공
select department_id, job_id, sum(salary)
from employees
group by department_id, job_id
order by department_id;

select department_id, job_id, sum(salary)
from employees
group by rollup(department_id, job_id);

-- CUBE 함수
-- crossTable 에대한 Summary 함께 제공(Roll up에 부가적으로 column까지)
select department_id, job_id, sum(salary)
from employees
group by cube(department_id, job_id)
order by department_id;

-- SUBQUERY
-- 하나의 sql 질의문속에 다른 sql 질의문이 포함되어있는 형태
-- subquery의 결과가 single-row 일경우 Operator (=, >...)사용가능
select first_name, salary 
from employees
where salary  >= (select salary
                from employees
                where first_name ='Den'); -- salary 11000 이상

select first_name, salary
from employees
where salary >(select median(salary)
                from employees);

--subquery의 결과가 multi-row 일경우 (any, all, in , exist)
select first_name, salary
from employees
where salary IN
(select salary from employees where department_id = 110);               

--Correlated Query
-- outer query 와 inner query가 연관되어있는경우 
select first_name, salary, department_id
from employees outer
where salary > (select avg(salary) from employees
                where department_id = outer.department_id);

-- Top-k Query
-- 조건을 만족하는 query 상위 빠르게 얻어오기
select rownum, first_name, salary
from (select * from employees
        where hire_date like '07%'
        order by salary desc)
where rownum <=5;

-- SET
-- UNION(합집합: 중복제거) UNION ALL (중복제거X)
-- INTERSECT(교집합), MINUS(차집합)
select first_name, salary, hire_date from employees where hire_date < '05/01/01' 
intersect
select first_name, salary, hire_date from employees where salary > 12000;

select first_name, salary, hire_date from employees where hire_date < '05/01/01' 
minus
select first_name, salary, hire_date from employees where salary > 12000;

-- RANK 함수
select salary, first_name,
    Rank() over (order by salary desc) as rank,-- 중복된 순위 건너뛰고
    DENSE_RANK() over (order by salary desc) as dense_rank, -- 중복순위
    row_number() over (order by salary desc) as row_number, -- 순서대로
    ROWNUM -- 정렬되기 이전의 레코드 순서
from employees;

-- Hierarchical Query : 트리 형태의 구조를 추출
-- ROOT 노드: 조건 START WITH
-- 가지: 연결조건 CONNECT BY PRIOR
-- level(깊이) 라는 가상 컬럼을 사용할수 있다.

select level, first_name
from employees
start with manager_id is null -- root 노드의 조건
connect by prior employee_id = manager_id
order by level;