<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<br><br><br><br>
	<div class="container" align="center">
	<form method="post" action="shop_passwd.do">
		<div class="form-group" >
			<label >email</label><div><input type="text" id="s_email" name="s_email"></div>
		</div>
		<div class="form-group" >
			<label>이름</label><div><input type="text" id="s_ceo" name="s_ceo"></div>
		</div>
		<div class="form-group">
			<label>전화번호</label><div><input type="text" id="s_tel" name="s_tel"></div>
		</div>
		<div>
			<input type="submit" id="submit" name="submit" class="btn btn-default" value="비번찾기">
		</div>
	</form>	
	</div>


</body>
</html>