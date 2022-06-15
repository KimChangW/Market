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

<c:if test="${result == 1}">
	<script>
		alert("수정 성공되었습니다");
		location.href="myPage.do";
	</script>
</c:if>
<c:if test="${result == -1}">
	<script>
		alert("변경이 완료되지 못했어요 ");
		location.href="memberUpdateForm.do";
	</script>
</c:if>



</body>
</html>