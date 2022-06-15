<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- navigator 영역 -->
	<div class="vf_sub_menu" style="background-color: #FFC107;">
		<div style="width: 17%"><a href="shop_info.do">상점정보보기</a></div>
		<div style="width: 16%"><a href="productInsertForm.do">상품등록</a></div>
		<div style="width: 17%"><a href="productList.do">상품목록</a></div>
		<div style="width: 16%"><a href="order_tabList.do">주문확인</a></div>
		<div style="width: 17%"><a href="refundList.do">환불관리</a></div>
		<div style="width: 17%"><a href="qnaList.do?search=s_no&keyword=${sessionScope.s_no}">문의글목록</a></div>
	</div>