<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<script src="<%=request.getContextPath()%>/js/member.js"></script>
</head>
<body>	
	<div class="container" align=center>
		 <div class="vf-wide500-card">
<!-- 			<div id="join_wrap"> -->
				<h2 class="join_title">회원가입</h2>
				<form name="f" method="post" action="memberInsert.do" onSubmit="return insert()">
					<input type="hidden" id="m_seckey" name="m_seckey" value="111">
					<table id="memberjoin" class="table">
						<tr>
							<th width=120px>회원가입 메일</th>
							<td>
								<table width=100%>
									<tr>
										<td><input type ="text"  id="m_email" name="m_email" size="14" 
											class="form-control" size="14" placeholder="ex)market@naver.com"></td>
										<td width=100px style="padding:0 0 0 5"><input type="button" id="emailcheckb" value="이메일 중복체크" class="input_button" 
										onclick="emailcheck1()" /></td>
									</tr>
									<tr>
										<td colspan=2><div id="emailcheck"></div></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>회원 비밀번호</th>
							<td><input type="password" name="m_passwd" id="m_passwd"
								size="14" class="form-control" /></td>
						</tr>

						<tr>
							<th>회원이름</th>
							<td><input name="m_name" id="m_name" size="14"
								class="form-control" /></td>
						</tr>
						<tr>
							<th>핸드폰번호</th>
							<td><input name="m_tel" id="m_tel" size="14"
								class="form-control" placeholder="숫자만 입력하세요" /></td>
						</tr>
					</table>

					<div id="join_menu" >
						<input type="submit" id="submit" value="회원가입" class="btn btn-success" disabled="disabled"/> 
							<input type="reset" value="가입취소" class="btn btn-outline-success"
							onclick="$('#m_email').focus();" />
					</div>

				</form>
			</div>
		</div>

</body>
</html>