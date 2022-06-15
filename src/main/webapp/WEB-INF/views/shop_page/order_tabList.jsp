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
	<h3 class="text-primary">주문확인</h3>
	<br>
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
			<td>
				<fmt:formatDate value="${o.o_date }" pattern="yyMMdd"/> - 
				<fmt:formatNumber value="${o.o_no }" pattern="#####" minIntegerDigits="5"/>
			</td>
			<td>${o.m_email}</td>
			<td>${o.d_address}</td>
			<td>${o.d_name}</td>
			<td>${o.d_msg}</td>
			<td>
				<fmt:formatDate value="${o.o_date}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<a href="shopOrderDetail.do?o_no=${o.o_no}"><input type=button class="btn btn-success"value="주문처리"></a>
			</td>
			</tr>
		</c:forEach>
	</table>

<ul class="pagination">
	<c:if test="${pp.startPage > pp.pagePerBlk }">
		<li><a href="order_tabList.do?pageNum=${pp.startPage - 1}">이전</a></li>
	</c:if>
	<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
		<li <c:if test="${pp.currentPage==i}">class="active"</c:if>>
			<a href="order_tabList.do?pageNum=${i}">${i}</a>
		</li>
	</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}">
		<li>
			<a href="order_tabList.do?pageNum=${pp.endPage+1}">다음</a>
		</li>
	</c:if>
</ul>

<%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>