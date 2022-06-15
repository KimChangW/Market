<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div class="container">
		<table style="width:100%; margin:0px; padding:0px; font-size:13px;" align=left>
			<tr>
				<td><h4><b>PRODUCT Q&A</b></h4></td>
				<td width=90px>
				<c:if test="${not empty sessionScope.m_email}" >
				<input type="button" id="qna_btn" class="edit1 btn btn-outline-success"
<%-- 				 onclick="location.href='${path}/qnaInsertForm.do'" --%>
							style="width:80px; height:30px; padding:2px; margin:7px;" value="상품문의"></c:if></td>
			</tr>
			<tr>
				<td colspan=2>
					* 상품에 대한 문의를 남기는 공간입니다.<br>
					* 배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이페이지 내 <a href="myPage.do">1:1문의</a>에 남겨주세요
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
							<td style="padding:10 10 0 10;"><pre>${qna.qna_question}</pre></td>
						</tr>
						<tr>
							<td style="font-size:20px; padding:9 0 0 20; width:40px; vertical-align: top;"><b>A</b></td>
							<td style="padding:0 10 0 10;"><pre>${qna.qna_answer}</pre></td>
						</tr>
					</table>
			       </div>
			   	</div>
			</c:forEach>
		</c:if>
		
		</div>
	</div>

</div>
</body>
</html>
<script type="text/javascript">
 	$(function() {
/*  		$('#qna_btn').click(function() {
			$('#slist').load('qnaInsertForm.do');
		}); */

		$(".edit1").click(function() {
			$('#slist').load('${path}/qnaInsertForm.do?p_no=${keyword}');
		}); 

	});
/* 	function question() {
		$('#slist').load('${path}/qnaInsertForm.do');
	}  */
</script>