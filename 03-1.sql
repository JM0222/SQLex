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
