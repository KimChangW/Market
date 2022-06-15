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
	
	<div class="container" align=center>
		<div class="vf-wide700-card">
			<c:if test="${result == 2 }">
				<script type="text/javascript">
					alert("회원님의 아이디는 ${m_email}입니다.");
					location.href = "loginForm.do";
				</script>
			</c:if>
			<c:if test="${result == 1 }">
				<script type="text/javascript">
					alert("값을 다시 입력하세요 ");
					location.href = "emailSearchForm.do";
				</script>
			</c:if>

		</div>
	</div>
</body>
</html>