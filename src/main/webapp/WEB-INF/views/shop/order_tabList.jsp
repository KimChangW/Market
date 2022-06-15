<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/viewConfiguration.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 주문 확인</title>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/menuShop.jsp" %>
<div class="container" align="center">
	<h2 class="text-primary">주문확인</h2>
	<table class="table table-hover">
		<tr>
			<td>주문번호</td>
			<td>주문자</td>
			<td>배송주소</td>
			<td>받는사람</td>
			<td>배송메시지</td>
			<td>주문일자</td>
			<td></td>
		</tr>
		<c:forEach var="o" items="${olist}">
			<tr>
			<td>${o.o_no}</td>
			<td>${o.m_email}</td>
			<td>${o.d_address}</td>
			<td>${o.d_name}</td>
			<td>${o.d_msg}</td>
			<td>
				<fmt:formatDate value="${o.o_date}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<a href="shopOrderDetail.do?o_no=${o.o_no}"><input type=button value="주문처리"></a>
			</td>
			</tr>
		</c:forEach>
	</table>
<%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>