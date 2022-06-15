<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품절취소 처리 결과</title>
</head>
<body>

<c:if test="${result == 1}">
	<script>
		alert("품절 취소후 회원에게 안내 이메일을 발송했습니다.");
		location.href="shopOrderDetail.do?o_no="+${o_no};
	</script>
</c:if>
<c:if test="${result == -1}">
	<script>
		alert("품절취소 처리 실패!");
		location.href="shopOrderDetail.do?o_no="+${o_no};
	</script>
</c:if>



</body>
</html>