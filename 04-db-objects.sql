---------
---DB 객체
---------

-- VIEW: 한개 혹은 복수 개의 테이블을 기반으로 함, 실제 데이터 X
-- VIEW 생성을 위해서는 CREATE VIEW  권한이 필요
-- system 로그인후 권한 부여
grant create view to c##jm;

-- SIMPLE VIEW
-- 단일 테이블 혹은 , 뷰를 기반으로 생성, 
-- 제약조건위반이없다면 INSERT, DELETE, UPDATE 가능
-- 기반 테이블 생성
create table emp_10
as select employee_id, first_name, last_name, salary
        from hr.employees;
-- employees 테이블로부터 department_id가 10인 사람들 VIEW로 생성
create or replace view view_emp_10
    as select * from emp_10;
create or replace view view_emp_10
    as select * from emp_10 with read only; -- 읽기 전용 view
desc view_emp_10;
-- view 는 테이블처럼 조회할수있다 / 실제데이터는 기반테이블에서 가지고온다
select * from view_emp_10;

-- COMPLEX view
-- 복수 개의 table or view를 기반으로 한다
-- 함수, 표현식을 포함할수있다.
-- 기본적으로 INSERT, UPDATE, DELETE 불가
-- book 테이블 JOIN author -> VIEW

create or replace view book_detail
(book_id, title, author_name,pub_date)
as select book_id, title, author_name, pub_date
from book b, author a
where b.author_id = a.author_id;

----view 를 위한 딕셔너리
select * from user_views;
-- 특정 view의 정보를 확인하려면 view_name 조건으로 조회
select * from user_views
where view_name='BOOK_DETAIL';

select * from user_objects
where object_type='VIEW';

-- VIEW의 삭제
-- 실제 테이터는 view가 아닌 기반테이블에 위치
drop view book_detail;
select * from user_views;

---- 