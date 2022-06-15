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

<c:if test="${result == 1}">
<script>
	alert("주문이 취소되었습니다.");
	location.href="<%= request.getContextPath()%>/orderList.do";
</script>
</c:if>

<c:if test="${result != 1 }">
	<script>
		alert("주문 취소 실패!");
		history.go(-1);
	</script>
</c:if>

</body>
</html>