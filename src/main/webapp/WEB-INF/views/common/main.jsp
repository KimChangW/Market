<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 댓글 게시판 불러오기 -->
	<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css">
	<link rel="stylesheet" href="${path}/css/swiper.css">
</head>
<body>
<%@ include file="header.jsp"%>

<div class="container" align="center">
	<div class="slide" style="width:100%; height:220px; overflow: hidden;">
		<div class="swiper-container gallery-top">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event7.PNG" width=100%></div></div>
				<div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event6.PNG" width=100%></div></div>
				<div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event5.PNG" width=100%></div></div>
				<div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event4.PNG" width=100%></div></div>
		        <div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event3.PNG" width=100%></div></div>
		        <div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event2.PNG" width=100%></div></div>
		        <div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/images/event1.PNG" width=100%></div></div>
		    </div>
		    <div class="swiper-pagination pagination_bullet"></div>
		    <div class="swiper-pagination pagination_progress"></div>
		</div>
	</div>	
</div>

	<!-- 상품진열 -->
<div class="container" align="center">
	<a href="${path}/productSearchList.do?search=p_follow_sale&keyword=Y" style="text-decoration: none"><h3><b>follow 특가 ></b></h3></a>
	<c:forEach var="p" items="${flist }">
			<div class="vf_product" style="float: left;">
				<table style="font-size:14px;" height=230px>
					<tr>
						<td style="padding:9px">
							<a href="${path }/productView.do?p_no=${p.p_no}">
							<img src="${path}/upload/product/${p.p_img}" width=210px height=210px></a></td>
					</tr>
					<tr>
						<td style="padding:0 9 9 9; height:80px;">
						<a href="${path}/productSearchList.do?pageNum=1&search=s_name&keyword=${p.s_name}">[${p.s_name}]</a><br>
						<b>${p.p_name}</b><br>
						일반구매가 : ${p.p_sell_price}원<br>
						<font color=blue>팔로워특가 : ${p.p_follow_price}원</font></td>
					</tr>
				</table>
			</div>
	</c:forEach>
</div>

<div class="container" align="center">
	<a href="${path}/productSearchList.do?search=p_group_buying&keyword=Y" style="text-decoration: none"><h3><b>공동구매 특가 ></b></h3></a>
	<c:forEach var="p" items="${glist }">
			<div class="vf_product" style="float: left;">
				<table style="font-size:14px;">
					<tr>
						<td style="padding:9px">
							<a href="${path }/productView.do?p_no=${p.p_no}">
							<img src="${path}/upload/product/${p.p_img}" width=210px height=210px></a></td>
					</tr>
					<tr>
						<td style="padding:0 9 9 9; height:80px;">
						<a href="${path}/productSearchList.do?pageNum=1&search=s_name&keyword=${p.s_name}">[${p.s_name}]</a><br>
						<b>${p.p_name}</b><br>
						일반구매가 : ${p.p_sell_price}원<br>
						<font color=red>공동구매가 : ${p.p_group_price}원</font><br>
					</tr>
				</table>
			</div>
	</c:forEach>
</div>
<%@ include file="footer.jsp"%>

</body>
</html>

<!-- 이벤트 슬라이드 -->
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


