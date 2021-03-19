/*
사용자 생성
create user c##jm identified by 1234;
동일 이름의 schema도 같이 생성
drop user c##jm 
연결된 객체도 모두 삭제
*/

--user_users: 현재 사용자 관련정보
--all_users: db의 모든 사용자 정보
--dba_users: 모든 사용자의 상세정보

-- 현재 사용자 확인
select * from user_users;
-- 전체 사용자 확인
select * from all_users;

--Privilege, Role
-- 권한을 쉽게 관리하기 위하여 특정한 종류별로 묶어놓은 그룹
--Grant / Revoke (권한 부여/ 회수)
--로그인 권한 부여
grant create session to c##jm; -- 세션생성(로그인) 권한을 부여
grant connect, resource to c##jm; -- 접속과 자원 접근 롤 부여

-- revoke create session from c##jm
/*ORACLE 12 이후
1.일반 계정 구분하기 위해 C## 접두어
2.실제 데이터가 저장될 테이블 스페이스 마련해 줘야한다-USERS 테이블 스페이스에 공간을마련
2-1 ALTER USER C##jm DEFAULT TABLESPACE USERS
3.C## 없이 계정을 생성하는 방법
3-1 ALTER SESSION SET "_ORACLE_SCRIPT_" = true;
*/
ALTER USER C##jm DEFAULT TABLESPACE USERS
    QUOTA unlimited ON USERS; -- 저장 공간 한도를 무한으로 부여
    
--Roll의 생성

create role dbuser; -- dbuser 역할을 만들어 여러개의 권한을 담아둔다
grant create session to dbuser; -- dbuser 역할에 접속권한
grant resource to dbuser; -- dbuser 역할에 자원생성 권한을 부여
drop role dbuser; -- drop
--ROLE 을 GRANT 하면 내부에 있는 개별 권한도 모두 부여
GRANT dbuser TO c##jm; --c##jm 유저에게 dbuser 역할부여
REVOKE dbuser from c##jm; -- 권한 회수

-- 권한의 확인
show user;
select * from user_role_privs;

-- connect 역할에는 어떤 권한이 포함되어 있는가?
desc role_sys_privs;
select * from role_sys_privs where role='CONNECT';
select * from role_sys_privs where role='RESOURCE';

show user;
-- HR 계정의 employees 테이블 조회 권한을 c##jm 에게 부여하기
grant select on hr.employees to c##jm;

select * from hr.employees;

-------
--DDL
-------
show user;
select * from test;
desc test;
-- 테이블 삭제
drop table test;
select * from tab;
-- Oracle 휴지통 비우기
purge recyclebin;

-- 테이블 생성
create table book (-- 컬럼 상세 명세
    book_id number(5),
    title varchar2(50), -- 50 가변
    author varchar2(10),
    pub_date date default sysdate --기본값은 현재시간
);
desc book;

-- 서브쿼리를 활용한 테이블 생성
select * from hr.employees where job_id like 'IT_%';
create table it_emps as (
select * from hr.employees where job_id like 'IT_%'
);

select * from tab;

create table author (
    author_id number(10),
    author_name varchar2(100) not null, -- 제약조건 Not null
    author_desc varchar2(500),
    primary key (author_id)
);
desc author;
desc book;

-- book 테이블 author 컬럼 삭제
alter table book drop(author);
-- 테이블 추가
alter table book add(author_id number(10));
alter table book modify(book_id number(10));
desc book;

-- 제약조건  추가  ADD CONSTRAINT
-- book 테이블의 book_id를 PRIMARY KEY 에 부여
alter table book 
add constraint pk_book_id primary key(book_id);
desc book;

-- FOREIGN KEY 추가
alter table book
add constraint fk_author_id foreign key (author_id)
references author(author_id);

-- comment 추가
comment on table book is 'book information';
comment on table author is 'author information';
-- comment 확인
select * from user_tab_comments;

-- 제약조건도 함께 삭제
drop table IT_EMPS cascade constraint;

-- Data Dictionary 모든정보를 담아두고있다
-- 계정별 USER_ :일반사용자, ALL_:전체사용자, DBA_:관리자전용
select count(*) from dictionary;

-- 사용자 DB객체
select * from user_objects;

-- 제약조건 확인 dictionary USER_CONSTRAINTS
select * from user_constraints;
select * from user_cons_columns;
