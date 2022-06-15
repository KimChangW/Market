<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
	alert("가입정보를 찾을 수 없습니다.");
	history.go(-1);
	</script>
</c:if>
	
<c:if test="${result == 2 }">
	<script>
	alert("회원정보를 정확히 입력해주세요.");
	history.go(-1);
	</script>
</c:if>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

</body>
</html>