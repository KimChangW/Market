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
		var shopname = "${shopInfo.s_name}";
		alert("구매 확정이 완료되었습니다!\n" + shopname + " 을(를) 이용해주셔서 감사합니다 :)");
		location.href = "<%= request.getContextPath()%>/orderList.do";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script>
		alert("구매 확정이 이루어지지 않았습니다.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>