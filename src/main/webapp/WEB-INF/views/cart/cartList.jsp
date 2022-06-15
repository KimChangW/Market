<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<%-- <link rel="stylesheet" href="${path}/css/reset.css"> --%>
	<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css">
	<link rel="stylesheet" href="${path}/css/swiper.css">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
<style>
.minus_btn,.plus_btn{
	margin-top:35px;
	outline:none;
	height:33px;
}
#cart_qty_input{
	width:55px;
	margin-top:35px;
	margin-right:0;	
}
.qty_modify_btn{
	margin-top:35px;
	margin-left:2px;
	height:33px;
}
input[type="checkbox"]{
	margin-top:28px;
	zoom:1.3;
	accent-color : #218838;
}
.order_btn{
	float:right;
	margin-right:50px; 
}
#d_msg{
	color:green; 
	font-size:13px;
	margin-left:20px; 
}
#truck{
	 width:30px; 
	 height:30px;
	 margin-right:5px;
	 margin-left: 10px;
}
.price_div{
	float:left;
	text-align:left;
	font-size:15px; 
	background:#f9f9f9;
	padding :10px 0px 10px 15px;
	width: 100%
}
.totalPrice_div{
	width:80%;
	font-size:16px;
	font-weight:bold;
	margin-left:30px;
	margin-top:20px; 
}
.order_btn_div{
	float:right;
	width:20%;
}
.goShoping_div{
	margin-top:100px;
	margin-bottom: 100px;
}
#line{
	text-decoration:line-through;
	color:#bcbcbc;
}
#following{
	float:right;
	margin-top:40px;
}
#follow_sale{
	color:red; 
	font-size:13px;
	margin-bottom:1px;
}
#p_info_div{
	margin-top:28px;
}



</style>	



</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
</header>


   <div class="container">
		<div class="row qnas" style="text-align: center;">
			<h2 class="page-header"><label>장바구니</label></h2>
			
			<!-- 장바구니에 등록된 상품이 없는 경우  -->
			<c:if test="${empty cartList}">
				<div style="margin-top: 50px; margin-bottom:50px; ">
                     <img src="${path }/images/icon_cart.png" style="width:60px; height:60px; margin-bottom:20px;"> <br> 
					 <label style="font-size:20px;" > 
					 	장바구니에 담긴 상품이 없습니다.</label><br>
				                 원하는 상품을 장바구니에 담아보세요!<br>
				     	<a href="main.do" class="goShoping_btn btn btn-success" style="margin-top:20px;margin-bottom: 50px;">쇼핑하러 가기</a>  					
				</div>         
			    
 			</c:if>
 				
 			<!-- 장바구니에 등록된 상픔이 있는 경우 -->
			<c:if test="${not empty cartList}">
			
			<!-- 장바구니 리스트 -->
	        <c:forEach var="sn" items="${shopNo}">
	        
<script>
$(document).ready(function(){
	itemSum(${sn.s_no});
});        	
</script>
	        
			<table class="table" style=" margin: auto; border-bottom: 1px solid #D5D5D5;mar">
				<thead>	
					<tr>
						<th colspan="6">
							<!-- 한번에 전체 상품을 체크하는 체크박스 -->
							<input type="checkbox" name="allCheck" class="allCheck_input_${sn.s_no}" id="checkbox" 
							      onclick="allCheck(${sn.s_no});" checked style="margin-right:5px;">
							<img src="${path}/images/shop.png" style="width:30px; height:30px; margin-bottom:7px;">
							<label style="font-size:20px; margin-left:5px;">${sn.s_name}</label>
	       					<c:forEach var="fl" items="${followList}">
							<c:if test="${sn.s_no eq fl.s_no}">
								<div id="following">
									<img src="${path}/images/house-heart.svg"> market
								</div>
							</c:if>
							</c:forEach> 
						</th> 
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cl" items="${cartList}" >
						<c:if test="${sn.s_no eq cl.s_no}">
						<tr>
							<td class="cart_info_td">
							<c:if test="${cl.p_stock != 0 and cl.p_status == 1}">
								<!-- 개별 체크박스 -->
								<input type="checkbox" class="chkbox_input_${sn.s_no}" name="chkbox_${sn.s_no}" checked
								       onclick="check(${sn.s_no});" value="${cl.cart_no}">
								<input type="hidden" class="p_sell_price_input" name="p_sell_price" value="${cl.p_sell_price}">
								<input type="hidden" class="cart_qty_input" name="cart_qty" value="${cl.cart_qty}">
								<input type="hidden" class="cart_no_input" name="cart_no" value="${cl.cart_no}">
								<input type="hidden" class="p_no_input" name="p_no" value="${cl.p_no}">
								<input type="hidden" class="op_type_input" name="op_type" value="${cl.op_type}">
								<input type="hidden" class="p_stock_input_${cl.cart_no}" name="p_stock" value="${cl.p_stock}">
								<input type="hidden" class="p_follow_price_input" name="p_follow_price" value="${cl.p_follow_price}">
								<!-- 일반 판매 상품 -->
								<c:if test="${cl.op_type == 1}">
									<input type="hidden" class="total_price_input" name="total_price" value="${cl.p_sell_price * cl.cart_qty}">
								</c:if>
								<!-- 팔로우 특가 상품 -->
								<c:if test="${cl.op_type == 2}">
									<input type="hidden" class="total_price_input" name="total_price" value="${cl.p_follow_price * cl.cart_qty}">
								</c:if>
							</c:if>
							</td>
							<td width=105px>
								<a href="productView.do?p_no=${cl.p_no}">
								<img src="${path}/upload/product/${cl.p_img}" width=100px></a>
							</td>
							<td align="left">
							  <div id="p_info_div">
							  <c:if test="${cl.op_type == 2}">
							  	<label id="follow_sale">※팔로우 특가※</label> <br>
							  </c:if>
								${cl.p_name} (재고 : ${cl.p_stock})<br>
								<div style="font-size:13px;">
									<!-- 일반 판매 상품 -->
									<c:if test="${cl.op_type == 1}">									
								    	<label><fmt:formatNumber pattern="#,###,###" value="${cl.p_sell_price}"/>&nbsp;원</label>
								    </c:if>
									<!-- 팔로우 특가 상품 -->
									<c:if test="${cl.op_type == 2}">									
										<label><fmt:formatNumber pattern="#,###,###" value="${cl.p_follow_price}"/>&nbsp;원 </label>
								    	<label id="line"><fmt:formatNumber pattern="#,###,###" value="${cl.p_sell_price}"/>&nbsp;원</label>
								    </c:if>
								    | ${cl.s_name} 
							    </div>
							  </div>  
							</td>
							<td>
								<!--상품 재고가 있는 경우 -->
								<c:if test="${cl.p_stock != 0 and cl.p_status == 1}"> 
								<div class="table_text_align_center cart_qty_div" style="display:flex;">
									<button class="minus_btn btn btn-default"  onClick="minus(${cl.cart_no});">-</button>
									<input type="text" name="cart_qty" value="${cl.cart_qty}" id="cart_qty_input" class="cart_qty_input_${cl.cart_no} form-control">
									<button class="plus_btn btn btn-default" onClick="plus(${cl.cart_no});">+</button>
									<button class="qty_modify_btn btn btn-default" name="qty_modify_btn_${cl.cart_no}" data-cart_no="${cl.cart_no}" onclick="update(${cl.cart_no});">변경</button>
								</div>
								</c:if>
								<!-- 품절된 상품 -->
								<c:if test="${cl.p_stock == 0 }"> 
									<label style="margin-top:35px;margin-left:40px; color:red;">품절</label>
								</c:if>
								<!-- 일시 판매 중지 -->
								<c:if test="${cl.p_status == 2 }">
									<label style="margin-top:35px;margin-left:40px; color:darkblue;">일시 판매 중지</label>
								</c:if>
								<!-- 판매완료 -->
								<c:if test="${cl.p_status == 3 }">
									<label style="margin-top:35px;margin-left:40px; color:darkblue;">판매 완료</label>
								</c:if>
								<!-- 판매 정지 -->
								<c:if test="${cl.p_status == 4 }">
									<label style="margin-top:35px;margin-left:40px; color:darkblue;">판매 정지</label>
								</c:if>
								<!-- 일시 판매 중지 -->
								<c:if test="${cl.p_status == 5 }">
									<label style="margin-top:35px;margin-left:40px; color:darkblue;">삭제된 상품</label>
								</c:if>
								
							</td >
							<td class="table_text_align_center">
							  <div style="margin-top:37px;">
							  <!-- 일반 상품 -->
							  <c:if test="${cl.op_type == 1}">	
							 	 <fmt:formatNumber value="${cl.p_sell_price * cl.cart_qty}" pattern="#,###,### 원" />
							  </c:if>
							  <!-- 팔로우 상품 -->
							  <c:if test="${cl.op_type == 2}">
							  		<fmt:formatNumber value="${cl.p_follow_price * cl.cart_qty}" pattern="#,###,### 원" />
							  </c:if>
							  </div>
							</td>
							<td class="table_text_align_center">
								<input type="hidden" name="cart_no" value="${cl.cart_no}">
								<button class="delete_btn btn btn-default" data-cart_no="${cl.cart_no}"
								         style="margin-top:35px;">삭제</button>
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			<div class="price_div">
			  <div class="totalPrice_div"  >
				 &nbsp; 결제예정금액 :
				<span class="totalPrice_span_${sn.s_no }"></span><br>
				&nbsp;<img src="${path}/images/delivery-truck.png" id="truck">
				배송비   :
				<span class="deliveryFee_span_${sn.s_no }"></span> 
				<label id="d_msg">※ 3만원 이상 구매 시 무료 배송 ※</label>				
			  </div>
		      <div class="order_btn_div">	
				<button id="order_btn" class="btn btn-success order_btn_${sn.s_no}" 
					   onClick="order_btn(${sn.s_no});" style="margin-top:10px;">주문하기</button>
			  </div>
			</div>
		    </c:forEach>
			
			
		<div class="goShoping_div">
			<button class="btn btn-success shoping_btn">쇼핑 계속하기</button>
			<button class="btn btn-success allDelete_btn">장바구니 비우기</button>
		</div>
		</c:if>
      </div>
    </div>

	<!-- 삭제 form -->
    <form action="cartDelete.do" method="post" class="delete_form">
 		<input type="hidden" name="cart_no" class="delete_cart_no">
    </form>
	
	<!-- 수량 수정 form -->
	<form method="post" action="cartQtyUpdate.do" class="qty_update_form">	
		<input type="hidden" name="cart_no" class="update_cart_no">	
		<input type="hidden" name="cart_qty" class="update_cart_qty">	
	</form>
	
	<!-- 주문 form -->
    <form action="order.do" method="get" class="order_form">
 
    </form>

<script>

	// 쇼핑계속하기 버튼
	$(".shoping_btn").on("click", function(){
		location.href="main.do"
	});

	// 상품 수량 버튼
/*  	$(".plus_btn").on("click", function(){
		let qty = $(this).parent("div").find("input").val();
		
		$(this).parent("div").find("input").val(++qty);
		
	}); */
/* 	$(".minus_btn").on("click", function(){
		let qty = $(this).parent("div").find("input").val();
		if(qty > 1){
		$(this).parent("div").find("input").val(--qty);
		}	
	});  */
	// 상품 수량 버튼	
	function plus(n){
		let qty = parseInt($(".cart_qty_input_"+n).val());
		let p_stock = parseInt($(".p_stock_input_"+n).val());
 		if(qty < p_stock){ 
			$(".cart_qty_input_"+n).val(++qty);
 		}	 
	}
	function minus(n){
		let qty = parseInt($(".cart_qty_input_"+n).val());
		if(qty > 1){
			$(".cart_qty_input_"+n).val(--qty);
		}
	}
	
	
	// 상품 수량 수정 버튼
 	function update(n){
		let cart_no = n
		let c_qty = parseInt($(".cart_qty_input_"+n).val());
		let stock = parseInt($(".p_stock_input_"+n).val());

		// 상품 재고 유효성 검사
  		if(c_qty > stock) {   
		    alert("재고가 없습니다. 선택할 수 있는 최대 상품 수량은 "+stock+"개 입니다.");
		    $(".cart_qty_input_"+n).val(1);
		}else{ 
			$(".update_cart_no").val(cart_no);
			$(".update_cart_qty").val(c_qty);
			$(".qty_update_form").submit();
 	    }  
	} 
	
	// 장바구니 개별 상품 삭제 버튼
	$(".delete_btn").on("click",function(e){
		e.preventDefault();
		const cart_no = $(this).data("cart_no");
		$(".delete_cart_no").val(cart_no);
		$(".delete_form").submit();
	});
	
	// 장바구니 비우기 버튼
	$(".allDelete_btn").on("click",function(){
		var check = confirm("장바구니를 비우겠습니까?");
		if(check){
			location.href="allCartDelete.do";
		}
	})	
	
	// 전체선택일때 하나라도 체크박스 해제할 경우 
	function check(n){
		$(".allCheck_input_"+n).prop("checked", false);
		itemSum(n);
	}
	
	// 체크박스 전체 선택
	function allCheck(n){
					
		// 체크박스 체크/해제
		var chk = $(".allCheck_input_"+n).prop("checked");
		if(chk){
			$(".chkbox_input_"+n).prop("checked",true);
		}else{
			$(".chkbox_input_"+n).prop("checked",false);
		}
					
		itemSum(n);
	}
	
	function itemSum(n){
					
		let totalPrice = 0;
		let deliveryFee = 0;
		let finalPrice = 0;
			
	    $(".cart_info_td").each(function(index, element){
				if($(element).find(".chkbox_input_"+n).is(":checked")==true){
					// 총 결제 예상 금액
					totalPrice += parseInt($(element).find(".total_price_input").val()); 
				}
			// 배송비
			if(totalPrice>=30000){
				deliveryFee = 0;
			}else if(totalPrice == 0){ 
				deliveryFee = 0;
			}else{	
				deliveryFee = 3000;
			}		 
			
	   });
				 
		 $(".totalPrice_span_"+n).text(totalPrice.toLocaleString()+"원");
		 $(".deliveryFee_span_"+n).text(deliveryFee.toLocaleString()+"원");
	}	
			
	// 주문 페이지 이동
 	function order_btn(n){
		var chk = $(".chkbox_input_"+n).is(":checked") 
		console.log(chk);
		let form_contents = '';
		let orderNumber = 0;
		
		if(chk){
			$(".cart_info_td").each(function(index, element){
				
				if($(element).find(".chkbox_input_"+n).is(":checked") === true){
					let p_no = $(element).find(".p_no_input").val();
					let cart_qty = $(element).find(".cart_qty_input").val();
					let op_type = $(element).find(".op_type_input").val();

					let p_no_input = "<input name='orders[" + orderNumber + "].p_no' type='hidden' value='" + p_no + "'>";
					form_contents += p_no_input;
					
					let cart_qty_input = "<input name='orders[" + orderNumber + "].cart_qty' type='hidden' value='" + cart_qty + "'>";
					form_contents += cart_qty_input;
					
					let op_type_input = "<input name='orders[" + orderNumber + "].op_type' type='hidden' value='" + op_type + "'>";
					form_contents += op_type_input;
					
					orderNumber += 1;
				}
				
			});
			
			$(".order_form").html(form_contents);
			$(".order_form").submit(); 			
		}else{
			alert("주문하실 상품을 선택해주세요.");
		}
	}		
	

</script>





<footer>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>	
</footer>

</body>
</html>