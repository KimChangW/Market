<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>

</head>
<body>
<%@ include file="../common/header.jsp"%>

<div class="container" align=center>
	<c:if test="${not empty keyword}">
		<c:if test="${not empty listCategory}"> 
		
		<div  class="container" style="width:100%;  padding:0 0 3 0; border-radius: 10px; border-style: dotted; border-width: 2px;">
			<c:forEach var="c" items="${listCategory }">
				<div class="sub_cate" style="width: 120px; height:32px; float: left; text-align: center; padding:7 0 7 0; ">
				<c:if test="${search=='cate_large'}">
					<font style="font-size: 15px; font-weight: bold;">
						<a href="${path}/productCategoryList.do?search=cate_small&keyword=${c.cate_small }">${c.cate_small }</a>
					</font>
				</c:if>
				<c:if test="${search!='cate_large'}">
					<c:if test="${keyword == c.cate_small}">
						<font style="font-size: 15px; font-weight: bold;">
							<a href="${path}/productCategoryList.do?search=cate_small&keyword=${c.cate_small }">${c.cate_small }</a>
						</font>
					</c:if>
					<c:if test="${keyword != c.cate_small}">
							<a href="${path}/productCategoryList.do?search=cate_small&keyword=${c.cate_small }">${c.cate_small }</a>
					</c:if>
				</c:if>
				</div>
			</c:forEach>
		</div>
		
		</c:if>
	</c:if>	
	<c:if test="${empty list}">
		<table class="table table-hover">
			<tr>
				<td align=center><br><br><br>해당 카테고리에는 <font color=red>
				<c:if test="${orderCond == 'p_group_price_ASC'}">공동구매특가</c:if>
				<c:if test="${orderCond == 'p_follow_price_ASC'}">팔로워특가</c:if>
				</font> 상품이 없습니다<br><br><br><br><br></td>
			</tr>
		</table>
	</c:if>
	<c:if test="${not empty list}">
		<!-- 상품개수와 공동구매특가,팔로우특가,각종 정렬부분 -->
		<table style="font-size:13px; width:100%">
			<tr>
				<td width=132px style="padding:5 0 0 10;">검색된 상품개수 : ${pp.total}</td>
				<td  style="padding:5 10 0 0;" align=right>
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_group_price_ASC" style="color:red">
						<c:if test="${orderCond == 'p_group_price_ASC'}"><b>공동구매특가</b></c:if>
						<c:if test="${orderCond != 'p_group_price_ASC'}">공동구매특가</c:if></a> | 
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_follow_price_ASC" style="color:blue">
						<c:if test="${orderCond == 'p_follow_price_ASC'}"><b>팔로워특가</b></c:if>
						<c:if test="${orderCond != 'p_follow_price_ASC'}">팔로워특가</c:if></a> |
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_regdate_DESC">
						<c:if test="${orderCond == 'p_regdate_DESC'}"><b>최신순</b></c:if>
						<c:if test="${orderCond != 'p_regdate_DESC'}">최신순</c:if></a> |
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_hit_DESC">
						<c:if test="${orderCond == 'p_hit_DESC'}"><b>조회순</b></c:if>
						<c:if test="${orderCond != 'p_hit_DESC'}">조회순</c:if></a> | 
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_sell_ASC">
						<c:if test="${orderCond == 'p_sell_ASC'}"><b>낮은가격순</b></c:if>
						<c:if test="${orderCond != 'p_sell_ASC'}">낮은가격순</c:if></a> | 
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_sell_DESC">
						<c:if test="${orderCond == 'p_sell_DESC'}"><b>높은가격순</b></c:if>
						<c:if test="${orderCond != 'p_sell_DESC'}">높은가격순</c:if></a> | 
					<a href="${path }/productCategoryList.do?pageNum=1&search=${search}&keyword=${keyword}&orderCond=p_name_ASC">
						<c:if test="${orderCond == 'p_name_ASC'}"><b>상품명순</b></c:if>
						<c:if test="${orderCond != 'p_name_ASC'}">상품명순</c:if></a>
				</td>
			</tr>
		</table>
		<!-- 상품 리스트 -->
		<c:forEach var="p" items="${list }">
			<div class="vf_product" style="float: left;">
				<table style="font-size:14px;">
					<tr>
						<td style="padding:9px">
							<a href="${path }/productView.do?p_no=${p.p_no}">
							<img src="${path}/upload/product/${p.p_img}" width=210px height=210px></a></td>
					</tr>
					<tr>
						<td style="padding:0 9 9 9" valign=top height=90px>
							<a href="${path}/productSearchList.do?pageNum=1&search=s_name&keyword=${p.s_name}">[${p.s_name}]</a><br>
							<b>${p.p_name}</b><br>
							일반구매가 : ${p.p_sell_price}원<br>
							<c:if test="${p.p_group_buying == 'Y'}">
								<font color=red>공동구매가 : ${p.p_group_price}원</font><br>
							</c:if>
							<c:if test="${p.p_follow_sale == 'Y'}">
								<font color=blue>팔로워특가 : ${p.p_follow_price}원</font>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</c:if>
</div>
<!-- 페이징 -->
<c:if test="${pp.endPage > 1}">	
	<div class="container" align="center">
		<ul class="pagination">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="${path }/productCategoryList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}&orderCond=${orderCond}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="${path }/productCategoryList.do?pageNum=${i}&search=${search}&keyword=${keyword}&orderCond=${orderCond}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="${path }/productCategoryList.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}&orderCond=${orderCond}">다음</a></li>
				</c:if>
		</ul>
	</div>
</c:if>

<br><br><br><br>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
