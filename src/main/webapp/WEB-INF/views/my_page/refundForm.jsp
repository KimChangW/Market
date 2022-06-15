<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불요청</title>
<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>

</head>
<body>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<div class="container" align="center">
<h3 style="font-weight: bold;">환불 요청</h3>

<div class="vf-wide700-card" width=500px>
<form method="post" action="refundForm.do" onsubmit="return Check()">
<input type="hidden" name="op_no" value="${op_no }">
<table align="center" class="table">
	<tr>
		<td style="text-align: center; font-weight: bold;">
			환불 수락 여부는 이후 주문 상태에서 확인 하실 수 있습니다.
		</td>
	</tr>
	<tr>	
		<td style="text-align: center;">
			<textarea name="op_refund_why" id="op_refund_why" rows="10" cols="50">※환불 사유는 필수 작성 항목입니다※</textarea>
			<script>
					CKEDITOR.replace('op_refund_why',{filebrowserUploadUrl:'${path}/market/reviewFileUpload.do'});
			</script>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
			<input type="submit" value="등록" class="btn btn-success">
			<input type="button" value="취소" class="btn btn-outline-warning" onclick="location='orderList.do'">
		</td>
	</tr>
</table>
</form>

</div>
</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>