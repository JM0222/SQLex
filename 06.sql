-- DAO 객체 생성 연습 
select * from user_objects;
desc author;

select * from author;

drop table author cascade constraints;
drop table book;
drop SEQUENCE seq_author_id;
-- 테이블, 시퀀스 생성
create table author (
    id number(10),
    name varchar2(40) not null,
    bio varchar2(100),
    primary key (id)
);
create SEQUENCE seq_author
    start with 1
    increment by 1
    maxvalue 1000000;
select * from user_objects;

insert into author
values(seq_author.nextval,
            '박경리','토지작가');

select * from author;

commit;

-- 미니 프로젝트 SQL
create table phone_book (
    id number(10) primary key,
    name varchar2(10),
    hp varchar2(20),
    tel varchar2(20)
    );
create sequence seq_phone_book;