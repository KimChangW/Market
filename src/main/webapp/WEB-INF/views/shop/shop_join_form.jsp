<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입점신청</title>
<!-- 상점상태: 승인대기중(1) 승인(2) 폐점(3) -->

<script src="<%=request.getContextPath()%>/js/shop.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
//우편번호, 주소 Daum API
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {				
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
			document.getElementById('s_post').value = data.zonecode;
			document.getElementById('s_address').value = data.address;				
		}
	}).open();
}
</script>
<script>
 // 단일 파일 업로드 미리보기
 function readImage(input) {
    if (input.files && input.files[0]) {
      //  const reader = new FileReader();
        var reader = new FileReader();
        
        reader.onload = function(e) {
           $('#previewImage').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
} 
// 첨부파일 버튼 클릭시 이벤트(파일명을 보여주기위한 함수)
$( document ).ready(function() {
	$("#showfileBtn").click(function(e){
		//e.stopPropagation();
		$("#s_file").click();
	});
	
	$("#s_file").change(function(){
		var fileNm = $(this).val();
		var index = fileNm.lastIndexOf("\\"); 
		fileNm = fileNm.substring(index+1);
		$("#s_file_nm").val(fileNm);
	});
});
/*  // 다중 파일 업로드 미리보기
	var img_files = [];
function readImage(n){
	
	var filesArr = Array.prototype.slice.call(n.result.files);
	
	filesArr.forEach(function(f){
		img_files.push(f);
		var reader = new FileReader();
		reader.onload = function(e) {
	           $('#previewImage').attr('src', e.target.result);
	        }
	       reader.readAsDataURL(f);
		});
} */


</script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
	<div class="container" align="center">
			<h3 class="text-primary">입점 신청</h3>
		<form id="shop_join" name="shop_join" method="post"
			action="shop_join.do" enctype="multipart/form-data"
			onSubmit="return Check()">
			<!--  <input type="hidden" id="s_status" name="s_status" value="1"> -->
			<input type="hidden" id="s_seckey" name="s_seckey" value="1111">
			<table class="table">
				<tr>
					<th>email</th>
					<td>
					<input type="text" id="s_email" name="s_email">
					<input type="button" id="emailck" value="email중복체크" class="input_button"
      				onclick="email_check()" /><font color="red">아이디 중복 검사를 해주세요</font>
      				<div id="emailcheck"></div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="s_passwd" name="s_passwd"></td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td><input type="password" id="s_passwd1" name="s_passwd1"></td>
				</tr>
				<tr>
					<th>상호명</th>
					<td><input type="text" id="s_name" name="s_name"></td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td><input type="text" id="s_ceo" name="s_ceo"></td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" id="s_bizno" name="s_bizno"></td>
				</tr>
				<tr>
					<th>통신판매업번호</th>
					<td><input type="text" id="s_tongsin" name="s_tongsin"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input type="text" id="s_post" name="s_post"> <input
						type="button" value="우편번호검색" onclick="openDaumPostcode()" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="s_address" name="s_address"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" id="s_tel" name="s_tel"></td>
				</tr>
				<tr>
					<th>은행명</th>
					<td><input type="text" id="s_bank" name="s_bank"></td>
				</tr>
				<tr>
					<th>정산계좌</th>
					<td><input type="text" id="s_account" name="s_account"></td>
				</tr>
				<tr>
					<th>서류첨부</th>
					<td>
						<!-- <input type="file" id="s_file" name="s_file1" > -->
						<!-- <input  type="file" id="s_file" name="s_file1" class="form-control" onChange="readImage(this)" multiple="multiple"/> -->
					    <input type="file" id="s_file" name="s_file1" class="form-control" onChange="readImage(this)" style="display:none;"/>
					    
					    <div class="input-group" style="display: flex;">
						    <input type="text" id="s_file_nm" name="s_file_nm" class="form-control" readonly="readonly" style="width: 30%;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;"/>
						    <div class="input-group-append">
						    	<button type="button" id="showfileBtn" style="line-height: 28px;">파일선택</button>
							</div>
			            </div>
			            <img style="width: 200px;" id="previewImage" src="#">
			            
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="submit" id="submit" class="btn btn-success" value="상점신청" disabled="disabled"></td>
				</tr>

			</table>

		</form>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>