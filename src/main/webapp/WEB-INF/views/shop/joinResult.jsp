<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result1== 1}">
<script>
	alert("입점신청을 하였습니다.");
	location.href="<%=request.getContextPath()%>/shop_page.do";
</script>
</c:if>
<c:if test="${result1 != 1}">
<script>
	alert("입점신청을 다시 해주세요.");
	history.go(-1);
</script>
</c:if>

</body>
</html>