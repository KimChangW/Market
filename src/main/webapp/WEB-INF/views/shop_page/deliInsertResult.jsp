<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운송장번호 입력</title>
</head>
<body>

<c:if test="${result == 1}">
	<script>
		alert("송장번호가 입력되었습니다.");
		location.href="shopOrderDetail.do?o_no="+${o_no};
	</script>
</c:if>

</body>
</html>