<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세페이지</title>
<script type="text/javascript">
	$(function() {
		$('#reviewlist').load('${path}/productReviewList.do?p_no=${product.p_no}');
 		$('#slist').load('${path}/qnaMainList.do?search=p_no&keyword=${product.p_no}') 

	});
</script>

<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"> 
<link rel="stylesheet" href="${path}/css/swiper.css">

</head>
<body>
<%@ include file="../common/header.jsp"%>

<div class="container" align="center">
	<div class="vf-left">
		<div  style="width:380px; height:380px; overflow: hidden; padding:0px">
			<div class="swiper-container gallery-top">
				<div class="swiper-wrapper">
					<c:forEach var="p" items="${listImg}">
					<div class="swiper-slide"><div class="swiper-slide-container"><img src="${path}/upload/product/${p.p_img}" width=380px></div></div>
					</c:forEach>
			    </div>
			    <div class="swiper-pagination pagination_bullet"></div>
			    <div class="swiper-pagination pagination_progress"></div>
			</div>
		</div>
	</div>
	<div class="vf-right">
		<table class="table" style="font-size:15px; margin:0px;">
			<tr>
				<td style="font-size:15px;">
					<a href="${path}/productSearchList.do?pageNum=1&search=s_name&keyword=${product.s_name}">
						[${product.s_name}]</a>&nbsp;&nbsp;&nbsp;
					<a href="${path}/followInsert.do?s_no=${product.s_no}"><img src="${path }/images/house-heart.svg" id="follow" alt="상점을 팔로잉하세요~" height=30px></a></td>
			</tr>
			<tr>
				<td>
					<font style="font-size:20px;">${product.p_name}</font>&nbsp;&nbsp;
					<a href="${path}/loveInsert.do?p_no=${product.p_no}">>>관심상품 등록</a></td>
			</tr>
			<tr>
				<td>
					<font>일반 구매가 : ${product.p_sell_price}원</font><br>
					<c:if test="${product.p_follow_sale == 'Y'}">
						<b>팔로워 할인가 : <font style="font-size:20px;"> ${product.p_follow_price}원</font> </b><br>
						<font color=blue size=2>팔로잉하고 팔로워 할인가로 구매하세요 
						<a href="${path}/followInsert.do?s_no=${product.s_no}">>>팔로잉하기</a></font><br>
						<font size=2>※ 팔로워 할인을 받으려면 "팔로워상품담기"버튼을 클릭하셔야 합니다.</font> <br>
					</c:if>
					<c:if test="${product.p_group_buying == 'Y'}"> 
						<b>공동구매가 : <font style="font-size:20px;">${product.p_group_price}원</font></b><br>
						<font color=red size=2>공동구매로 더 저렴하게 구매하세요</font>
					</c:if>
			</tr>
			<tr>
				<td align=left>배송비 : 3000원 (3만원 이상 무료배송)</td>
			</tr>
			<tr>
				<td class="cart_qty_td" align="left">
					<!-- 재고가 없을 경우 -->
					<c:if test="${product.p_stock < 1}">
						해당 제품이 품절되었습니다 .
					</c:if>
					<c:if test="${product.p_stock > 0}">
					<!-- 구매수량 변경 -->
			    	<div class="table_text_align_center cart_qty_div" style="display:flex; margin:0;">
						<label style="margin-top:5px;">구매 수량 :</label> 
					   	<button class="minus_btn btn btn-default" style="margin-left:10px;">-</button>
						<input type="text" class="cart_qty form-control" value="1" style="width:55px;">
					   	<button class="plus_btn btn btn-default">+</button>
					</div>
					</c:if>
				</td>
			</tr>
			<tr>
				<td align=center>
				<c:if test="${product.p_stock < 1}">
					<a href="${path}/restockInsert.do?p_no=${product.p_no}" class="btn btn-success">재입고 신청하기</a>
				</c:if>
				<c:if test="${product.p_stock > 0}">
					<a class="order_btn btn btn-success" style="width:90px; height:45px; font-size:12px; padding:4px; margin:2px;">
                  		    <b>${product.p_sell_price}원<b><br>바로 구매하기</a>
                  	<c:forEach var="followShop" items="${followShop}">	    
					<c:if test="${product.s_no == followShop.s_no and followShop.m_email eq sessionScope.m_email and product.p_follow_sale == 'Y'}">
					<a  class="follow_btn btn btn-warning" style="width:90px; height:45px; font-size:12px; padding:4px; margin:2px;">
						<b>${product.p_follow_price}원<b><br>팔로워상품담기</a>
					</c:if>
					</c:forEach>
					<c:if test="${product.p_group_buying == 'Y'}"> 
					<a class="group_btn btn btn-danger" class="btn btn-danger" style="width:90px; height:45px; font-size:12px; padding:4px; margin:2px;">
						<b>${product.p_group_price}원<b><br>공동구매하기</a>
					</c:if>
					<a class="cart_btn btn btn-outline-success" style="width:90px; height:45px; font-size:12px; padding:4px; margin:2px;">
                           <b>${product.p_sell_price}원<b><br>장바구니담기</a>
                </c:if>
				</td>
			</tr>
			<c:if test="${group != null and product.p_stock > 0}">
			<c:forEach var = "group" items="${group }">
			<tr>
				<td>
					<table width=380px align=center>
						<tr>
							<td><b>${group.m_email }</b></td>
							<td align=right width=60px style=" font-size:13px;"><font style="color:red;">1명</font> 남음</td>
							<td align="center" width=150px>						
								<a href="javascript:order(${group.op_no}, 2)" class="btn btn-danger">
									<b>함께 공동구매 하기</b>
								</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			</c:forEach>
			</c:if>
		</table>
	</div>
</div>
<div class="container" align="center">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" href="#home"><b>&nbsp;&nbsp;&nbsp;&nbsp;상품상세설명&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu1"><b>&nbsp;&nbsp;&nbsp;&nbsp;구매 후기&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu2"><b>&nbsp;&nbsp;&nbsp;&nbsp;문의 게시판&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
    </li>
  </ul>
  <!-- Tab panes -->
  <div class="tab-content">
    <div id="home" class="container tab-pane active" style="width:100%; padding: 0px;"><br>
		<div class="vf-card" height=100px style="border-style: double; border-color: gray; border-radius: 10px;">
			${product.p_detail }
		</div>
    </div>
    <div id="menu1" class="container tab-pane fade" style="width:100%; padding: 0px;">
 		<div id="reviewlist"></div>
    </div>
    <div id="menu2" class="container tab-pane fade" style="width:100%; padding: 0px;">
		<div id="slist"></div>
	</div>
  </div>
</div>


<!-- 주문 form -->
<form action="order.do" method="get" class="order_form">
	<input type="hidden" name="orders[0].p_no" value="${product.p_no}">
	<input type="hidden" name="orders[0].cart_qty" value="">
	<input type="hidden" name="orders[0].op_type" value="">
	<input type="hidden" name="orders[0].group_op_no" value="">
	<input type="hidden" name="orders[0].group_order" value="">
</form>
	
</div>

<br><br><br>
<%@ include file="../common/footer.jsp"%>
</body>
</html>

<script>
	// 구매 수량 버튼 
	$(".plus_btn").on("click", function(){
		let qty = parseInt($(this).parent("div").find("input").val());
		let p_stock = parseInt(${product.p_stock});
		$(this).parent("div").find("input").val(++qty);
		// 상품 재고 유효성 검사
		if(qty > p_stock){
			alert("재고가 없습니다. 선택할 수 있는 최대 상품 수량은 "+p_stock+"개 입니다.");
			$(".cart_qty").val(1);
		}
	});
	$(".minus_btn").on("click", function(){
		let qty = parseInt($(this).parent("div").find("input").val());
		if(qty > 1){
		$(this).parent("div").find("input").val(--qty);
		}	
	});
				
	// 바로 구매하기 버튼
	$(".order_btn").on("click", function(){
		var cart_qty = $(".cart_qty").val();
		var op_type = "1"; 
		$(".order_form").find("input[name='orders[0].cart_qty']").val(cart_qty);
		$(".order_form").find("input[name='orders[0].op_type']").val(op_type);
		$(".order_form").find("input[name='orders[0].group_op_no']").val(0);
		$(".order_form").find("input[name='orders[0].group_order']").val(1);
		$(".order_form").submit();
	});	
	
	// 공동 구매 버튼 클릭 시
	$(".group_btn").on("click", function(){
		var cart_qty = $(".cart_qty").val();
		var op_type = "3"; 
		$(".order_form").find("input[name='orders[0].cart_qty']").val(cart_qty);
		$(".order_form").find("input[name='orders[0].op_type']").val(op_type);
		$(".order_form").find("input[name='orders[0].group_op_no']").val(0);
		$(".order_form").find("input[name='orders[0].group_order']").val(1);
		$(".order_form").submit();
	});
	
	// 공동 구매 두 번째 주문 (첫 번째 사람 op_no 가지고 감)
 	function order(group_op_no, group_order){
		var cart_qty = $(".cart_qty").val();
		var op_type = "3";
		$(".order_form").find("input[name='orders[0].cart_qty']").val(cart_qty);
		$(".order_form").find("input[name='orders[0].op_type']").val(op_type);
		$(".order_form").find("input[name='orders[0].group_op_no']").val(group_op_no);
		$(".order_form").find("input[name='orders[0].group_order']").val(group_order);
		$(".order_form").submit();
	}
		
	$(document).ready(function(){

		// 장바구니 담기 버튼
		$(".cart_btn").click(function(){
			var p_no = ${product.p_no};
			var cart_qty = $(".cart_qty").val();
			var op_type = "1";
			
 			$.post("cartInsert.do",
				{ "p_no" : p_no, 
				  "cart_qty" : cart_qty, 
				  "op_type": op_type      },
				function(result){
			       if(result.trim() == 'success'){
			           var check = confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?");
					   if(check) { 
						  location.assign("cartList.do");
						}else{
						  return false;
						}
			        }else if(result.trim() == 'existed'){
			            alert("이미 장바구니에 등록된 상품입니다.");
			        }
			}); // post() end */
		});	
		
		// 팔로우 구매 버튼
		$(".follow_btn").click(function(){
			var p_no = ${product.p_no};
			var cart_qty = $(".cart_qty").val();
			var op_type = "2";
			
 			$.post("cartInsert.do",
				{ "p_no" : p_no, 
				  "cart_qty" : cart_qty, 
				  "op_type": op_type      },
				function(result){
			       if(result.trim() == 'success'){
			           var check = confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?");
					   if(check) { 
						  location.assign("cartList.do");
						}else{
						  return false;
						}
			        }else if(result.trim() == 'existed'){
			            alert("이미 장바구니에 등록된 상품입니다.");
			        }
			}); // post() end */
		});
	});

</script>
<script src="${path}/js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
<script>
	// 상품사진 슬라이스 부분
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