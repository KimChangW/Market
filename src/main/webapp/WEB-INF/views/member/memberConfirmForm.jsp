<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보확인 폼</title>
<script src="<%=request.getContextPath()%>/js/member.js"></script>

 <script type="text/javascript">
 function confirm() {
		if (c.m_passwd.value != c.m_passwd2.value) {
			alert("암호가 다르면 수정할 수 없습니다");
			c.m_passwd2.value="";
			c.m_passwd2.focus();
			return false;
	}
</script> 
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/menuMyPage.jsp"%>
	<div class="container" align=center>
		<div class="vf-wide300-card">
			<div id="join_wrap" class="form-group">
				<h2 class="join_title">회원정보확인</h2>
				<form method="get" name="c" action="memberUpdateForm.do" onSubmit="return confirm()">
					<input type="hidden" id="m_seckey" name="m_seckey" value="111">
					<input type="hidden" id="m_passwd" name="m_passwd"	value="${old.m_passwd}">
					<input type="hidden" id="m_email" name="m_email"	value="${old.m_email}">

					<table id="memberconfirm" class="table">
						<tr>
							<th>회원가입 메일</th>
							<td>${m_email}</td>
						</tr>
						<tr>
							<th>현재 비밀번호</th>
							<td><input type="password" name="m_passwd2" id="m_passwd2"
								size="14" class="form-control" /></td>
						</tr>
					</table>

					<div id="join_menu">
						<input type="submit" value="비밀번호확인" class="btn btn-success" /> 
						<input type="reset" value="수정취소" class="btn btn-outline-success"
							onclick="location='main.do'" />
					</div>
				</form>
			</div>
		</div>
	</div>
</body>