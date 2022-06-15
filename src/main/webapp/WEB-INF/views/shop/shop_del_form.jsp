<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상점 정보 보기</title>
<script>
function del_check(){
	if($.trim($("#s_passwd").val()) == ""){
		alert("비밀번호를 입력해주세요!");
		$("#s_passwd").val("").focus();
		return false;
	}
	if($.trim($("#s_reason").val()) == ""){
		alert("폐점사유를 작성해주세요!");
		$("#s_reason").val("").focus();
		return false;
	}
}
</script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuShop.jsp"%>
<div class="container" align="center">
		<form id="shop_del" name="shop_del" method="post" action="shop_del.do" onSubmit="return del_check()">
			<!--  <input type="hidden" id="s_status" name="s_status" value="1"> -->
			<input type="hidden" id="s_seckey" value="${shop.s_seckey}">
			<h3 class="text-primary">폐점 신청</h3>
			<table class="table">
				<tr>
					<th>email</th>
					<td>
					${shop.s_email}
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="s_passwd" name="s_passwd"></td>
				</tr>
				<tr>
					<th>폐점사유</th>
					<td><textarea id="s_reason" name="s_reason" rows="7" cols="30"></textarea></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
					<input type="submit" id="submit" class="btn btn-danger" value="폐점신청">
					<input type="button" id="button" class="btn btn-default" value="취소" onClick="location.href='${path}/shop_info.do?s_no=${shop.s_no}'">
				 	</td>
				</tr>

			</table>

		</form>
	</div>
<%@ include file="../common/footer.jsp"%>	
</body>
</html>