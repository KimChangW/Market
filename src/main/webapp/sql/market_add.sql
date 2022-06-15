
-- member / 컬럼추가
alter table member add(m_tel varchar2(50));

-- cart / 컬럼추가
alter table cart add(cart_regdate date);

-- coupon / 칼럼명 변경
alter table coupon drop(cp_status);
alter table coupon add(cp_delstatus varchar2(2));

-- shop / 데이터타입 변경, 컬럼추가
alter table shop modify(s_tongsin varchar2(50));

alter table shop add(s_post varchar2(5));

-- qna_board / 데이터타입 변경
alter table qna_board modify(qna_delstatus varchar2(2));

-- category / 칼럼명 변경, 추가
alter table category drop(cate_name);
alter table category add(cate_large varchar2(20));

alter table category add(cate_small varchar2(20));

-- order_product / 칼럼명 변경
alter table order_product drop(o_deli_date);
alter table order_product add(op_deli_date date);

-- product / 칼럼명 삭제, 추가
alter table product drop(p_price);
alter table product drop(p_special_price);
alter table product add(p_group_price number);
alter table product add(p_follow_price number);

-- 시퀀스 (샘플용)
 create sequence restock_seq
 start with 1
 increment by 1
 nocache;

-- 게시판 (샘플용)
create table board (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ref number not null, -- 답변글끼리 그룹
	re_step number not null, -- ref내의 순서
	re_level number not null, -- 들여쓰기
	ip varchar2(20) not null, -- 작성자 ip
	reg_date date not null, -- 작성일
	del char(1)
);

-- 댓글 게시판(샘플용)
drop table replyBoard;
create table replyBoard (
	rno number primary key,
	bno number not null references board(num),
	replytext varchar2(500) not null,
	replyer varchar2(50) not null,
	regdate date not null,
	updatedate date not null
);