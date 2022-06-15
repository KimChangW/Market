<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.passwd.value != frm.passwd2.value) {
			alert("암호가 다르면 수정할 수 없습니다");
			frm.passwd2.focus();
			return false;
		}
	}
</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>
	<div class="container" align="center">
		<h2 class="text-primary">게시글 글수정</h2>
		<div class="vf-wide700-card">
		<form action="${path}/update.do?pageNum=${pageNum}" method="post" name="frm"
			onsubmit="return chk()">
			<input type="hidden" name="num" value="${board.num}"> 
			<input type="hidden" name="passwd" value="${board.passwd}">
			<table class="table">
				<tr>
					<td>번호</td>
					<td>${board.num}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="subject" required="required"
						value="${board.subject}"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer" required="required"
						value="${board.writer}"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" required="required"
						value="${board.email}"></td>
				</tr>
				<tr>
					<td>암호</td>
					<td><input type="password" name="passwd2" required="required"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="5" cols="30" name="content" required="required">${board.content}</textarea>
						<script>	// 글쓰기 editor 및 사진 업로드 기능
							CKEDITOR.replace('content',{filebrowserUploadUrl:'${path}/market/fileUpload.do'});
						</script>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"  class="btn btn-success" value="확인"></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>