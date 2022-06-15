<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<div class="container" align=center>
		<h3 style="font-weight: bold; margin: 30px 0px 30px 0px;">배송관련,주문(<font style="font-size:15px">취소/교환/환불</font>)관련 문의</h3>
		<div class="vf-wide700-card">
		<form id="insert_form" method="post" action="${path}/qnaInsert.do" onSubmit="return order_check">
			<input type="hidden" name="p_no" value="18">
			<input type="hidden" name="m_email" value="${sessionScope.m_email }">
			<input type="hidden" name="qna_answer" value="답변대기">
			<table class="table">
				<tr>
					<td width=120px>문의유형 선택</td>
					<td><input type=button class="orderList_btn btn btn-outline-success" value="주문상품 관련문의">
<!-- 						<input type=button class="shopList_btn btn btn-outline-success" value="상점 일반문의"> -->
						<input type=button class="genernal_btn btn btn-outline-success" value="과채마켓 일반문의">
						<div id="order" style="margin:5px;" ></div>
						<input type='hidden' id='op_no' name='op_no' value="213">
						<input type='hidden' id='s_no' name='s_no' value="23"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input class="form-control" type="text" size=40 name="qna_title" required="required"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="form-control" id="qna_question" name="qna_question" rows="10" cols="50" required="required"></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="checkbox" name="qna_secret" value="Y"> 비밀글로 문의하기</td>
				</tr>

				<tr>
					<td colspan=2 align="center"><input type="submit" value="확인" class="insert_btn btn btn-success"></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
	
<br><br><br><br><br><br>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
<script>
	// 주문상품 선택
	$(".orderList_btn").on("click",function(){
		let popUrl = "qnaOrderList.do";
		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
		window.open(popUrl,"주문목록",popOption);
	});
	// 상점 선택
/* 	$(".shopList_btn").on("click",function(){
		let popUrl = "qnaShopList.do";
		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
		window.open(popUrl,"상점목록",popOption);
	}); */
	$('.genernal_btn').click(function() {
		$('#order').html("<font color='blue'>과채마켓 플랫폼에 문의할 내용이 있으신가요?</font>");
	});
</script>