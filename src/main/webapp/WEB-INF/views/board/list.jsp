<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%@ include file="../common/header.jsp"%>

	<div class="container" align="center">

		<h2 class="text-primary">게시판 목록</h2>
		
		<!-- 폭이 넓은 스크린 -->
		<div class="vf-wide-screen">
		<table class="table table-hover">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5">데이터가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:set var="no1" value="${no }"></c:set>
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${no1}</td>
						<c:if test="${board.del =='y' }">
							<td colspan="4">삭제된 데이터 입니다</td>
						</c:if>
						<c:if test="${board.del !='y' }">
							<td><a href="${path }/view.do?num=${board.num}&pageNum=${pp.currentPage}"> 
									<c:if test="${board.re_level >0 }">
										<img alt="" src="${path }/images/level.gif" height="2" width="${board.re_level *5 }">
										<img alt="" src="${path }/images/re.gif">
									</c:if> 
									${board.subject} 
									<c:if test="${board.readcount > 30 }">
										<img alt="" src="${path }/images/hot.gif">
									</c:if></a></td>
							<td>${board.writer}</td>
							<td>${board.reg_date}</td>
							<td>${board.readcount}</td>
						</c:if>
					</tr>
					<c:set var="no1" value="${no1 - 1}"></c:set>
				</c:forEach>
			</c:if>
		</table>
		</div>
		
		<!-- 폭이 좁은 스크린 -->
		<div class="vf-less-wide-screen">
		<table class="table table-hover">

			<c:if test="${empty list}">
				<tr>
					<td colspan="5">데이터가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:set var="no1" value="${no }"></c:set>
				<c:forEach var="board" items="${list }">
					<tr>
						<c:if test="${board.del =='y' }">
							<td>삭제된 데이터 입니다</td>
						</c:if>
						<c:if test="${board.del !='y' }">
							<td><a href="${path }/view.do?num=${board.num}&pageNum=${pp.currentPage}"> 
									<c:if test="${board.re_level >0 }">
										<img alt="" src="${path }/images/level.gif" height="2" width="${board.re_level *5 }">
										<img alt="" src="${path }/images/re.gif">
									</c:if> 
									${board.subject} 
									<c:if test="${board.readcount > 30 }">
										<img alt="" src="${path }/images/hot.gif">
									</c:if></a><br>
								<table width=100%>
									<tr style="font-size:10px">
										<td>${board.reg_date}</td>
										<td align=right>조회수:${board.readcount}</td>
									</tr>
								</table>
							</td>

						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		</div>
		
		
		<form action="${path}/list.do?pageNum=1">
			<select name="search">
				<option value="subject"
					<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
				<option value="content"
					<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
				<option value="writer"
					<c:if test="${search=='writer'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> 
			<input type="text" name="keyword"> 
			<input type="submit" value="확인">
		</form>
		<ul class="pagination">
			<c:if test="${not empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="${path }/list.do?pageNum=${pp.startPage - 1}?search=${search}&keyword=${keyword}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="${path }/list.do?pageNum=${i}?search=${search}&keyword=${keyword}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="${path }/list.do?pageNum=${pp.endPage + 1}?search=${search}&keyword=${keyword}">다음</a></li>
				</c:if>
			</c:if>
			<c:if test="${empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="${path }/list.do?pageNum=${pp.startPage - 1}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="${path }/list.do?pageNum=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="${path }/list.do?pageNum=${pp.endPage + 1}">다음</a></li>
				</c:if>
		  </c:if>
		</ul>
		<div align="center">
			<a href="${path}/insertForm.do" class="btn btn-success">글 입력</a>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
