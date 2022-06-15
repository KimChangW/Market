<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${empty shop.s_email}">
		<script>
	alert("이메일 정보가 없습니다. 정보를 다시 입력해 주세요.");
	history.go(-1);
</script>
	</c:if>
	<c:if test="${!empty shop.s_email}">
<script>
	var email = "${shop.s_email}";
	alert("당신의 email은   "+email+"  입니다.");
	location.href="shop_login_form.do";
</script>
	</c:if>

</body>
</html>