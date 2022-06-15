<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>

<script>

function review_click(a,b){
	
	var p_no = a;
	var o_no = b;
	
	 $.ajax({
	        type:"POST",
	        url:"reviewCheck.do",
	        data: {"p_no":p_no, "o_no":o_no},        
	        success: function (data) { 
	         // alert(data);
	        	
	      	  if(data == 1){	// DB에 리뷰 존재
	      		alert("해당 제품에 대한 리뷰를 이미 작성하였습니다!");
	      	  	/* history.go(-1); */
	          	return false;
		     
	      	  }else{	//리뷰 작성 가능
	      		location.href = "reviewForm.do?p_no="+p_no+"&o_no="+o_no
	      	  }
	        }
	        ,
	    	  error:function(e){
	    		  alert("data error"+e);
	    	  }
	      });//$.ajax	
}

</script>

</head>
<body>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>

<div class="container" align="center">

<h3 style="font-weight: bold; margin: 30px 0px 30px 0px;" >주문 내역</h3>

<div class="vf-wide700-card" style="width: 950px;">	

<table align="center" class="table">
	<tr>
		<th style="text-align: center;">주문번호</th>
		<th style="text-align: center;">상품명</th>
		<th style="text-align: center;">가격</th>
		<th style="text-align: center;">수량</th>
		<th colspan="2" style="text-align: center;">주문상태</th>
	</tr>
	
<c:forEach var="list" items="${orderList }">
	<tr>
		<td style="text-align: center;">
		<a href="orderDetail.do?op_no=${list.op_no}&o_no=${list.o_no}">
			<fmt:formatDate value="${list.o_date }" pattern="yyMMdd"/> - 
			<fmt:formatNumber value="${list.o_no }" pattern="#####" minIntegerDigits="5"/>
		</a>
		</td>
		
		<td style="text-align: center;"><a href="productView.do?p_no=${list.p_no}">${list.p_name}</a></td>
		
		<td style="text-align: center;"><fmt:formatNumber value="${list.op_price * list.op_qty }" pattern="#,###"/> 원</td>
		
		<td style="text-align: center;">${list.op_qty }</td>
		
		<td style="text-align: center; font-weight: bold;">
			<c:if test="${list.op_status == '1' }">공동구매대기</c:if>
			<c:if test="${list.op_status == '2' }">공동구매실패</c:if>
			<c:if test="${list.op_status == '3' }">배송전 </c:if>
			<c:if test="${list.op_status == '4' }">주문취소</c:if>
			<c:if test="${list.op_status == '5' }">품절취소</c:if>
			<c:if test="${list.op_status == '6' }">출고완료</c:if>
			<c:if test="${list.op_status == '7' }">배송완료 </c:if>
			<c:if test="${list.op_status == '8' }">환불요청중</c:if>
			<c:if test="${list.op_status == '9' }">환불거부</c:if>
			<c:if test="${list.op_status == '10' }">환불완료</c:if>
			<c:if test="${list.op_status == '11' }">거래완료</c:if>
		</td>
		<td>
			<c:if test="${list.op_status == '3' }">
				<input type="button" class="btn btn-success" value="주문 취소" onClick="location='cancel.do?op_no=${list.op_no}'">
			</c:if>
			
			<c:if test="${list.op_status == '5' }">
				<input type="button" class="btn btn-outline-success" value="재입고 신청" onclick="location='restockInsert.do?p_no=${list.p_no}'">
			</c:if>
			
			<c:if test="${list.op_status == '6' }">
				<!-- <input type="button" class="btn btn-success" value="배송추적" 
				onClick="window.open('https://www.cjlogistics.com//ko/tool/parcel/tracking', '배송추적', 'width=1000, height=750, scrollbar=yes');"> -->
				운송장 번호: <a href= "https://www.cjlogistics.com//ko/tool/parcel/tracking"><b>${list.op_deli_no }</b></a>
			</c:if>
			
			<c:if test="${list.op_status == '7' }">
				<input type="button" class="btn btn-success" value="구매 확정" 
				onClick="location='confirm.do?op_no=${list.op_no}&s_no=${list.s_no }'">
				<input type="button" class="btn btn-outline-success" value="환불 요청" 
				onClick="location='refund.do?op_no=${list.op_no}'">
			</c:if>
			
			<c:if test="${list.op_status == '9' }">
				<div style="font-size: 10pt;"><a href="qnaQuestionForm.do?m_email=${sessionScope.m_email }">판매자에게 1:1 문의하기</a></div>
			</c:if>
			
			<c:if test="${list.op_status == '11' }">
				<input type="button" class="btn btn-outline-success" value="리뷰작성" 
				onclick="review_click(${list.p_no},${list.o_no })">
			</c:if>
		</td>
	</tr>
</c:forEach>
</table>
</div>
</div>

<div class="container" align="center">
<ul class="pagination">
			
		<c:if test="${pp.startPage > pp.pagePerBlk }">
			<li><a href="${path }/orderList.do?pageNum=${pp.startPage - 1}">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<li <c:if test="${pp.currentPage == i}">class="active"</c:if>><a
				href="${path }/orderList.do?pageNum=${i}">${i}</a></li>
		</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li><a href="${path }/orderList.do?pageNum=${pp.endPage + 1}">다음</a></li>
		</c:if>
		 
</ul>
</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>