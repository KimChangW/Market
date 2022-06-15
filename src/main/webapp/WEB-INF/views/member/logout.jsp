<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<%  // 세션 삭제
	session.invalidate();
%>  

<script>
	alert("로그아웃 되었습니다.");
	location.href="./main.do";
</script>  