<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function memberListCheck(){
    var arr = new Array();
    $("input:checkbox[name=m_email]:checked").each(function() {
    	arr.push($(this).val());
    	
    });
   
    if(arr == null || arr.length == 0){
        alert("강제 탈퇴할 멤버를 선택해주세요.");
        return false;
    }
    
    var checkalert = confirm("강제탈퇴하시겠습니까?");
    if(checkalert){
    	
    	 alert(arr);
        $.ajax({
            type: "POST",
        	url: "memberListCheck.do",
            data: {"arr": arr },
            //dataType: "json",
            //contentType:"application/json; charset=utf-8", 
            success: function(data){
               // alert(data);
 //               if(data==1){
                	alert("강제탈퇴 되었습니다.");
 //              	 	location.href="memberList.do";
 					location.reload();
 //               }
            },error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }


           // ,error: function(e){alert("서버통신 오류"+e);}
        });
    }
	
}

</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/menuAdmin.jsp"%>


	<div class="container" align="center">
		<div class="vf-wide700-card" style="width: 1200px;">
			<div id="memberlist">
				<h2 class="memberlist">회원리스트</h2>
				<div align="right">
		<input type="button" id="button" class="btn btn-danger" value="강제탈퇴" onclick="memberListCheck()">
				</div>
				<form name="list" method="post" action="memberlist.do">
					<table id="memberlist" class="table">
						<thead>
							<tr>
								<th></th>
								<th>이메일</th>
								<th>이름</th>
								<th>생년월일</th>
								<th>전화번호</th>
								<th>성별</th>
								<th>가입일</th>
								<th>탈퇴일</th>
								<th>회원상태</th>
							</tr>
							<c:forEach var="l" items="${memberList}">
							<c:if test="${l.m_delstatus == 'N'}">
								<tr>
									<td><input type="checkbox" id="checkbox" name="m_email"
										value="${l.m_email}"></td>
									<td>${l.m_email}</td>
									<td>${l.m_name}</td>
									<td>${l.m_birthday}</td>
									<td>${l.m_tel}</td>
									<td>${l.m_sex}</td>
									<td><fmt:formatDate value="${l.m_regdate}"
											pattern="yy-MM-dd" /></td>
									<td><fmt:formatDate value="${l.m_deldate}"
											pattern="yy-MM-dd" /></td>
									<td>${l.m_delstatus}</td>
								</tr>
					</c:if>
							</c:forEach>
					</table>

					<div class="container" align="center">
						<ul class="pagination">

							<c:if test="${pp.startPage > pp.pagePerBlk }">
								<li><a
									href="${path}/memberList.do?pageNum=${pp.startPage - 1}">이전</a></li>
							</c:if>
							<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
								<li
								<c:if test="${pp.currentPage == i}">class="active"</c:if>>
									<a href="${path}/memberList.do?pageNum=${i}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pp.endPage < pp.totalPage}">
								<li><a
									href="${path}/memberList.do?pageNum=${pp.endPage + 1}">다음</a></li>
							</c:if>

						</ul>
					</div>


				</form>
			</div>
		</div>
	</div>
	
</body>
</html>