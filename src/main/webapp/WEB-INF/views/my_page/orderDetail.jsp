<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세</title>

<style>

.delivery_info{
	float:left;
	width:50%
}

.payment_info{
	float:right;
	width:45%;
}

</style>

</head>
<body>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<div class="container" align="center">
<div class="vf-wide700-card" align="center" style="width: 900px;">
<h3 style="font-weight: bold; margin: 30px 0px 30px 0px;">주문 내역 상세</h3>

<div style="margin-bottom: 20px;">
	주문번호: <fmt:formatDate value="${detail.o_date }" pattern="yyMMdd"/> - <fmt:formatNumber value="${detail.o_no }" pattern="#####" minIntegerDigits="5"/>
</div>
			
<!-- 주문 상품 목록 -->
<table align="center" class="table">
	<tr>
		<th style="text-align: center;">주문상품번호</th>
		<th style="text-align: center;">:-)</th>
		<th style="text-align: center;">상품명</th>
		<th style="text-align: center;">수량</th>
		<th style="text-align: center;">가격</th>
		<th style="text-align: center;">주문 상태</th>
	</tr>
	
<c:forEach var="list"  items="${detailList }">
	<tr>
		<td style="text-align: center;">${list.op_no }</td>
		<td style="text-align: center;"><img src="${path}/upload/product/${list.p_img}" width="100px"></td>
		<td style="text-align: center;">[${list.s_name }] <a href="productView.do?p_no=${list.p_no}">${list.p_name }</a></td>
		<td style="text-align: center;">${list.op_qty }</td>
		<td style="text-align: center;"><fmt:formatNumber value="${list.op_price * list.op_qty}" pattern="#,###"/> 원</td>		
		<td style="text-align: center;">
			<c:if test="${list.op_status == '1' }">공동구매대기</c:if>
			<c:if test="${list.op_status == '2' }">공동구매실패</c:if>
			<c:if test="${list.op_status == '3' }">배송전 </c:if>
			<c:if test="${list.op_status == '4' }">주문취소</c:if>
			<c:if test="${list.op_status == '5' }">품절취소</c:if>
			<c:if test="${list.op_status == '6' }">출고완료</c:if>
			<c:if test="${list.op_status == '7' }">배송완료 </c:if>
			<c:if test="${list.op_status == '8' }">환불요청중</c:if>
			<c:if test="${list.op_status == '9' }">환불거부</c:if>
			<c:if test="${list.op_status == '10' }">환불완료</c:if>
			<c:if test="${list.op_status == '11' }">거래완료</c:if>
		</td>		
	</tr>
</c:forEach>
</table>
</div>
</div>

<div class="container" style="width: 850px; margin-top: 30px;">
<!-- 배송 정보 -->
<div class="delivery_info" align="center">

<h3 style="font-weight: bold; text-align: left; margin-bottom: 15px;">배송 정보</h3>
<table class="table" style="width:100%;">
	<tr style="border-top:3px solid;border-top-color:#dddddd;">
		<td width=100px>수령인</td>
		<td>${detail.d_name }</td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td>${detail.d_tel }</td>
	</tr>
	<tr>
		<td>배송지 주소</td>
		<td>${detail.d_address }  (${detail.d_post })</td>
	</tr>
	<tr>
		<td>배송 메세지</td>
		<td>
			${detail.d_msg }
		</td>
	</tr>
</table>
</div>

<!-- 결제 정보 -->
<div class="payment_info" align="center">

<h3 style="font-weight: bold; text-align: left; margin-bottom: 15px;">결제 정보</h3>
<table class="table" style="width:100%;">
	<tr style="border-top:3px solid;border-top-color:#dddddd;">
		<td>상품 가격</td>
		<td style="text-align: right"><fmt:formatNumber value="${detail.o_total_price }" pattern="#,###"/> 원</td>
	</tr>
	<tr>
		<td>할인 금액</td>
		<td style="text-align: right">- <fmt:formatNumber value="${detail.o_sale_price }" pattern="#,###"/> 원</td>
	</tr>
	<tr>
		<td>배송비</td>
		<td style="text-align: right"><fmt:formatNumber value="${detail.o_deli_price }" pattern="#,###"/> 원</td>
	</tr>
	<tr>
		<td>결제 방식</td>
		<td style="text-align: right">${detail.o_pay_type }</td>
	</tr>
	<tr>
		<td style="font-weight: bold;">총 결제 금액</td>
		<td style="text-align: right; font-weight: bold;"><fmt:formatNumber value="${detail.o_pay_price }" pattern="#,###"/> 원</td>
	</tr>
</table>
</div>
</div>

<%@ include file="../common/footer.jsp"%>
</body>
</html>