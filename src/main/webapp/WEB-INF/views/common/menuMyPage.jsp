<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!-- navigator 영역 -->

	<div class="vf_sub_menu">
		<div style="width: 15%;"><a href="memberConfirmForm.do">회원정보수정</a></div>
		<div style="width: 10%;"><a href="orderList.do">주문목록</a></div>
		<div style="width: 14%;"><a href="myReviewList.do">내가 쓴 리뷰</a></div>
		<div style="width: 17%;"><a href="restockList.do">재입고신청목록</a></div>
		<div style="width: 15%;"><a href="loveList.do">관심상품목록</a></div>
		<div style="width: 17%;"><a href="followList.do">팔로우상점목록</a></div>
		<div style="width: 12%;"><a href="qnaList.do?search=m_email&keyword=${sessionScope.m_email }">문의글목록</a></div>
	</div>
