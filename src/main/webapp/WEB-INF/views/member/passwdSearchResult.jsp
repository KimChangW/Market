<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

			<c:if test="${result == 2 }">
				<script type="text/javascript">
					alert("회원님의 메일로 비밀번호를 발송하였습니다.");
					location.href = "loginForm.do";
				</script>
			</c:if>
			<c:if test="${result != 2 }">
				<script type="text/javascript">
					alert("값을 다시 입력하세요 ");
					location.href = "passwdSearchForm.do";
				</script>
			</c:if>
