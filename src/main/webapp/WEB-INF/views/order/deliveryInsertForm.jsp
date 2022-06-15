<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/delivery.js"></script>
<!-- 다음주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(".post_btn").on("click", function(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
        }
    }).open();
});    
    
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('post_input').value = data.zonecode;
	                document.getElementById('arr1').value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('arr2').focus();
            }
        }).open();
    }
</script>

<style>
.title{
	text-align:center;
	margin-bottom:40px; 
}
table{
	margin-left:auto;
	margin-right:auto;
}
.btn_div{
	margin-top:30px; 
}	
</style>

</head>
<body>

	<!-- 신규 배송지 -->
	<duv class="container">
		<div class="title"><h3>배송지 등록</h3></div>
		<table>
			<colgroup>
				<col width="150px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th><label style="margin-left: 20px; margin-top: 10px;">구분</label></th>
					<td><input class="d_cate_input form-control" name="d_cate">
						<div
							style="font-size: 13px; color: #218838; margin-top: 5px; margin-bottom: 5px;">
							※ 집, 회사, 기타 등등</div></td>
				</tr>
				<tr>
					<th><label style="margin-left: 20px; margin-top: 10px;">이름</label></th>
					<td><input class="d_name_input form-control"
						style="margin-bottom: 10px;" name="d_name"></td>
				</tr>
				<tr>
					<th><label style="margin-left: 20px; margin-top: 10px;">전화번호</label></th>
					<td><input class="d_tel_input form-control"
						style="margin-bottom: 10px;" name="d_tel">
						<div
							style="font-size: 13px; color: #218838; margin-top: 5px; margin-bottom: 5px;">
							※ '-'는 제외하고 입력하세요.</div></td>
				</tr>
				<tr>
					<th><label style="margin-left: 20px; margin-top: 10px;">우편번호</label></th>
					<td>
						<div style="display: flex;">
							<input class="d_post_input form-control" name="d_post"
								id="post_input" size="5" readonly
								style="width: 100px; margin-bottom: 10px;">
							<button type="button" class="post_btn btn btn-outline-success "
								onclick="openDaumPostcode()"
								style="margin-bottom: 10px; margin-left: 5px;">우편번호검색</button>
						</div>
					</td>
				</tr>
				<tr>
					<td><label style="margin-left: 20px; margin-top: 10px;">주소</label></td>
					<td><input class="d_address_input form-control"
						name="d_address" id="arr1" size="50" readonly><br>
						<div style="display: flex;">
							<input class="d_detail_address_input form-control"
								name="d_detail_address" id="arr2" size="37">
						</div></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<div class="btn_div">
						<button class="insert_btn btn btn-success">배송지 등록</button>
						<button class="return_btn btn btn-success" 
						        onClick="history.go(-1)">취소</button>
					</div>
					</td>
								
				</tr>
			</tbody>
		</table>
	</div>

<script>
// 배송지 등록
	$(document).ready(function() {
		// 선택 버튼 클릭시 팝업창 닫기
		$(".insert_btn").click(function() {
			
			var d_no = $(".d_no").val();
			var d_cate = $(".d_cate_input").val();
			var d_name = $(".d_name_input").val();
			var d_tel = $(".d_tel_input").val();
			var d_post = $(".d_post_input").val();
			var d_address = $(".d_address_input").val();
			var d_detail_address = $(".d_detail_address_input").val();
			
			$.post("deliveryInsert.do", {
				d_no : d_no,
				d_cate : d_cate,
				d_name : d_name,
				d_tel : d_tel,
				d_post : d_post,
				d_address : d_address,
				d_detail_address : d_detail_address
			}, function(result) {
			 	if(result==1){
					alert("배송지가 등록되었습니다.");
					opener.document.location.reload();
					self.close();
			 	}
			}); //post() end
		});
	});
</script>
	
</body>
</html>