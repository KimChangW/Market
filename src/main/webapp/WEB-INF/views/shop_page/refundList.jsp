<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/viewConfiguration.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불관리</title>
</head>
<body>
<!-- 커밋테스트 -->
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/menuShop.jsp" %>
<div class="container" align="center">
	<h3 class="text-primary">환불관리</h3>
	<table class="table table-hover">
		<tr>
			<td>주문상품번호</td>
			<td>주문자</td>
			<td>수량</td>
			<td>환불금액</td>
			<td>환불사유</td>
			<td>환불일자</td>
			<td>환불상태</td>
			<td>기타</td>
		</tr>
		<c:forEach var="op" items="${oplist}">
			<tr>
			<td>${op.op_no}</td>
			<td>${op.m_email}</td>
			<td>${op.op_qty}</td>
			<td>${op.op_refund}</td>
			<td>${op.op_refund_why}</td>
			<td>
				<fmt:formatDate value="${op.op_refund_date}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td style="text-align: left;">
			<c:if test="${op.op_status == '8' }">환불요청</c:if>
			<c:if test="${op.op_status == '9' }">환불거부</c:if>
			<c:if test="${op.op_status == '10' }">환불완료</c:if>
			</td>
			<td>
			<c:if test="${op.op_status == '8' }">
				<button type="button" class="btn btn-success btn-xs" onclick="location.href='refundOk.do?op_no='+${op.op_no}+'&o_no='+${op.o_no}+'&m_email='+'${op.m_email}';"> 승인 </button>
				<button type="button" class="btn btn-danger btn-xs" onclick="location.href='refundNo.do?op_no='+${op.op_no}+'&o_no='+${op.o_no};"> 거절 </button>
			</c:if>
			</td>
			</tr>
		</c:forEach>
	</table>
<%@ include file="../common/footer.jsp" %>
</div>

</body>
</html>