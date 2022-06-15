<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<head>
<script>

//paging처리
	function paging(pageNum) {
		$('#slist').load('${path}/productReviewList.do?pageNum='+pageNum);
	}
	
</script>
</head>

<div class="container">
		<table style="width:100%; margin:0px 0px 20px 0px; padding:0px; font-size:13px;" align=left>
			<tr>
				<td><h4><b>PRODUCT REVIEW</b></h4></td>
			</tr>
			<tr>
				<td colspan=2>
					* 해당 상품을 구매하신 분들의 생생한 후기 입니다! <br>
				</td>
			</tr>
		</table>
		
<!-- 리뷰 없을 때 -->		
		<c:if test="${empty list}">
		<table width=100% height=100px>
			<tr align=center>
				<td><label style="font-size:20px;" ><br><br><br>이 상품의 첫 번째 리뷰를 작성해주세요!<br><br><br><br><br><br></label></td>
			</tr>
		</table> 
		</c:if>
		
<!-- 리뷰 있을 때 -->
		<c:if test="${not empty list }">
		<table class="table" style="font-size:14px; margin:0px; padding:0px;" width=100%>
			<tr align=center>
				<td width="60" align="center">번 호</td>
				<td align="center">제 목</td>
				<td width="100" align="center">별 점</td>
				<td width="180" align="center">작성자</td>
				<td width="120" align="center">작성일</td>
			</tr>
		</table>
		
<!--  리뷰 목록 출력 (클릭하면 상세내용을 보여줌)   -->
	 <div id="accordion">
		<c:forEach var="review" items="${list }">
			<div class="card-header" style="margin:0px; padding:0px;">
				<table id="list_${review.r_no}" class="table" style=" font-size:15px; margin:0px;" width=100%>
					<tr style="padding:10px;">
					
						<td width="60" align="center">${review.r_no}</td>
						
						<td id="td_${review.r_no}" align="center">
							<a class="card-link" data-toggle="collapse" href="#detail_${review.r_no}">
								${review.r_title }
							</a>
						</td>
						
						<td width="100" align="center">
							<c:if test="${review.r_star == 0}">☆☆☆☆☆</c:if>
							<c:if test="${review.r_star == 1}">★☆☆☆☆</c:if>
							<c:if test="${review.r_star == 2}">★★☆☆☆</c:if>
							<c:if test="${review.r_star == 3}">★★★☆☆</c:if>
							<c:if test="${review.r_star == 4}">★★★★☆</c:if>
							<c:if test="${review.r_star == 5}">★★★★★</c:if>
						</td>
						
						<td width="180" align="center">${review.m_email}</td>
						
						<td width="120" align="center"><fmt:formatDate value="${review.r_writedate }" pattern="yyyy-MM-dd"/></td>
						
					</tr>
				</table>
		    </div>
		    
		<!--  리뷰 상세내용    -->
			<div id="detail_${review.r_no}" class="collapse hide" data-parent="#accordion">
		       <div class="card-body" style="margin:0px; padding:0px;">
		       	<table style="width: 100%; margin:0px; padding:0px; background-color: #f3f3f3">
		       		<tr>
						<td style="padding:10 10 10 10;">
							<%-- <pre style="font-size: 15px; font-family: 'Nanum Gothic', sans-serif;">
								${review.r_content}
							</pre> --%>
							<div class="vf-card" height=100px style="border-style:solid; border-color: black; border-radius: 10px;">
									<font style="font-size: 14px;">${review.r_content}</font>
							</div>
						</td>
					</tr>
				</table>
		       </div>
		   	</div>
		   	
		</c:forEach>
		</div>
		</c:if>
</div>

<div class="container" align="center">
	<!-- 페이징 처리 -->
	<ul class="pagination">
		<c:if test="${pp.startPage > pp.pagePerBlk }">
			<li><a href="javascript:paging(${pp.startPage - 1})">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<li <c:if test="${pp.currentPage==i}">class="active"</c:if>>
				<a href="javascript:paging(${i})">${i}</a></li>
		</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li><a href="javascript:paging(${pp.endPage + 1})">다음</a></li>
		</c:if>
	</ul>
</div>		

