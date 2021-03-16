-- 현재 계정내에 어떤 테이블이 있는가?
select * from tab;

-- 테이블 구조확인(desc)
describe employees;

select salary as 봉급, first_name as 이름
from employees;

desc departments;

-- Example

select first_name, phone_number, hire_date, salary
from employees;

select first_name, last_name, phone_number, hire_date
from employees;

-- 필드명 대신에 연산식 가능 dual << 가상테이블( 간단한 계산시 이용 )
--select 300 * 2000 from dual;
select first_name, salary * 12 as 연봉 from employees;

-- NVL(expr1, expr2) expr1 null 이면 expr2 출력
-- null 일경우 0으로 replace
select first_name, salary, salary + (salary * nvl(commission_pct, 0))
from employees;

-- 문자열의 연결 (||)
select first_name || ' ' || last_name as name
from employees;

-- where example
select first_name, salary, salary *12 as 연봉
from employees
where salary >= 15000;

select first_name, hire_date
from employees
where hire_date >= '07/01/01';

select department_id, salary * 12 , hire_date
from employees
where first_name = 'Lex';

select *
from employees
where department_id = 10;

-- Like
--am 포함한 모든 사원들
select first_name
from employees
where first_name like '%am%';
-- 두번째 문자가 a인 모든 사원들
select first_name
from employees
where first_name like '_a%';

select first_name, salary
from employees
where department_id = 90 and salary >= 20000; 

-- Between
select first_name, salary
from employees
where salary between
14000 and 17000;

-- IN  
select first_name, salary
from employees
where first_name in('Lex', 'John');

select * from employees
where department_id in (10, 20, 40);

select * from employees
where manager_id in(100,120,147);

-- IS NULL
select first_name, commission_pct from employees
where commission_pct is null;

select first_name, commission_pct from employees
where commission_pct is not null;

-- ORDER BY   (ASC(default),DESC)
select first_name, department_id, salary
from employees
order by department_id;

select first_name || ' ' || last_name as name
from employees
order by salary desc;

select department_id, salary, first_name || ' ' || last_name as name
from employees
order by department_id, salary desc;

----------
-- 단일행 함수
-- 개별 레코드에 적용되는 함수
----------

-- 문자열 단일행 함수
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) name,
    INITCAP(first_name || ' ' || last_name) name2, -- 각 단어의 첫글자를 대문자로
    LOWER(first_name), -- 전부 소문자
    UPPER(first_name), -- 전부 대문자
    LPAD(first_name, 10, '*'), -- 10글자 출력 크기, 빈자리에 * 채움
    RPAD(first_name, 10, '*')
FROM employees;

-- first_name에 am이 포함된 사원의 이름 출력
SELECT first_name FROM employees
WHERE first_name LIKE '%am%';
    
SELECT first_name FROM employees;

--  Upper, Lower는 대소문자 구분 없이 검색할 때 유용
SELECT first_name FROM employees
WHERE lower(first_name) LIKE '%am%';

-- 정제
SELECT '  Oracle  ', '*****Database*****'
FROM dual;

SELECT LTRIM('  Oracle  '), --  왼쪽에 있는 빈 공간을 지워줌
    RTRIM('  Oracle  '),    -- 오른쪽에 있는 공백을 지워줌
    TRIM('*' FROM '*****Database*****'), -- 문자열 내에서 특정 문자를 제거
    SUBSTR('Oracle Database', 8, 8), -- 문자열에서 8번째 글자부터 8문자를 추출
    SUBSTR('Oracle Database', -8, 8) -- 뒤에서부터 8번째 글자부터 8문자를 추출
FROM dual;

-- 수치형 단일행 함수
SELECT ABS(-3.14),  -- 절대값
    CEIL(3.14), --  올림(천장)
    FLOOR(3.14), -- 내림(바닥)
    Floor(7 / 3),    -- 몫
    MOD(7, 3),  -- 나눗셈의 나머지
    POWER(2, 4),    -- 제곱: 2의 4제곱
    ROUND(3.5),     -- 소숫점 첫째자리 반올림
    ROUND(3.5678, 2),   -- 소숫점 둘째자리까지 표시, 소숫점 3째 자리에서 반올림
    TRUNC(3.5),     --  소숫점 버림
    TRUNC(3.5678, 2), -- 소숫점 둘째자리까지 표시
    SIGN(-10)   -- 부호 함수(음수: -1, 0, 양수:1)
FROM dual;

-- 날짜형 단일행 함수
SELECT sysdate FROM dual;   --  시스템 가상 테이블 -> 1개

SELECT sysdate FROM employees;  --  테이블 내의 레코드 갯수만큼 출력

SELECT sysdate, -- 시스템 날짜
    ADD_MONTHS(sysdate, 2), -- 오늘부터 2개월 후
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'), sysdate),   -- 개월 차
    ROUND(sysdate, 'MONTH'),    --  날짜 반올림
    TRUNC(sysdate, 'MONTH')
FROM dual;

-- employees 사원들의 입사한지 얼마나 지났는지
SELECT first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date), 1) as months
FROM employees;

----------
-- 변환함수
----------

/*
TO_CHAR(o, fmt): Number or Date -> Varchar
TO_NUMBER(s, fmt): Varchar -> Number
TO_DATE(s, fmt): Varchar -> Date
*/

select to_number('$1,500,500.90', '$999,999,999.99') from dual;

select to_date('2021-03-16 15:07','YYYY-MM-DD HH24:MI') 
from dual;

/*
날짜 연산
-- Date +(-) Number: 날짜에 일수를 더하거나 뺸다 -> Date
-- Date - Date : 두 날짜 사이의 일수
-- Date + Number / 24 : 날짜에 시간을 더하거나 뺄 경우
*/

select to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
to_char(sysdate - 8, 'YYYY-MM-DD HH24:MI') as "8일전",
to_char(sysdate + 8, 'YYYY-MM-DD HH24:MI') as "8일후",
sysdate - to_date('1999-12-31', 'YYYY-MM-DD') as "1999/12/31/이후",
to_char(sysdate + 12/24,'YYYY-MM-DD HH24:MI') --현재 시간으로부터 12시간 이후
from dual;

-- NUll 관련

select first_name,
    salary,
                                  -- null 이 아니면    -null 이면
    nvl2(salary * commission_pct, salary *commission_pct, 0) as commission
from employees;

-- CASE Function
select first_name, job_id,substr(job_id,1,2) from employees;
select first_name, job_id,salary, substr(job_id,1,2) 직종,
    case substr(job_id,1,2) 
        when 'AD' then salary * 0.2
        when 'SA' then salary * 0.1
        when 'IT' then salary * 0.6
        else salary * 0.03
    end as bonus
from employees;
-- DECODE
select first_name, job_id, substr(job_id,1,2) as 직종, salary,
    DECODE(substr(job_id,1,2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.6,
        salary * 0.03) bonus
    from employees;
    
select first_name, department_id,
    case when department_id >= 10 and department_id <= 30 then 'team-a'
        when department_id <=50 then 'team-b'
        when department_id <= 100 then 'team-c'
        else 'remainder'
    end team
from employees
order by team;