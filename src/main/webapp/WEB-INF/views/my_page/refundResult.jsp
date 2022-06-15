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

<c:if test="${result == 1 }">
	<script>
		alert("환불 접수가 완료되었습니다!");
		location.href = "<%= request.getContextPath()%>/orderList.do";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script>
		alert("환불 요청이 실패하였습니다.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>