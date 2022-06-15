<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상점 정보 수정</title>

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
 // 단일 파일 업로드
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


</script>
<script>
 // 단일 파일 업로드
 function readImage1(input) {
    if (input.files && input.files[0]) {
      //  const reader = new FileReader();
        var reader = new FileReader();
        
        reader.onload = function(e) {
           $('#previewImage1').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
} 


</script>
<script>
 function changepw1(){
	 $("#changepwform").load("shop_info_changepwform.do");
 }

</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuShop.jsp"%>
<div class="container" align="center">
			<h3 class="text-primary">정보 수정</h3>
		<form id="shop_info_edit" name="shop_info_edit" method="post"
			action="shop_info_edit.do" enctype="multipart/form-data"
			onSubmit="return edit()">
			<!--  <input type="hidden" id="s_status" name="s_status" value="1"> -->
			<%-- <input type="hidden" id="s_passwd" value="${shop.s_passwd}"> --%>
			
			<table class="table">
				<tr>
					<th>email</th>
					<td>
					${shop.s_email}
					</td>
					<td rowspan="6" align="center" style="width: 416px;"><center><b>프로필 수정</b></center>
						<!-- <input type="file" id="s_file" name="s_file1" > -->
						<!-- <input  type="file" id="s_file" name="s_file1" class="form-control" onChange="readImage(this)" multiple="multiple"/> -->
					    <input type="file" id="s_profile" name="s_profile1" value="${shop.s_profile}" class="form-control" onChange="readImage1(this)"/>
			            <img style="width: 200px;" id="previewImage1" src="#">
					</td>
				</tr>
				
				<tr>
					<th>비밀번호확인</th>
					<td><input type="password" id="s_passwd" name="s_passwd">
					<input type="button" id="changepw" value="비밀번호 변경" onClick="changepw1()"><font color="red">*비밀번호 변경시 클릭!</font>
					<div id="changepwform"></div>
					</td>
				</tr>
				<tr>
					<th>상호명</th>
					<td><input type="text" id="s_name" name="s_name" value="${shop.s_name}"></td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td><input type="text" id="s_ceo" name="s_ceo" value="${shop.s_ceo}"></td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" id="s_bizno" name="s_bizno" value="${shop.s_bizno}"></td>
				</tr>
				<tr>
					<th>통신판매업번호</th>
					<td><input type="text" id="s_tongsin" name="s_tongsin" value="${shop.s_tongsin}"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><input type="text" id="s_post" name="s_post" value="${shop.s_post}"> <input
						type="button" value="우편번호검색" onclick="openDaumPostcode()" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="s_address" name="s_address" value="${shop.s_address}"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" id="s_tel" name="s_tel" value="${shop.s_tel}"></td>
					<td rowspan="4" align="center" style="width:400px;">
					<center><b>상점소개</b></center>
					<textarea id="s_myself" name="s_myself" style="width:300px; height:200px;">${shop.s_myself}</textarea>
					</td>
				</tr>
				<tr>
					<th>은행명</th>
					<td><input type="text" id="s_bank" name="s_bank" value="${shop.s_bank}"></td>
				</tr>
				<tr>
					<th>정산계좌</th>
					<td><input type="text" id="s_account" name="s_account" value="${shop.s_account}"></td>
				</tr>
				<tr>
					<th>서류첨부</th>
					<td>
						<!-- <input type="file" id="s_file" name="s_file1" > -->
						<!-- <input  type="file" id="s_file" name="s_file1" class="form-control" onChange="readImage(this)" multiple="multiple"/> -->
					    <input type="file" id="s_file" name="s_file1" value="${shop.s_file}" class="form-control" onChange="readImage(this)"/>
			            <img style="width: 200px;" id="previewImage" src="#">
			            
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
					<input type="submit" id="submit" class="btn btn-success" value="수정"></td>
				</tr>
				<!-- <input type="button" id="changepw" value="비밀번호 변경" onClick="changepw1()">
					<div id="changepwform"></div> -->
			</table>

		</form>
	</div>
<%@ include file="../common/footer.jsp"%>	
</body>
</html>