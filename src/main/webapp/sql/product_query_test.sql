select * from category;
select * from product;
select * from product_img;
select * from shop;

update product_img set p_img_order=1
update product_img set p_img_order=2 where p_img_no=13

select * from product p inner join category c on p.cate_no = c.cate_no where c.cate_large='과일'
       		
select count(*) from product P
	left outer join category C on P.cate_no = C.cate_no
 	left outer join product_img PI on P.p_no = PI.p_no and PI.p_img_order=1
 	left outer join shop S on P.s_no = S.s_no 		
where	p_status='1' and cate_large like '%과일%'
       		
select 
	P.p_no as p_no,
	P.cate_no as cate_no,
	P.s_no as s_no,
	P.p_group_buying as p_group_buying,
	P.p_follow_sale as p_follow_sale,
	P.p_name as p_name,
	P.p_detail as p_detail,
	P.p_group_price as p_group_price,
	P.p_sell_price as p_sell_price,
	P.p_follow_price as p_follow_price,
	P.p_stock as p_stock,
	P.p_regdate as p_regdate,
	P.p_status as p_status,
	P.p_hit as p_hit,
	C.cate_large as cate_large,
	C.cate_small as cate_small,
	PI.p_img as p_img,
	S.s_name as s_name,
	S.s_email as s_email
from product P
   	left outer join category C on P.cate_no = C.cate_no
   	left outer join product_img PI on P.p_no = PI.p_no and PI.p_img_order=1
   	left outer join shop S on P.s_no = S.s_no
where s_name='당도최고 과일만수르'
where p_status='1' and s_name='당도최고 과일만수르' order by p_group_price asc
   
select cate_small from product P
			left outer join category C on P.cate_no = C.cate_no
where p_status='1' and cate_large = (select cate_large from category where cate_small = '배')
group by cate_small 
order by cate_small asc

select cate_large from category where cate_small = '배'

delete from product where p_hit=3;