<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 상점</title>
<%-- <link rel="stylesheet" href="${path}/css/reset.css"> --%>
	<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css">
	<link rel="stylesheet" href="${path}/css/swiper.css">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
<style>
input[type="checkbox"]{
	margin-top:28px;
	zoom:1.3;
	accent-color : #218838;
}
</style>	
</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="../common/menuMyPage.jsp"%>
</header>


<div class="container" align=center>
   	<div class="vf-wide500-card">
		<div class="row qnas" style="text-align: center;">
			<h2 class="page-header">
				<img src="${path}/images/house-heart.svg" style="width:30px; height:30px; margin-bottom:5px;">
				<label>팔로우 상점</label>
				<label style="font-size:13px; margin-bottom:5px; margin-left:5px;">총 ${total}개</label>
			</h2>
			
			<!-- 팔로우 상점에 등록된 상점이 없는 경우  -->
			<c:if test="${empty followList}">
				<div style="margin-top: 50px; margin-bottom:50px; ">
                     <img src="${path}/images/house-heart.svg" style="width:60px; height:60px; margin-bottom:20px;"> <br> 
					 <label style="font-size:20px;" > 
					 	팔로우 상점이 없습니다.</label><br>
				                 상품정보 페이지에서 추가해 보세요.<br>
				     	<a href="main.do" class="goShoping_btn btn btn-success" style="margin-top:20px;margin-bottom: 50px;">쇼핑하러 가기</a>  					
				</div>         
			    
 			</c:if>
 				
 			<!-- 팔로우 상점에 등록된 상점이 있는 경우 -->
			<c:if test="${not empty followList}">
			
			<!-- 팔로우 상점 리스트 -->
			<table class="table" style=" margin: auto; border-bottom: 1px solid #D5D5D5; width:90%">
				<thead>	
					<tr>
						<th colspan="3">
							<!-- 한번에 전체 상품을 체크하는 체크박스 -->
							<input type="checkbox" class="allCheck_input" name="check" checked="checked" style="margin-right:5px;">
						</th> 
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fl" items="${followList}" >
						<tr>
							<td class="follow_info_td">
								<!-- 개별 체크박스 -->
								<input type="checkbox" class="chkbox_input_${fl.s_no}" name="check" checked="checked" value="${fl.f_no}">
								<input type="hidden" class="s_no_input" name="s_no" value="${fl.s_no}">
								<input type="hidden" class="f_no_input" name="f_no" value="${fl.f_no}">
								<img src="${path}/images/shop.png" style="width:30px; height:30px; margin-bottom:7px; margin-left:10px;">
								<a href="${path}/productSearchList.do?pageNum=1&search=s_name&keyword=${fl.s_name}">
								<label style="font-size:20px; margin-left:5px;">${fl.s_name}</label></a> 
							</td>
							
							<td class="table_text_align_center">
								<input type="hidden" name="f_no" value="${fl.f_no}">
								<button class="delete_btn btn btn-default" data-f_no="${fl.f_no}"
								         style="float:right;">삭제</button>
							</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		<div class="row" style="text-align:center; margin-bottom:70px; margin-top:30px;">
			<button class="btn btn-success shoping_btn">쇼핑하러 가기</button>
			<button class="btn btn-success allDelete_btn">전체삭제</button>
		</div>
		</c:if>
      </div>
    </div>
</div>
	<!-- 삭제 form -->
    <form action="followDelete.do" method="post" class="delete_form">
 		<input type="hidden" name="f_no" class="delete_f_no">
    </form>

<script>

	// 쇼핑계속하기 버튼
	$(".shoping_btn").on("click", function(){
		location.href="main.do"
	});
	
	// 팔로우 상점 개별 삭제 버튼
	$(".delete_btn").on("click",function(e){
		e.preventDefault();
		const f_no = $(this).data("f_no");
		$(".delete_f_no").val(f_no);
		$(".delete_form").submit();
	});
	
	// 팔로우 상점 전체삭제 버튼
	$(".allDelete_btn").on("click",function(){
		var check = confirm("팔로우 상점을 전부 삭제하시겠습니까?");
		if(check){
			location.href="allFollowDelete.do";
		}
	})
</script>	
<script>		
$(function(){
    $("[type=checkbox][name=check]").on("change", function(){
        var check = $(this).prop("checked");
        //전체 체크
        if($(this).hasClass("allCheck_input")){
            $("[type=checkbox][name=check]").prop("checked", check);

        //단일 체크
        }else{ 
            var all = $("[type=checkbox][name=check].allCheck_input");
            var allcheck = all.prop("checked")
            if(check != allcheck){ 
                var len = $("[type=checkbox][name=check]").not(".allCheck_input").length;
                var ckLen = $("[type=checkbox][name=check]:checked").not(".allCheck_input").length;
                if(len === ckLen){ 
                    all.prop("checked", true);
                }else{
                    all.prop("checked", false);
                }
            }
        }
    });
});
</script>

<footer>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>	
</footer>

</body>
</html>