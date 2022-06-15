select * from product where p_status=1 order by p_no desc;
select * from shop where s_no in (select distinct s_no from product)
select * from qna where op_no is null;
select * from order_product where m_email='hamtori@gmail.com'
select * from order_tab where s_no is null
select * from member;
select * from review
select s_profile,s_myself from shop;

update shop set s_profile='shop3.PNG' where s_no =3;
update product set p_name='qna게시판용 테스트 데이터입니다. 삭제하지 말아주세요' where p_no = 18;

delete from order_tab where s_no is null;
delete from qna
select * from qna Q left join member M on M.m_email = Q.m_email order by qna_ref desc, qna_writedate asc

select *
from order_product 
where m_email='hamtori@gmail.com'

select s_no from Shop where s_name like '%민주니가게%'

select 
	OP.op_no as op_no,
	OP.op_date as op_date,
	P.p_name as p_name,
	P.s_no as s_no,
	P.p_sell_price as p_sell_price,
	S.s_name as s_name
from order_product OP
   	left join product P on OP.p_no = P.p_no
   	left join shop S on S.s_no = P.s_no
where m_email='hamtori@gmail.com'

select * from PRODUCT_IMG

		select 
			OP.op_no as op_no,
			OP.p_no as p_no,
			OP.op_date as op_date,
			P.p_name as p_name,
			P.s_no as s_no,
			P.p_sell_price as p_sell_price,
 			PI.p_img as p_img,
 			S.s_name as s_name
		from order_product OP
		   	left outer join product P on OP.p_no = P.p_no
		   	left outer join product_img PI on P.p_no = PI.p_no and PI.p_img_order=1
		   	left outer join shop S on P.s_no = S.s_no
		where m_email='hamtori@gmail.com' and p_no=16

select * from qna




select * from (select a.*,rowNum rn from (
			select 
				Q.qna_no as qna_no,
				Q.p_no as p_no,
				Q.op_no as op_no,
				Q.m_email as m_email,
				Q.qna_title as qna_title,
				Q.qna_question as qna_question,
				Q.qna_answer as qna_answer,
				Q.qna_ref as qna_ref,
				Q.qna_secret as qna_secret,
				Q.s_no as s_no,
				Q.qna_writedate as qna_writedate,
				Q.qna_delstatus as qna_delstatus,
				M.m_name as m_name,
				P.p_name as p_name,
				OP.o_no as o_no
			from qna Q
			   	left join member M on M.m_email = Q.m_email
			   	left join product P on P.p_no = Q.p_no
			   	left join order_product OP on OP.op_no = Q.op_no
			 where qna_delstatus='N' and m_email like '%ham%'
	order by qna_ref desc, qna_writedate asc ) a)

insert into qna values (qna_seq.nextval,18,null,
			'ljpson@naver.com','문의게시판 테스트입니다2 ','문의게시판 테스트입니다2 문의게시판 테스트입니다2<br>문의게시판 테스트입니다2','답변대기',qna_seq.nextval,
			'N',3,sysdate,'N')
			
update qna set qna_question='문의게시판 테스트입니다3' where qna_no=7
update qna set p_no=null where qna_no=5