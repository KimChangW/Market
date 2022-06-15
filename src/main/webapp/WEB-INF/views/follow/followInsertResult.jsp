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
	<c:if test="${result == 'success' }">
		<script type="text/javascript">
			alert("팔로우 상점목록에 추가되었습니다.");
			location.href = "followList.do";
		</script>
	</c:if>
	<c:if test="${result != 'success' }">
		<script type="text/javascript">
			alert("이미 팔로우 상점목록에 등록되어 있는 상점입니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>