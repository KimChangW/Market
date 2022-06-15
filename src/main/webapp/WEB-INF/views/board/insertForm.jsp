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
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuShop.jsp"%>
<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>
<%-- <script type="text/javascript" src="${path }/ckeditor/ckeditor.js"/> --%>
	<div class="container" align="center">
		<h2 class="text-primary">게시판 글쓰기</h2>
		<div class="vf-wide700-card">
		<form action="${path}/insert.do" method="post">
			<input type="hidden" name="num" value="${num}"> 
			<input type="hidden" name="ref" value="${ref}"> 
			<input type="hidden" name="re_step" value="${re_step}"> 
			<input type="hidden" name="re_level" value="${re_level}"> 
			<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="table">
				<tr>
					<td>제목</td>
					<td><input type="text" name="subject" required="required"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer" required="required"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" required="required"></td>
				</tr>
				<tr>
					<td>암호</td>
					<td><input type="password" name="passwd" required="required"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="5" cols="30" name="content"	required="required"></textarea>
						<script>	// 글쓰기 editor 및 사진 업로드 기능
							CKEDITOR.replace('content',{filebrowserUploadUrl:'${path}/market/fileUpload.do'});
						</script>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인" class="btn btn-success"></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>