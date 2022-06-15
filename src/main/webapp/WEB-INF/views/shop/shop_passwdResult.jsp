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
<c:if test="${result == 1}">
  <script>
 alert("입점승인자가 아닙니다");
 location.href="main.do";
 </script>
</c:if>
<c:if test="${result == 2}">
  <script>
 alert("이메일을 확인하세요");
 location.href="shop_login_form.do";
 </script>
</c:if>
<c:if test="${result == 0}">
  <script>
 alert("정보를 다시 입력해주세요");
 history.go(-1);
 </script>
</c:if>


</body>
</html>