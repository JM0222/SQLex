-----------------
--DML 데이터 조작어
-----------------

-- INSERT
desc author;

-- case1 데이터 넣을 컬럼을 지정하기 않고 순서에따라 입력
insert into author
values(1,'박경리','토지 작가');
select * from author;

-- case2 컬럼이름 지정, 지정되지 않은 컬럼은 NULL 자동입력
insert into author(author_id, author_name)
values(2,'무라카미 하루키');
select * from author;

-- insert, update, delete 작업을 수행하면 Transaction 수행
-- 작업이 완료되었을 때  원래상태로 복원 -> ROLLBACK 저장 -> COMMIT
commit;

-- UPDATE  특정튜플의 내용을 갱신할떄 사용하는명령
-- 조건을 부여하지않으면 모든 레코드에 적용됨 
update author set author_desc = '기사단장죽이기'
where author_name ='무라카미 하루키';
select * from author;
commit;

-- DELETE 특정튜플을 삭제할때 사용하는 명령
-- 조건을 부여하지않으면 모든 레코드에 적용됨 
-- delete from _______ where _____ 
-- TRUNCATE 는 ROLLBACK 불가능