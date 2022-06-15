<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container" align="center">
	<c:if test="${empty ol}">
		<h3>주문하신 상품이 없습니다.</h3><br><br>
		상품문의는 해당 상품의 상세설명 페이지를 이용해주시고,<br>
		기타 문의는 일반문의를 이용해 주세요.<br><br>
		<button type="button" class="main_btn btn btn-success">상품보러가기</button>
		<button type="button" class="genernal_btn btn btn-success">일반문의 하러가기</button>
	</c:if>
	<c:if test="${not empty ol}">
		<h3>주문상품을 선택해 주세요</h3>
		<table class="table" width=100% >
		<c:forEach var="ol" items="${ol}">
			<tr>
				<td width=80px><img src="${path}/upload/product/${ol.p_img}" width=80px></td> 
				<td>[${ol.s_name}]${ol.p_name}<br>
					<font style="font-size:13px">주문번호:${ol.op_no}<br>
					주문일자:<fmt:formatDate value="${ol.op_date}" pattern="yyyy-MM-dd"/></font></td>
				<td><button type="button" class="insert_btn btn btn-success" 
					onclick="order_select(${ol.op_no},${ol.s_no},'${ol.s_name}','${ol.p_name}','${ol.p_img}')">선택</button></td>
			</tr>
		</c:forEach>
		</table>
	</c:if>
</div>
</body>
</html>

<script>
// 주문 선택 버튼
function order_select(op_no,s_no,s_name,p_name,p_img){	
	opener.$("#order").html("<table width=100%><tr><td width=80px><img src='${path}/upload/product/"+p_img+"' width=80px></td>"+
			"<td valign=top >&nbsp;["+s_name+"]"+p_name+
			"<br>&nbsp;<font style='font-size:14px'>주문번호:"+op_no+"</font>"+
			"</td></tr></table>");
	opener.document.getElementById("op_no").value = op_no;
	opener.document.getElementById("s_no").value = s_no;
	self.close();
}
	// 일반 문의 버튼
$('.main_btn').click(function() {
	opener.location.href="main.do";
	self.close();
});
$('.genernal_btn').click(function() {
	opener.$('#order').html("<font color='blue'>과채마켓 플랫폼에 문의할 내용이 있으신가요?</font>");
	self.close();
});
</script>