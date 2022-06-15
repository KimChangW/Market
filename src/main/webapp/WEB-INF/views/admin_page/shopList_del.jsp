<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function shopList_del(){
	
	var arrdel = new Array();
	 $("input:checkbox[name=s_email]:checked").each(function() {
	    	arrdel.push($(this).val());
	 });
	 if(arrdel == null || arrdel.length == 0){
	        alert("강제 폐점할 항목을 선택해주세요.");
	        return false;
	    }
	 var delalert = confirm("폐점하시겠습니까?");
	    if(delalert){
	    	
	    	 alert(arrdel);
	        $.ajax({
	            type: "POST",
	        	url: "shopList_del.do",
	            data: {"arrdel": arrdel },
	            //dataType: "json",
	            //contentType:"application/json; charset=utf-8", 
	            success: function(data){
	               // alert(data);
	                if(data==1){
	                	alert("강제폐점 되었습니다.");
	               	 	location.href="shopListdel.do";
	                }
	            },error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }


	           // ,error: function(e){alert("서버통신 오류"+e);}
	        });
	    }


}

</script>
<!-- <script>
	$(document).ready(function(){
		
		$("#shopList").load("shopList.do");
	});

</script> -->

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuAdmin.jsp"%>
<!-- <div id="shopList"></div> -->
<!-- <div class="shopList_exit vf-wide700-card" style="width: 1200px; overflow-y:scroll;"> -->
<div class="container" align="center">
<center><h2>강제폐점</h2></center>
<table class="table">
		<tr>
			<th>선택</th>
			<th>email</th>
			<th>상호명</th>
			<th>대표자명</th>
			<!-- <th>사업자번호</th>
			<th>통신판매업번호</th>
			<th>서류첨부</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>은행명</th>
			<th>정산계좌</th> -->
			<th>가입일</th>
			<th>상태</th>
		</tr>
	
	<c:forEach var="shopdel" items="${shoplist1}">
		
		<tr>
			<td>
		    <input type="checkbox" id="checkbox" name="s_email" value="${shopdel.s_email}">
		    </td>
		 	<td><a href="shopListView.do?s_email=${shopdel.s_email}" style="text-decoration:none;">${shopdel.s_email}</a></td>
		 	<td>${shopdel.s_name}</td>
		 	<td>${shopdel.s_ceo}</td>
		 	<%-- <td>${shopdel.s_bizno}</td>
		 	<td>${shopdel.s_tongsin}</td>
		 	<td>${shopdel.s_file}</td>
		 	<td>${shopdel.s_post}</td>
		 	<td>${shopdel.s_address}</td>
		 	<td>${shopdel.s_tel}</td>
		 	<td>${shopdel.s_bank}</td>
		 	<td>${shopdel.s_account}</td> --%>
		 	<td>
		 	<fmt:formatDate value="${shopdel.s_regdate}" pattern="yy-MM-dd"/>
		 	</td>
		 	<td>${shopdel.s_status}</td>
		</tr>
		
	
	</c:forEach>
</table>

<div class="shopList_ck" align="center" style="display:flex; align-items:center;">
<div class="check" style="margin-left:20px;">
<input type="button" id="button" value="강제폐점" class="btn btn-danger" onclick="shopList_del()">
</div>
<ul class="pagination" style="margin-left:43%;">
			
		<c:if test="${pp1.startPage > pp1.pagePerBlk }">
			<li><a href="${path}/shopListdel.do?pageNum=${pp1.startPage - 1}">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${pp1.startPage}" end="${pp1.endPage}">
			<li <c:if test="${pp1.currentPage == i}">class="active"</c:if>>
			<a href="${path}/shopListdel.do?pageNum=${i}">${i}</a></li>
		</c:forEach>
		<c:if test="${pp1.endPage < pp1.totalPage}">
			<li><a href="${path}/shopListdel.do?pageNum=${pp1.endPage + 1}">다음</a></li>
		</c:if>
		 
</ul>
</div>	



</div>
</body>
</html>