<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>

<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>
<script>
$(function(){
	
	var inputG = $("input[name='p_group_buying']:checked").val(); 
	var inputF = $("input[name='p_follow_sale']:checked").val();
	if(inputG == 'N'){
		$("#sel1").hide();
		$("#sel2").show();
	}else{
		$("#sel1").show();
		$("#sel2").hide();
	}
	if(inputF == 'N'){
		$("#sel3").hide();
		$("#sel4").show();
	}else{
		$("#sel3").show();
		$("#sel4").hide();
	}
	
	$("input[name='p_group_buying']:radio").change(function(){
		var c = this.value;
		if(c == 'N'){
			$("#sel1").hide();
			$("#sel2").show();
		}else{
			$("#sel1").show();
			$("#sel2").hide();
		}
	});
	
	$("input[name='p_follow_sale']:radio").change(function(){
		var d = this.value;
		if(d == 'N'){
			$("#sel3").hide();
			$("#sel4").show();
		}else{
			$("#sel3").show();
			$("#sel4").hide();
		}
	});
	
});

</script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuShop.jsp"%>

	<div class="container" align="center">
	
		<h3 class="text-primary">상품 수정</h3>
		<div class="vf-card">
		<form action="${path}/productUpdate.do" method="post">
			<input type="hidden" name="p_no" value="${product.p_no}">
			<input type="hidden" name="s_no" value="${product.s_no}">

			
			<table class="table">
				<tr>
					<td>상품상태</td>
					<td>
						<select id="p_status" name="p_status" style="width:180px; height:30px">
							<option value="1"
								<c:if test="${product.p_status == '1'}">selected</c:if>
							>판매중</option>
							<option value="2"
								<c:if test="${product.p_status == '2'}">selected</c:if>
							>일시판매중지</option>
							<option value="3"
								<c:if test="${product.p_status == '3'}">selected</c:if>
							>판매완료</option>
							<option value="5"
								<c:if test="${product.p_status == '5'}">selected</c:if>
							>상품삭제</option>
						</select> 
						<c:if test="${product.p_status == '4'}">판매정지</c:if>
					</td>
				</tr>
				<tr>
					<td width=130px>카테고리코드</td>
					<td>
						<select id="cate_no" name="cate_no" style="width:180px; height:30px">
							<c:forEach var="c" items="${listCateNo}">
								<option value="${c.cate_no}"
								<c:if test="${product.cate_no == c.cate_no}">selected</c:if>
								>${c.cate_large}/${c.cate_small}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>상품명</td>
					<td><input type="text" name="p_name" id="p_name" width="400px" required="required"
							value="${product.p_name}"></td>
				</tr>
				<tr>
					<td>일반구매가격</td>
					<td><input type="text" name="p_sell_price" required="required"
							value="${product.p_sell_price}"></td>
				</tr>
				<tr>
					<td>재고</td>
					<td><input type="text" name="p_stock" required="required"
							value="${product.p_stock}"></td>
				</tr>
				<tr>
					<td>공동구매여부</td>
					<td>
						<input type="radio" name="p_group_buying" value="Y"
						<c:if test="${product.p_group_buying eq 'Y'}">checked</c:if>/>Y
						<input type="radio" name="p_group_buying" value="N"
						<c:if test="${product.p_group_buying eq 'N'}">checked</c:if>/>N
					</td>
				</tr>
				<tr>
					<td>공동구매가</td>
					<td>
						<div id= "sel1">
							<input type="text" name="p_group_price" required="required"
									value="${product.p_group_price}">
						</div>
						<div id = "sel2" style="font-family:나눔고딕; font-size:12; color:darkred">
							※공동구매가는 공동구매여부가 'Y'일 경우에만 입력가능합니다.
						</div>	
					</td>
				</tr>
				<tr>
					<td>팔로워할인여부</td>
					<td>
						<input type="radio" name="p_follow_sale" value="Y"
						<c:if test="${product.p_follow_sale eq 'Y'}">checked</c:if>/>Y
						<input type="radio" name="p_follow_sale" value="N"
						<c:if test="${product.p_follow_sale eq 'N'}">checked</c:if>/>N
					</td>
				</tr>
				<tr>
					<td>팔로워할인가</td>
					<td>
						<div id= "sel3">
							<input type="text" name="p_follow_price" required="required"
									value="${product.p_follow_price}">
						</div>
						<div id = "sel4" style="font-family:나눔고딕; font-size:12; color:darkred">
							※팔로워할인가는 팔로워할인여부가 'Y'일 경우에만 입력가능합니다.
						</div>
					</td>
				</tr>
				<tr>
					<td>상세설명</td>
					<td>
						<textarea rows="5" cols="30" name="p_detail" required="required">${product.p_detail}</textarea>
	                      <script>
	                      		CKEDITOR.replace('p_detail',{filebrowserUploadUrl:'${path}/market/fileUpload.do'});
	                      </script>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정" class="btn btn-success">
						<input type="reset" value="취소" class="btn btn-outline-success"
    						onclick="$('#p_status').focus();" />
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>