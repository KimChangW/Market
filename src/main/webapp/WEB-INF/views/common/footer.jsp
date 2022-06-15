<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#footer{
	margin-top:50px;
	padding: 30px 0;
}

#footer_table{
	width: 100%
}
#footer_table td{
	width:50%; 
	border-top:3px solid;
	border-top-color:#dddddd;
	 
}

/* #footer .footerLogo{

} */
#footer .addInfo1{
	float: left; 
	margin-left: 20px;
	font-size: 14px;
	line-height:20px;
}
#footer .addInfo1 a{
	color:#000;
	font-weight:bold; 
}

#footer .addInfo2{
	float: right; 
	margin-top:20px;
	margin-left:10px;
	margin-right: 20px;
	font-size: 14px;
}

</style>    
    
<footer id="footer">
  <div class="container">   
	<table id="footer_table">
		<tr>
			<td>
			<div class="addInfo1">
				<img src="${path}/images/logo7.PNG" width=70px> <a href="">개인정보처리방침</a><br>
				<company>
					법인명 (상호):주식회사 과채마켓 | 사업자등록번호:261-81-12345 <br>
					통신판매업:제2018-서울강남-02515호 | 개인정보보호책임자:홍길동 <br>
				</company>
			</div>
			</td>
			<td>
				<div class="addInfo2">
					<address>
						주소:서울특별시 강남구 역삼동 649-5 에스코빌딩 6층, TEL:02-561-1911 <br>
						FAX:070-2025-8820 | 이메일 : help@vegemarket.com <br>
						<P class="copyright">Copyrigt(C) 2011 All Right Reserved</P>
					</address>
						
				</div>
				</td>
			</tr>
		</table>
  </div>		
</footer> 