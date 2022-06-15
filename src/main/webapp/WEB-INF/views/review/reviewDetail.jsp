<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세</title>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuMyPage.jsp"%>


<div class="container" align="center">

<div class="vf-wide700-card">
<h3 style="font-weight: bold; margin: 30px 0px 30px 0px;">리뷰 상세</h3>
<table class="table">
		<tr>
			<th>상품명</th>
			<td>${product.p_name }</td>
			<th>별 점</th>
			<td>
				<c:if test="${review.r_star == 0}">☆☆☆☆☆</c:if>
				<c:if test="${review.r_star == 1}">★☆☆☆☆</c:if>
				<c:if test="${review.r_star == 2}">★★☆☆☆</c:if>
				<c:if test="${review.r_star == 3}">★★★☆☆</c:if>
				<c:if test="${review.r_star == 4}">★★★★☆</c:if>
				<c:if test="${review.r_star == 5}">★★★★★</c:if>
			</td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td>
				<fmt:formatDate value="${review.r_writedate }" pattern="yyyy-MM-dd"/>
			</td>
			<th>조회수</th>
			<td>${review.r_hit }</td>
		</tr>
		<tr>
			
		</tr>
		
		<tr>
			<th>제 목</th>
			<td colspan="3">${review.r_title }</td>
		</tr>
		
		<tr>
			<td colspan="4">
			
			<div class="vf-card" height=100px>
				${review.r_content}
			</div>
				
			</td>
		</tr>
		<tr>
			<td colspan="4" style="text-align: center;">
				<input type="button" class="btn btn-outline-success" value="삭제"
				onclick="location='reviewDelete.do?r_no=${review.r_no}'">
				<input type="button" class="btn btn-success" value="목록으로"
				onclick="location='myReviewList.do'">
			</td>
		</tr>
	</table>

</div>
</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>