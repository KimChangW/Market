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
 	<c:if test="${sessionScope.s_email == null}">
	<script>
	location.href="<%=request.getContextPath()%>/shop_login_form.do";
	</script>
	</c:if>
	
	<c:if test="${sessionScope.s_email != null && sessionScope.s_status == '2' }">
	<script>
	location.href="<%=request.getContextPath()%>/shop_info.do";
	console.log();
	</script>
	</c:if>
	<c:if test="${sessionScope.s_email != null && sessionScope.s_status == 'm' }">
	<script>
	location.href="<%=request.getContextPath()%>/memberList.do";
	console.log();
	</script>
	</c:if>
</body>
</html>