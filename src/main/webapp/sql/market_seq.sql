select * from tab;
select * from seq;
select * from member;
select * from product;
select * from cart;
select * from category;
select * from coupon;
select * from delivery;
select * from event;
select * from follow;
select * from love;
select * from mycoupon;
select * from order_product where op_status=4;
select * from order_tab;
select * from product_img;
select * from qna;
select * from restock;
select * from review;
select * from shop;

create sequence cart_seq
 start with 1
 increment by 1
 nocache;

create sequence shop_seq
 start with 1
 increment by 1
 nocache;

create sequence review_seq
 start with 1
 increment by 1
 nocache;

create sequence category_seq
 start with 1
 increment by 1
 nocache;
 
create sequence coupon_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence delivery_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence event_seq
 start with 1
 increment by 1
 nocache;
 
  create sequence follow_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence love_seq
 start with 1
 increment by 1
 nocache;
 
  create sequence mycoupon_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence order_product_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence order_tab_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence product_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence product_img_seq
 start with 1
 increment by 1
 nocache;
 
 create sequence qna_seq
 start with 1
 increment by 1
 nocache;
 
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