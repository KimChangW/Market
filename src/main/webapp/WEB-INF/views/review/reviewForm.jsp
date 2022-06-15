<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<div class="container" align="center">
<h3 style="font-weight: bold; margin: 30px 0px 30px 0px;">상품 리뷰</h3>

<div class="vf-wide700-card">
<form action="reviewInsert.do" method="post" onsubmit="return Check()">
<input type="hidden" name="p_no" value=${product.p_no }>
<input type="hidden" name="m_email" value=${m_email }>
<input type="hidden" name="o_no" value=${o_no }>

	<table class="table">
		<tr>
			<td style="font-weight: bold;" align="center">상품명</td>
			<td>${product.p_name }</td>
		</tr>
		<tr>
			<td style="font-weight: bold;" align="center">제 목</td>
			<td><input type="text" name="r_title" size="50" required="required"></td>
		</tr>
		<tr>
			<td style="font-weight: bold;" align="center">별 점</td>
			<td>
			<div>
				<select id="r_star" name="r_star" required="required">
					<option value="">선택하세요</option>
					<option value="0">☆☆☆☆☆</option>
					<option value="1">★☆☆☆☆</option>
					<option value="2">★★☆☆☆</option>
					<option value="3">★★★☆☆</option>
					<option value="4">★★★★☆</option>
					<option value="5">★★★★★</option>
				</select>	
			</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea id="r_content" name="r_content" rows="10" cols="50">※리뷰 내용은 필수 작성 항목입니다※</textarea>
				<script>
					CKEDITOR.replace('r_content',{filebrowserUploadUrl:'${path}/market/reviewFileUpload.do'});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: center;">
				<input type="submit" class="btn btn-success" value="등록">
				<input type="button" class="btn btn-outline-success" value="취소" onclick="history.go(-1)">
			</td>
		</tr>
	</table>
</form>
</div>
</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>