<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css">
<link rel="stylesheet" href="${path}/css/swiper.css">

<style>


.price_table label{
 	margin-top:15px;
 	margin-left:20px; 
}

.payment_table label{
	margin-top:15px;
 	margin-left:20px; 
}

.totalPrice_span,.deliveryFee_span,.cpSalePrice_span{
	font-size:18px;
}
.finalTotalPrice_span{
	font-size:18px;

	color: red;
}
.r{
	text-align:right;
}

.final_tr{
	border-top:1px solid;
	border-top-color:#dddddd;
}
.total_info_price_div{
	float:left;
	margin-right:2px;
	margin-bottom:150px;
	width:48%
}
.payment_info_div{
	float:right;
	margin-bottom:150px;
	width:48%;
}
.radio2{
	margin-left:10px;
}
#follow_sale{
	color:red; 
	font-size:13px;
	margin-bottom:1px;
}
#line{
	text-decoration:line-through;
	color:#bcbcbc;
}

</style>

</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
</header>

<div class="container">
	<div style="text-align: center;">
	<h3 class="page-header">주문/결제</h3>

		<!-- 주문 상품 정보 -->
		<table class="table orderProduct_table">
			<thead>
				<tr>
					<th colspan="1"></th>
					<th>상품정보</th> 
					<th>수량</th> 
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pi" items="${productInfo}">
				<tr>
					<td align="center"><img src="${path}/upload/product/${pi.p_img}" width=100px></td>
					<td align="left">
						<!-- 일반 판매 상품 -->
						<c:if test="${pi.op_type == 1}">
						<div style="margin-top:25px;">
						   <b>${pi.p_name}</b> <br>
							<div style="font-size:13px;margin-top:2px;">
								<fmt:formatNumber pattern="#,###,###" value="${pi.p_sell_price}"/>&nbsp;원
						  		 | ${pi.s_name} 
					    	</div>
						</div>
						</c:if>
						<!-- 팔로우 특가 상품 -->
						<c:if test="${pi.op_type == 2}">
						<div style="margin-top:15px;">
							<label id="follow_sale">※팔로우 특가※</label> <br>
						   <b>${pi.p_name}</b> <br>
							<div style="font-size:13px;margin-top:2px;">
								<fmt:formatNumber pattern="#,###,###" value="${pi.p_sell_price}"/>&nbsp;원
								<label id="line"><fmt:formatNumber pattern="#,###,###" value="${originPrice}"/>&nbsp;원</label>
						  		 | ${pi.s_name} 
					    	</div>
						</div>
						</c:if>
						
						<!-- 공동구매 상품 -->
						<c:if test="${pi.op_type == 3 }">
							<div style="margin-top:15px;">
							   <b>${pi.p_name}</b> <br>
								<div style="font-size:13px;margin-top:2px;">
									<fmt:formatNumber pattern="#,###,###" value="${pi.p_sell_price}"/>&nbsp;원
									<label id="line"><fmt:formatNumber pattern="#,###,###" value="${originPrice}"/>&nbsp;원</label>
							  		 | ${pi.s_name} 
						    	</div>
								<label id="group_sale" style="color: red; font-size: 13px;">※공동구매 특가※</label>
							</div>
						</c:if>
						
					</td>
					<td><div style="margin-top:35px;">${pi.cart_qty} 개 </div></td>
					<td>
						<div style="margin-top:35px;font-weight:bold;">	
							<fmt:formatNumber value="${pi.total_price}" pattern="#,###,### 원" />
						</div>
					</td>
					<td class="product_table_price_td">
						<input type="hidden" class="p_sell_price_input" value="${pi.p_sell_price}">
						<input type="hidden" name ="total_price" class="total_price_input" value="${pi.total_price}">
						<input type="hidden" class="p_no_input" value="${pi.p_no}">
						<input type="hidden" class="cart_qty_input" value="${pi.cart_qty}">
						<input type="hidden" class="op_type_input" value="${pi.op_type}">
						<input type="hidden" name="s_no" class="s_no_input" value="${pi.s_no}">
						<input type="hidden" name="s_name" class="s_name_input" value="${pi.s_name}">
						<input type="hidden" name="group_op_no" class="group_op_no_input" value="${pi.group_op_no}">
						<input type="hidden" name="group_order" class="group_order_input" value="${pi.group_order}">
					</td>
				</tr>	
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 회원 정보 -->
		<table class="member_table" style="width:100%;margin-top:50px;">
			<tr>
				<td colspan="2"><h3 style="margin-left:20px;">주문자 정보</h3></td>
			</tr>
			<tr style="border-top:3px solid;border-top-color:#dddddd;">
				<td><div style="margin-left:20px;margin-top:20px;"><label>보내는 분</label></div></td>
				<td>${memberList.m_name}</td>
			</tr>
			<tr>
				<td><div style="margin-left:20px;margin-top:10px;"><label>전화번호</label></div></td>
				<td>${memberList.m_tel}</td>
			</tr>
			<tr>
				<td><div style="margin-left:20px;margin-top:10px;"><label>이메일</label></div></td> 
				<td>${sessionScope.m_email}</td>
			</tr>
			<tr>
				<td></td> 
				<td><div style="font-size:13px; color:#218838;">
				         이메일을 통해 주문처리 과정을 보내드립니다.<br>
				         정보 변경은 마이페이지>개인정보 수정 메뉴에서 가능합니다.</div></td>
			</tr>
		</table>
		
		  <!-- 배송지 정보 -->
			<div class="addressInfo_input_div">
				<table class="delivery_table" style="margin-top:50px;">
					<colgroup>
						<col width="230px">
						<col width="*">
					</colgroup>	
						<tr>
							<td  colspan="2">
							<h3 style="margin-left:20px;">배송 정보</h3></td>
						</tr>
						<tbody>
						<tr>
							<th class="delivery_th">
							<label style="margin-left:20px; margin-top:10px;" >구분</label></th>
							<td>
								<div style="display:flex;">
									<input class="d_cate_input form-control" name="d_cate" value="${deliveryInfo.d_cate}" readonly>
									<button type="button" class="deliveryList_btn btn btn-success" 
					       			 style="margin-left:10px;">배송지 목록</button>
					       	    </div>
								<div style="font-size:13px; color:#218838;margin-top:5px;margin-bottom:5px;">
									※ 집, 회사, 기타 등등 
								</div>
							</td>
						</tr>
						<tr>
							<th><label style="margin-left:20px;margin-top:10px;" >이름</label></th>
							<td><input class="d_name_input form-control" value="${deliveryInfo.d_name}" 
							           style="margin-bottom:10px;" name="d_name" readonly></td>
						</tr>
						<tr>
							<th><label style="margin-left:20px;margin-top:10px;">전화번호</label></th>
							<td>
								<input class="d_tel_input form-control" value="${deliveryInfo.d_tel}" 
								       style="margin-bottom:10px;" name="d_tel" readonly>
								<div style="font-size:13px; color:#218838;margin-top:5px;margin-bottom:5px;">
								      ※ '-'는 제외하고 입력하세요.</div>
							</td>
				 		</tr>
						<tr>
							<th><label style="margin-left:20px;margin-top:10px;">우편번호</label></th>
							<td>
								<input class="post_input form-control" value="${deliveryInfo.d_post}" readonly
								       name="d_post" id="d_post" size="5" readonly style="width:100px;margin-bottom:10px;">
							</td>
						</tr>	
						<tr>
							<td><label style="margin-left:20px;margin-top:10px;">주소</label></td>
							<td>		
								<input class="addr1 form-control" value="${deliveryInfo.d_address}" 
								        name="d_address" id="d_address" size="50" readonly ><br>
								<div style="display:flex;">	
									<input class="addr2 form-control" value="${deliveryInfo.d_detail_address}" 
									        name="d_detail_address" id="d_detail_address"readonly>
								</div>
							</td>
						</tr>
				 		<tr>
							<td><div class="d_msg_div form-group" style="margin-left:20px;margin-top:10px;">
							   	<label>요청사항</label>
							</td>
							<td>
								<input type="text" class="d_msg form-control" name="d_msg" id="d_msg" placeholder="배송 관련 요청사항을 입력하세요."></div>
								<input class="d_no" type="hidden" name="d_no" value="${deliveryInfo.d_no}">
							</td>
						</tr>
				 	</tbody>
				 </table>		
				</div>
				
	<!-- 주문 종합 정보 -->
		<div class="total_info_price_div">
		<table class="price_table" style="width:100%; margin-top:50px;">
			<tr>
				<td colspan="1"><h3 style="margin-left:20px;">결제 금액</h3></td>
			</tr>
			<tr style="border-top:3px solid;border-top-color:#dddddd;">
				<td><label>주문 금액</label></td>
	            <td class="r"><span class="totalPrice_span"></span></td>		
			</tr>
		    <tr>
				<td><label>배송비</label></td>
				<td class="r"><span class="deliveryFee_span"></span></td>
		    </tr>
		    <tr class="final_tr">
				<td><label>최종 결제 금액</label></td>
				<td class="r"><span class="finalTotalPrice_span"></span></td>
		    </tr>
		</table>
		</div>
	  </div>	
		
	<div class="payment_info_div">	
	  <table class="payment_table" style="width:100%; margin-top:50px;">
			<tr>
				<td colspan="2" align="left"><h3 style="margin-left:20px;">결제 방법</h3></td>
			</tr>
			<tr style="border-top:3px solid;border-top-color:#dddddd;">
				<td>
				    <label>결제방법 선택</label>
				</td>
				<td class="pay_info_td">
					<input type="radio" name="pay_type" value="kakaopay.TC0ONETIME" checked class="radio1"><label>카카오페이</label> <br>
					<input type="radio" name="pay_type" value="danal_tpay" class="radio2"><label>카드결제</label>
				</td>
			</tr>
		</table>
	</div>	
		
	<button class="order_btn btn btn-success">결제하기</button>
	
</div>


<footer>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>	
</footer>

<form class="order_form" action="orderRequest.do" method="post">
	<input name="d_no" type="hidden">
	<input name="d_msg" type="hidden">
	<input name="o_pay_type" type="hidden">
	<input name="s_no" type="hidden">
</form>


<script>
	$(document).ready(function(){
		total_sum()
	});
	
	// 배송지 목록 팝업창
	$(".deliveryList_btn").on("click",function(){
		let popUrl = "deliveryListPop.do";
		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl,"배송지 목록",popOption);
	});
	
	// 최종 결제 금액	
	function total_sum(){
		let totalPrice = 0;
        let deliveryFee = 0;
        let cpSalePrice = 0;
		let finalTotalPrice = 0;
		
		$(".product_table_price_td").each(function(index, element){
			// 총 가격
			totalPrice += parseInt($(element).find(".total_price_input").val());
		});	
		
		// 배송비
		if(totalPrice>=30000){
			deliveryFee = 0;
		}else if(totalPrice == 0){ 
			deliveryFee = 0;
		}else{	
			deliveryFee = 3000;
		}	
		
		finalTotalPrice = totalPrice + deliveryFee - cpSalePrice;
	
		$(".totalPrice_span").text(totalPrice.toLocaleString()+"원");
		$(".deliveryFee_span").text(deliveryFee.toLocaleString()+"원");
		$(".cpSalePrice_span").text(cpSalePrice.toLocaleString()+"원");
		$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString()+"원");
		
	}
	

	// 결제 버튼
	$(".order_btn").on("click", function(){

    	// 배송지 정보
		$(".addressInfo_input_div").each(function(i, obj){
			$("input[name=d_no]").val($(obj).find(".d_no").val());
			$("input[name=d_msg]").val($(obj).find(".d_msg").val());
		});
		
    	// 결제 타입
		$(".payment_info_div").each(function(index, element){
			let pay_type = $(element).find("input[name=pay_type]:checked").val();
			$("input[name=o_pay_type]").val(pay_type);
		});
		
    	// 판매처
		$(".product_table_price_td").each(function(index, element){
			let s_no =  $(element).find("input[name=s_no]").val();
			$("input[name=s_no]").val(s_no);
		});
			
		let form_contents = ''; 
		
		// 상품넘버, 상품 수량, 상품타입
		$(".product_table_price_td").each(function(index, element){
			let p_no = $(element).find(".p_no_input").val();
			let cart_qty = $(element).find(".cart_qty_input").val();
			let op_type = $(element).find(".op_type_input").val();
			let group_op_no = $(element).find(".group_op_no_input").val();
			let group_order = $(element).find(".group_order_input").val();
			
			let p_no_input = "<input name='orders[" + index + "].p_no' type='hidden' value='" + p_no + "'>";
			form_contents += p_no_input;
			
			let cart_qty_input = "<input name='orders[" + index + "].cart_qty' type='hidden' value='" + cart_qty + "'>";
			form_contents += cart_qty_input;
			
			let op_type_input = "<input name='orders[" + index + "].op_type' type='hidden' value='" + op_type + "'>";
			form_contents += op_type_input;
			
			let group_op_no_input = "<input name='orders[" + index + "].group_op_no' type='hidden' value='" + group_op_no + "'>";
			form_contents += group_op_no_input; 
			
			let group_order_input = "<input name='orders[" + index + "].group_order' type='hidden' value='" + group_order + "'>";
			form_contents += group_order_input; 
		});	
		
		$(".order_form").append(form_contents);	
		$(".order_form").submit();
	});
	
	

</script>

</body>
</html>