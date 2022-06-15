<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리</title>

<script>
$(function() {

   $("#order").change(function(){
      if($("#order").val()!=""){
         location.href=$("#order").val();
         return false;
      }
   });
   $("#status").change(function(){
      if($("#status").val()!=""){
         location.href=$("#status").val();
         return false;
      }
   });
   
   $("#s_no").change(function(){
      if($("#s_no").val()!=""){
         location.href=$("#s_no").val();
         return false;
      }
   });
});
</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuAdmin.jsp"%>
	<div class="container" align="center">

		<h3 class="text-primary">상품 관리</h3>

		<!-- 폭이 넓은 스크린 -->
		<div class="vf-wide-screen">

		<table width=100%>
			<tr><td align=left>
					<select id="order" name="order">
						<option value="">===정렬유형을 선택하세요===</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_group_price_ASC">공동구매상품</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_follow_price_ASC">팔로워할인상품</option>
						<option value="">----------------------</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_name_ASC">상품명순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_sell_ASC">일반판매가순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_regdate_DESC">최신순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_hit_DESC">조회순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_stock_ASC">재고순</option>
						
					</select>
				</td>
				<td align=center>
					<select id="status" name="status">
						<option value="">===상품상태를 선택하세요===</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=1">판매중</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=2">일시판매중지</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=4">판매정지</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=5">상품삭제</option>
					</select> 
				</td>
				<td align=right>
					<select id="s_no" name="s_no">
						<option value="">===상점을 선택하세요===</option>
						<c:forEach var="g" items="${getShopNo}">
							<option value="${path}/productManagerList.do?pageNum=1&s_no=${g.s_no}">${g.s_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table><br><br>

		</div>
		<div class="vf-wide-screen">
		<table class="table table-hover">
			<tr>
				<td>상품번호</td>
				<td>상품명</td>
				<td>일반판매가</td>
				<td>공동구매가</td>
				<td>팔로워할인가</td>
				<td>재고</td>
				<td>상품상태</td>
				<td>판매정지</td>
				<td>조회수</td>
			</tr>
			<c:if test="${empty mlist}">
				<tr>
					<td colspan="10">데이터가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty mlist}">
				<c:forEach var="p" items="${mlist }">
					<tr>
						<td>${p.p_no}</td>
						<td><a href="productView.do?p_no=${p.p_no}">${p.p_name}</a></td>
						<td>${p.p_sell_price}</td>
						<td>${p.p_group_price}</td>
						<td>${p.p_follow_price}</td>
						<td>${p.p_stock}</td>
						<td>
							<c:if test="${p.p_status =='1'}">판매중</c:if>
							<c:if test="${p.p_status =='2'}">일시판매중지</c:if>
							<c:if test="${p.p_status =='4'}">판매정지</c:if>
							<c:if test="${p.p_status =='5'}">상품삭제</c:if>
						</td>
						<td>
							<input type="button" value="판매정지" class="btn btn-outline-success" onclick="location.href='${path}/productStop.do?p_no=${p.p_no}&pageNum=1'">
						</td>
						<td>${p.p_hit}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		</div>
		
		<!-- 폭이 좁은 스크린 -->
		<div class="vf-less-wide-screen">
		<table width=100%>
			<tr><td align=left>
					<select id="order" name="order">
						<option value="">===정렬유형을 선택하세요===</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_group_price_ASC">공동구매상품</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_follow_price_ASC">팔로워할인상품</option>
						<option value="">----------------------</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_name_ASC">상품명순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_sell_ASC">일반판매가순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_regdate_DESC">최신순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_hit_DESC">조회순</option>
						<option value="${path}/productManagerList.do?pageNum=1&search=p_name&keyword=${keyword}&orderCond=p_stock_ASC">재고순</option>
					</select>
				</td>
				<td align=center>
					<select id="status" name="status">
						<option value="">===상품상태를 선택하세요===</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=1">판매중</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=2">일시판매중지</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=4">판매정지</option>
						<option value="${path}/productManagerList.do?pageNum=1&status=5">상품삭제</option>
					</select> 
				</td>
				<td align=right>
					<select id="s_no" name="s_no">
						<option value="">===상점을 선택하세요===</option>
						<c:forEach var="g" items="${getShopNo}">
							<option value="${path}/productManagerList.do?pageNum=1&s_no=${g.s_no}">${g.s_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table><br><br>
		</div>
		<div class="vf-less-wide-screen">
		<table class="table table-hover">
			<tr>
				<td>상품번호</td>
				<td>상품명</td>
				<td>재고</td>
				<td>상품상태</td>
				<td>판매정지</td>
				<td>조회수</td>
			</tr>
			<c:if test="${empty mlist}">
				<tr>
					<td colspan="10">데이터가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty mlist}">
				<c:forEach var="p" items="${mlist }">
					<tr>
						<td>${p.p_no}</td>
						<td><a href="productView.do?p_no=${p.p_no}">${p.p_name}</a></td>
						<td>${p.p_stock}</td>
						<td>
							<c:if test="${p.p_status =='1'}">판매중</c:if>
							<c:if test="${p.p_status =='2'}">일시판매중지</c:if>
							<c:if test="${p.p_status =='4'}">판매정지</c:if>
							<c:if test="${p.p_status =='5'}">상품삭제</c:if>
						</td>
						<td>
							<input type="button" value="판매정지" class="btn btn-outline-success" onclick="location.href='${path}/productStop.do?p_no=${p.p_no}&pageNum=1'">
						</td>
						<td>${p.p_hit}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		</div>
		
		
		<form action="${path}/productManagerList.do?pageNum=1">
			<select name="search">
				<option value="p_name"
					<c:if test="${search=='p_name'}">selected="selected" </c:if>>상품명</option>
			</select> 
			<input type="text" name="keyword"> 
			<input type="submit" value="확인">
		</form>
		<ul class="pagination">
			<c:if test="${not empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="${path }/productManagerList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="${path }/productManagerList.do?pageNum=${i}&search=${search}&keyword=${keyword}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="${path }/productManagerList.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">다음</a></li>
				</c:if>
			</c:if>
			<c:if test="${empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="${path }/productManagerList.do?pageNum=${pp.startPage - 1}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="${path }/productManagerList.do?pageNum=${i}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="${path }/productManagerList.do?pageNum=${pp.endPage + 1}&orderCond=${orderCond}&status=${status}&s_no=${s_no}">다음</a></li>
				</c:if>
		  </c:if>
		</ul>
	</div>
	
	
<br><br><br><br>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
