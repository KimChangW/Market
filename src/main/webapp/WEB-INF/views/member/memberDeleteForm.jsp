<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 </title>
<script src="<%=request.getContextPath()%>/js/member.js"></script>

<script type="text/javascript">
	function chk() {
		var dbpass = del.m_passwd.value;
		alert("db_passwd:" + dbpass);
		alert("input_passwd:" + del.m_passwd2.value);

		if (del.m_passwd.value != del.m_passwd2.value) {
			alert("암호가 다르면 수정할 수 없습니다");
			del.m_passwd2.value = "";
			del.m_passwd2.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/menuMyPage.jsp"%>
	<div class="container" align=center>
		<div class="vf-wide700-card">
			<div id="join_wrap">
				<h2 class="join_title">회원탈퇴</h2>
				<form name="del" method="post" action="memberDelete.do"
					onsubmit="return deleteform()">
					<input type="hidden" id="m_seckey" name="m_seckey" value="111">
					<input type="hidden" id="m_passwd" name="m_passwd"
						value="${deleteM.m_passwd}"> <input type="hidden"
						id="m_email" name="m_email" value="${deleteM.m_email}">
					<table id="memberdel" class="table">
						<tr>
							<th>회원가입 메일</th>
							<td>${m_email}</td>
						</tr>
						<tr>
							<th>회원 비밀번호</th>
							<td><input type="password" name="m_passwd2" id="m_passwd2"
								size="14" class="input_box"  /></td>
						</tr>


						<tr>
							<th>탈퇴사유</th>
							<td>
								<input type="checkbox" id="h1" name="m_del_why" value="제품부족" checked>제품군의 부족 
								<p><input type="checkbox" id="h1" name="m_del_why" value="사이트안예뻐"> 사이트구조가 마음에 안들어서 </p>
								<p><input type="checkbox" id="h1" name="m_del_why" value="가격경쟁력"> 가격경쟁력</p>
								<p><input type="checkbox" id="h1" name="m_del_why" value="상품컨디션"> 상품의 컨디션부족</p>
								<p><input type="checkbox" id="h1" name="m_del_why" value="타사로이동"> 타사에 매력을느껴서</p>
								<p><input type="checkbox" id="h1" name="m_del_why"value="기타"> 기타 다른이유</p>
							</td>
						<tr>
							<td colspan="2" style="text-align: center;">
								<input type="submit" value="회원탈퇴" class="btn btn-success" />
								<input type="button" value="취소" class="btn btn-outline-success" onclick="location='myPage.do'" />
							</td>
						</tr>
					</table>

			</form>
		</div>
	</div>
	</div>
</body>
</html>