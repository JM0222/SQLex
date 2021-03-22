-------
--INDEX
-------

-- 레코드 검색 속도 향상을 위한 색인 작업
-- WHERE 절의 조건에서 사용되는 필드
-- JOIN 조건으로 사용되는 필드에 적용하면 검색속도 향상가능

create table s_emp
    as select * from hr.employees;

-- 인덱스 확인
select * from user_indexes;

-- 인덱스 생성
create unique index s_emp_id_pk -- 인덱스 이름
    on s_emp (employee_id);    -- 테이블명, 컬럼명

select * from user_indexes;

-- 어떤 인덱스가 어느 컬럼에 걸려있는지 확인
select * from user_ind_columns;

select t.index_name, c.column_name, c.column_position
from user_indexes t, user_ind_columns c
where t.index_name = c.index_name;

-- 인덱스 삭제
drop index s_emp_id_pk;

select * from user_indexes;

-------------
--Sequence---
-------------

select * from author;

-- 이방식은 Transaction X -> Lock X 불완전함
insert into author(author_id, author_name)
values ((select max(author_id) + 1 from author),'스티븐 킹');
rollback;

-- SEQUENCE 생성
create sequence seq_author_id
    start with 3       -- default  1
    increment by 1     -- default  1 (1씩증가)
    maxvalue 1000000;
    
-- SEQUENCE 를 이용한 INSERT (PK)
INSERT INTO author(author_id, author_name)
VALUES(seq_author_id.nextval,  -- sequence 에서 중복되지않는 정수생성
'스티븐 킹');

-- SEQUENCE 현재값 조회
select seq_author_id.currval from dual;

-- ALTER SEQUENCE 증가값, 최소값, 최대값, 캐시 수, 순환 여부 변경
-- SEQUENCE 삭제 (DROP Sequence schema.index_name)

-- SEQUENCE DICTIONARY
select * from user_sequences;
select object_name from user_objects
where object_type = 'SEQUENCE'

