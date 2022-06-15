<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(function() {
		$('#slist').load('${path}/slist.do?num=${board.num}')

		$('#repInsert').click(function() {
			if (!frm.replytext.value) {
				alert('댓글 입력후에 클릭하시오');
				frm.replytext.focus();
				return false;
			}
			var frmData = $('form').serialize();
			// var frmData = 'replyer='+frm.replyer.value+'&bno='+
			//				  frm.bno.value+'&replytext='+frm.replytext.value;				  
			$.post('${path}/sInsert.do', frmData, function(data) {
				$('#slist').html(data);
				frm.replytext.value = '';
			});
		});
	});
</script>
<%-- 	<link rel="stylesheet" href="${path}/css/reset.css"> --%>
 	<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"> 
	<link rel="stylesheet" href="${path}/css/swiper.css">


</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuAdmin.jsp"%>
	<div class="container" align="center">
		<div class="vf-left">
			<div  style="width:100%; height:325px; overflow: hidden;">
				<div class="swiper-container gallery-top">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><div class="swiper-slide-container">Slide 1</div></div>
						<div class="swiper-slide"><div class="swiper-slide-container">Slide 2</div></div>
						<div class="swiper-slide"><div class="swiper-slide-container">Slide 3</div></div>
						<div class="swiper-slide"><div class="swiper-slide-container">Slide 4</div></div>
				        <div class="swiper-slide"><div class="swiper-slide-container">Slide 5</div></div>
				    </div>
				    <div class="swiper-pagination pagination_bullet"></div>
				    <div class="swiper-pagination pagination_progress"></div>
				</div>
			</div>
		</div>
		<div class="vf-right">
		<table class="table">
			<tr>
				<td>제목</td>
				<td>${board.subject}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${board.writer}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${board.readcount}</td>
			</tr>
			<tr>
				<td>아이피</td>
				<td>${board.ip}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${board.email}</td>
			</tr>

		</table>
		<a href="${path}/list.do?pageNum=${pageNum}" class="btn btn-success">목록</a>
		<a href="${path}/updateForm.do?num=${board.num}&pageNum=${pageNum}" class="btn btn-success">수정</a>
		<a href="${path}/deleteForm.do?num=${board.num}&pageNum=${pageNum}" class="btn btn-success">삭제</a> <a
			href="${path}/insertForm.do?nm=${board.num}&pageNum=${pageNum}" class="btn btn-success">답변</a>
		<p>
		</div>
		<div class="vf-card">
			<form name="frm" id="frm">
				<input type="hidden" name="replyer" value="${board.writer}">
				<input type="hidden" name="bno" value="${board.num}"> 
				<table width=100%>
					<tr>
						<td>내용</td>
						<td><pre>${board.content}</pre></td>
					</tr>
					<tr>
						<td width=50>댓글 :</td>
						<td><textarea rows="3" cols="50" name="replytext" style="background-color: lightyellow;" class="form-control"></textarea></td>
						<td width=60 align=right><input type="button" class="btn btn-success" value="확인" id="repInsert"></td>
					</tr>
				</table>	
			</form>
			</div>
		</div>
		<div id="slist" height=500px></div>
	</div>

<%@ include file="../common/footer.jsp"%>
</body>
</html>
<script src="${path}/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
<script>
	var galleryTop = new Swiper('.gallery-top', {
    	spaceBetween: 10,   //슬라이드 간격
        pagination: {   //페이징 사용자 설정
        	el: ".pagination_bullet",   //페이징 태그 클래스 설정 
            clickable: true,    //버튼 클릭 여부
            type : 'bullets',   //페이징 타입 설정(종류: bullets, fraction, progressbar)   
            // Bullet Numbering 설정
        	renderBullet: function (index, className) {
        		return '<span class="' + className + '">' + (index + 1) + "</span>";
        	},
		},
    });

    //progress Bar
	var pagingSwiper = new Swiper(".gallery-top", {
		pagination: {
			el: ".pagination_progress",
			type: "progressbar",
		},
	});

    //Main Swiper로 progress Bar 제어
    galleryTop.controller.control = pagingSwiper;
</script>