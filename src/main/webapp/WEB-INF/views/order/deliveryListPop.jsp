<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 선택</title>

<style>
 .insert_btn{
 	margin:auto;
	display:block; 	
 }
 .update_btn,.delete_btn{
 	margin-left:2px;
 }
 .insert_btn{
 	margin-top: 40px;
 }
 #truck{
 	width: 100px;
 	margin-left:288px;
 	margin-top: 150px;  
 }
 .page-header{
	text-align:center;
	
 }
 #d_cate_div{
 	margin-left: 30px; 
 }
</style>

</head>

<body>

	<div class="container">
		<!-- 저장된 주소지가 있는 경우 -->
		<c:if test="${not empty deliveryList}">
			<table class="table">
				<h2 class="page-header">주소 목록</h2>
				<thead>
					<tr>
						<th>구분</th>
						<th>주소</th>
						<th>연락처</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dl" items="${deliveryList }">
						<tr>
							<td>
							<div id="d_cate_div">
							<label style="font-size: 18px;">${dl.d_cate}</label> 
							<c:if test="${dl.d_default == 'Y'}">
									<label style="color: #218838">[기본 배송지]</label>
								</c:if> <br> ${dl.d_name}</td>
							</div>	
							<td>${dl.d_post} <br> ${dl.d_address} <br>
								${dl.d_detail_address}
							</td>
							<td>${dl.d_tel}</td>
							<td>
							<div style="display:flex;">
								<input type="hidden" class="d_no" name="d_no" value="${dl.d_no}">
								<c:if test="${dl.d_default == 'N'}">
									<button type="button" class="select_btn btn btn-success" onClick="select_check(${dl.d_no});" >선택</button>
								</c:if>
								<button type="button" class="update_btn btn btn-outline-success" onClick="update_check(${dl.d_no});">수정</button>
								<button type="button" class="delete_btn btn btn-outline-success" onClick="delete_check(${dl.d_no});">삭제</button>
							</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty deliveryList}">
			<div class="table_empty">
				<img src="${path}/images/delivery-truck.png" id="truck"> <br>
				<label style="font-size: 22px; margin-top: 2px; margin-left: 32%">등록된
					주소지가 없습니다.</label>
			</div>
		</c:if>
	</div>
	
	<div>
		<button type="button" class="insert_btn btn btn-success">새로운 주소 등록하기</button>
	</div>

	<script>
		// 배송지 선택 버튼
 		function select_check(n){	
//			alert(n);
			// 선택 버튼 클릭시 팝업창 닫기
			$.post("updateDefaultAddr.do", {
				"d_no" : n
			}, function() {
				opener.document.location.reload();
				self.close();
			}); //post() end
		}
		
	    // 배송지 삭제 버튼
		function delete_check(n){
			var check = confirm("해당 배송지를 삭제하시겠습니까?");
			if(check){
				$.post("deliveryDelete.do", {
						"d_no" : n
				}, function(result) {
	//				alert(result);
					if(result==1){
						location.reload();
					}
				}); //post() end
			}else{
				return false;
			}	
		}
		// 배송지 수정 버튼
		function update_check(n){	
//			alert(n);
			location.href="deliveryUpdateForm.do?d_no="+n;
		}
	    
		// 배송지 등록 버튼
		$(".insert_btn").on("click",function(){
			location.href="deliveryInsertForm.do";
		});
		
	</script>


</body>
</html>