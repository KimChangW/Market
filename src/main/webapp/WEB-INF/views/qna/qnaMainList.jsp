<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
// 문의하기 버튼
 	$(function() {
		$(".edit1").click(function() {
			$('#slist').load('${path}/qnaInsertForm.do?p_no=${keyword}');
		}); 
	});
	
// 삭제 버튼
	function qnaDelete(qna_no,currentPage,search,keyword){
	 	var result = confirm("정말로 삭제하시겠습니까?");
	 	if (result == true) {
			var formData="qna_no="+qna_no+"&pageNum="+currentPage+"&search="+search+"&keyword="+keyword;

			$.post("${path}/qnaDelete.do",formData, function(data) {
				$('#slist').html(data);
			});
	 	}
	}

//paging처리
	function paging(pageNum,search,keyword) {
		$('#slist').load('${path}/qnaMainList.do?pageNum='+pageNum+'&search='+search+'&keyword='+keyword);
	}
 </script>
</head>
<body>
<div class="container">
	<table style="width:100%; margin:0px; font-size:13px;" align=left>
		<tr>
			<td><h4><b>PRODUCT Q&A</b></h4></td>
			<td width=90px>
			<c:if test="${not empty sessionScope.m_email}" >
			<input type="button" class="edit1 btn btn-outline-success"
						style="width:80px; height:30px; padding:2px; margin:7px;" value="상품문의"></c:if></td>
		</tr>
		<tr>
			<td colspan=2>
				* 상품에 대한 문의를 남기는 공간입니다.<br>
			<c:if test="${empty sessionScope.m_email}" >
				* 상품 문의는 로그인 이후에 이용해 주세요!
			</c:if>
			<c:if test="${not empty sessionScope.m_email}" >
				* 배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이페이지 내 <a href="qnaList.do?search=m_email&keyword=${sessionScope.m_email }">1:1문의</a>에 남겨주세요
			</c:if>
			</td>
		</tr>
	</table>
<!--  문의글 리스트 출력 (클릭하면 상세내용을 보여줌)   -->
	<c:if test="${empty list}">
	<table width=100% height=100px>
		<tr align=center>
			<td><label style="font-size:20px;" ><br><br><br>해당 상품에 따른 문의글이 없습니다.<br><br><br><br><br><br></label></td>
		</tr>
	</table> 
	</c:if>
	<c:if test="${not empty list }">
	<table class="table" style="font-size:14px; margin:0px; padding:0px;">
		<tr align=center>
			<td>제목</td>
			<td width=65>작성자</td>
			<td width=110>작성일</td>
			<td width=95>답변상태</td>
		</tr>
	</table>
 	<div id="accordion">
		<c:forEach var="qna" items="${list}">
			<div class="card-header" style="margin:0px; padding:0px;">
				<table id="list_${qna.qna_no}" class="table" style=" font-size:15px; margin:0px;">
					<tr style="padding:10px;">
						<td id="td_${qna.qna_no}">
							<a class="card-link" data-toggle="collapse" href="#detail_${qna.qna_no}">
							${qna.qna_title}</td>
						<td width=65>${qna.m_name}</td>
						<td width=110><fmt:formatDate value="${qna.qna_writedate }" pattern="yyyy-MM-dd"/></td>
						<td width=95 id="btn_${qna.qna_no}">
							<c:if test="${qna.qna_answer == '답변대기'}">답변대기</c:if>
							<c:if test="${qna.qna_answer != '답변대기'}"><b>답변완료</b></c:if></td>
					</tr>
				</table>
		    </div>
		<!--  문의글 상세내용    -->
			<div id="detail_${qna.qna_no}" class="collapse hide" data-parent="#accordion">
		       <div class="card-body" style="margin:0px; padding:0px;">
		       	<table style="width: 100%; margin:0px; padding:0px; background-color: #f8f8f8">
					<tr>
						<td style="font-size:20px; padding:9 0 0 20; width:40px; vertical-align: top;"><b>Q</b></td>
						<td style="padding:10 10 0 10;"><pre style="font-size: 15px; font-family: 'Nanum Gothic', sans-serif;">${qna.qna_question}</pre></td>
					</tr>
					<tr>
						<td style="font-size:20px; padding:9 0 0 20; width:40px; vertical-align: top;"><b>A</b></td>
						<td style="padding:0 10 0 10;"><pre style="font-size: 15px; font-family: 'Nanum Gothic', sans-serif;">${qna.qna_answer}</pre></td>
					</tr>
					<c:if test="${qna.m_email eq sessionScope.m_email}">
					<tr>
						<td></td>
						<td style="padding:0 10 10 10;" align=right>
						<a href="javascript:qnaDelete(${qna.qna_no},${pp.currentPage},'${search}',${keyword})"> x 삭제</a></td>
					</tr>
					</c:if>
				</table>
		       </div>
		   	</div>
		</c:forEach>
	</c:if>
	<ul class="pagination">
		<c:if test="${pp.startPage > pp.pagePerBlk }">
			<li><a href="javascript:paging(${pp.startPage - 1},'${search}',${keyword})">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<li <c:if test="${pp.currentPage==i}">class="active"</c:if>>
				<a href="javascript:paging(${i},'${search}',${keyword})">${i}</a></li>
		</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li><a href="javascript:paging(${pp.endPage + 1},'${search}',${keyword})">다음</a></li>
		</c:if>
	</ul>
</div>
</body>
</html>
