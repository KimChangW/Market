select * from member;
select * from cart;
select * from shop;
select * from review;
select * from category;
select * from coupon;
select * from delivery;
select * from event;
select * from follow;
select * from love;
select * from mycoupon;
select * from order_product;
select * from order_tab;
select * from product;
select * from product_img;
select * from board;
select * from qna;
select * from restock;
select * from shop;

insert into product_img values(product_img_seq.nextval,52,'product42.PNG',1);
update product_img set p_img_order=5 where p_img_no = 36;

insert into category values(category_seq.nextval,'채소','완두콩');

update category set  cate_large='과일', cate_small='수박' where cate_no=35;

update category set cate_small='뿌리채소' where cate_no=49;

update product set p_follow_sale='Y' where p_no=15;
update product set p_follow_sale='N' where p_no=19;
update product set p_group_buying='N' where p_no=19;
update product set p_group_buying='Y' where p_no=14;
insert into category values(category_seq.nextval,'채소','친환경');
insert into category values(category_seq.nextval,'채소','양파');
insert into category values(category_seq.nextval,'채소','대파');
insert into category values(category_seq.nextval,'채소','마늘');
insert into category values(category_seq.nextval,'채소','배추');
insert into category values(category_seq.nextval,'채소','고구마');
insert into category values(category_seq.nextval,'채소','감자');
insert into category values(category_seq.nextval,'채소','당근');
insert into category values(category_seq.nextval,'채소','시금치');
insert into category values(category_seq.nextval,'채소','쌈채소');
insert into category values(category_seq.nextval,'채소','나물');
insert into category values(category_seq.nextval,'채소','브로콜리');
insert into category values(category_seq.nextval,'채소','파프리카');
insert into category values(category_seq.nextval,'채소','양배추');
insert into category values(category_seq.nextval,'채소','오이');
insert into category values(category_seq.nextval,'채소','호박');
insert into category values(category_seq.nextval,'채소','고추');
insert into category values(category_seq.nextval,'채소','콩나물');
insert into category values(category_seq.nextval,'채소','버섯');
insert into category values(category_seq.nextval,'채소','냉동채소');
insert into category values(category_seq.nextval,'채소','간편채소');
insert into category values(category_seq.nextval,'채소','이색채소');

insert into category values(category_seq.nextval,'채소','기타채소');

insert into category values(category_seq.nextval,'잡곡','쌀');
insert into category values(category_seq.nextval,'잡곡','잡곡');
insert into category values(category_seq.nextval,'잡곡','견과류');
insert into category values(category_seq.nextval,'잡곡','기타');