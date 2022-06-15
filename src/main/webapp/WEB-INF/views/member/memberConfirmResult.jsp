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
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/menuMyPage.jsp"%>
	<div class="container" align=center>
		<div class="vf-wide700-card">
			<c:if test="${result > 0 }">
				<script type="text/javascript">
					alert("회원님의 정보가 수정되었습니다.");
					location.href = "${path}/main.do";
				</script>
			</c:if>
			<c:if test="${result <= 0 }">
				<script type="text/javascript">
					alert("수정실패 되었어요");
					location.href = "${path}/memberUpdateForm";
				</script>
			</c:if>

		</div>
	</div>
</body>
</html>