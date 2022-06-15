<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
 //function emailResult(){
	 /* $("#emailsearchResult").hide();
	 var email = "${shop.s_email}";
	 $("#emailsearchResult").show();
	 $("#emailsearchResult").html("<p>당신의 email은"+"<h4>"+email+"</h4>"+"입니다</p>");
	 return emailResult(); */
//	 var email= "${shop.s_email}";
//	 alert(email);
//	 alert("당신의 email은  "+email+"  입니다.");
	 //var text ="당신의 email은 " +email+ " 입니다";
	 //alert(text);
// } 
 function emailsc(){
	 $("form").submit();
	 //emailResult();
 }
</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>
<br><br><br><br>
	<div class="container" align="center">
	<div id="emailsearchResult" width="300px;" height="180px;"></div>
	
	<form method="post" action="shop_emailsearch.do" >
		
		<div class="form-group" >
			<label>이름</label><div><input type="text" id="s_ceo" name="s_ceo"></div>
		</div>
		<div class="form-group">
			<label>전화번호</label><div><input type="text" id="s_tel" name="s_tel"></div>
		</div>
		<div>
			<input type="button" id="button" value="email찾기" class="btn btn-default" onClick="emailsc()">
			<!-- <input type="submit" id="submit" name="submit" value="email찾기"> -->
		</div>
	</form>
	</div>


</body>
</html>