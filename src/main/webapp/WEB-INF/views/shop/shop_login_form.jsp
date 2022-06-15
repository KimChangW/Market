<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<br><br><br><br>

	<div class="container" align="center">
	<form id="shop_login" action="shop_login.do" method="post" style="width: 400px;">
		<div class="form-group" >
			<label for="s_email">이메일</label> 
			<input type="text" id="s_email" name="s_email" class="form-control" placeholder="이메일">
		</div>
		<div class="form-group" >
			<label for="s_passwd">패스워드</label> 
			<input type="password" id="s_passwd" name="s_passwd" class="form-control" placeholder="패스워드">
		</div>
		<div align="center">
		<input type="submit" id="login" class="btn btn-success" value="login"/>
		</div>
	</form>
	<input type="button" id="shop_passwd" value="비밀번호 찾기" class="btn btn-default" onClick="location.href='${path}/shop_passwd_form.do'">
	<input type="button" id="shop_passwd" value="이메일 찾기" class="btn btn-default" onClick="location.href='${path}/shop_emailsearch_form.do'">
	</div>	
</body>
</html>