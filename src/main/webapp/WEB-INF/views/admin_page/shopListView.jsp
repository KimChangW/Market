<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상점 정보 보기</title>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuAdmin.jsp"%>
<div class="container"  align="center">
		<form id="shop_info" name="shop_info" enctype="multipart/form-data" >
			<!--  <input type="hidden" id="s_status" name="s_status" value="1"> -->
			<input type="hidden" id="s_seckey" value="${shop.s_seckey}">
			
			<h3 class="text-primary">상점 정보</h3>
			
			<table class="table">
				<tr>
					<th>email</th>
					<td>
					${shop.s_email}
					</td>
					<td rowspan="6" align="center" style="width: 416px;">
						<center><b>프로필</b></b></center>
						<img src="${path}/upload/shop/${shop.s_profile}" height="300" width="300" style="margin-bottom: 8px;" />
					</td>
				</tr>
				
				<tr>
					<th>상호명</th>
					<td>${shop.s_name}</td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td>${shop.s_ceo}</td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td>${shop.s_bizno}</td>
				</tr>
				<tr>
					<th>통신판매업번호</th>
					<td>${shop.s_tongsin}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>${shop.s_post}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${shop.s_address}</td>
					<td rowspan="5" align="center">
					<%-- <input type="button" id="button" value="상점정보수정" class="btn btn-success" onClick="location.href='${path}/shop_info_edit_form.do?s_no=${shop.s_no}'">
					<input type="button" id="button" value="페점신청" class="btn btn-danger" onClick="location.href='${path}/shop_del_form.do?s_no=${shop.s_no}'"> --%>
				 	<center><b>상점소개</b></center><br>
					${myself}
					</td> 
				 	</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${shop.s_tel}</td>
					<%-- <td rowspan="4" align="center" style="width:400px;">
					<center>상점소개</center>
					${myself}
					</td> --%>
				</tr>
				<tr>
					<th>은행명</th>
					<td>${shop.s_bank}</td>
				</tr>
				<tr>
					<th>정산계좌</th>
					<td>${shop.s_account}</td>
				</tr>
				<tr>
					<th>서류첨부</th>
					<td>
						<c:if test="${empty shop.s_file}">
       					&nbsp;
       					</c:if> 
       					<c:if test="${!empty shop.s_file}">
						<img src="${path}/upload/shop/${shop.s_file}" height="100" width="100" />
						</c:if> 
					</td>
				</tr>
				<%-- <tr>
					<td colspan="2" align="center">
					<input type="button" id="button" value="상점정보수정" class="btn btn-success" onClick="location.href='${path}/shop_info_edit_form.do?s_no=${shop.s_no}'">
					<input type="button" id="button" value="페점신청" class="btn btn-danger" onClick="location.href='${path}/shop_del_form.do?s_no=${shop.s_no}'">
				 	</td>
				</tr> --%>

			</table>

		</form>
	</div>
<%@ include file="../common/footer.jsp"%>	
</body>
</html>