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
<%@ include file="../common/menuShop.jsp"%>

	<div class="container" align="center">
		<h3 class="text-primary">답변하기</h3>
		<div class="vf-wide700-card">
		<form action="${path}/qnaAnswer.do" method="post">
			<input type="hidden" name="qna_no" value="${qna.qna_no}">
			<input type="hidden" name="s_no" value="${qna.s_no}">
			<table class="table">
				<tr>
					<td>상품</td>
					<td><c:if test="${qna.p_no != 18}"><font color=blue>[${qna.p_no}] 상품에 대한 문의내용입니다.</font>
								<a href="productView.do?p_no=${qna.p_no}">>>상품 보러가기</a></c:if>
							<c:if test="${qna.op_no != 213}"><font color=red>주문번호 :${qna.op_no} 주문 건에 대한 문의내용입니다.</font>
								<a href="orderDetail.do?op_no=${qna.op_no}&o_no=${qna.o_no}">>>주문상품 보러가기</a></c:if></td>
				</tr>
				<tr>
					<td>문의내용</td>
					<td>${qna_question}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="form-control" id="qna_answer" name="qna_answer" rows="10" cols="50" required="required"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인" class="btn btn-success"></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
	
<br><br><br><br><br><br>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
	