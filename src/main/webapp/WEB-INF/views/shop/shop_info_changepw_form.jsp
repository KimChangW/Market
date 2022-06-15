<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
 function pwResult(){
	 
  if($.trim($("#s_passwded").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#s_passwded").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwd2").val())==""){
		 alert("비밀번호확인을 해주세요!");
		 $("#s_passwd2").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwded").val()) != $.trim($("#s_passwd2").val())){
		 //!=같지않다 연산. 비번이 다를 경우
		 alert("비밀번호가 다릅니다!");
		 $("#s_passwded").val("");
		 $("#s_passwd2").val("");
		 $("#s_passwded").focus();
		 return false;
	 } 
	 
	 $("#changepwResult").hide();
	 var s_passwded=$("#s_passwded").val();
	 console.log(s_passwded);
	 $.ajax({
		 type:"post",
		 url:"shop_info_changepw.do",
		 data: {"s_passwded":s_passwded},
		 success: function(data){
			// alert(data);
			 if(data==1){	//중복 ID
				 
		      	var newtext='<font color="red">비밀번호를 변경하였습니다</font>';
		      		$("#changepwResult").text('');
		        	$("#changepwResult").show();
		        	$("#changepwResult").append(newtext);
		          	
		          	setTimeout(function () { location.reload(); }, 1000); //1초후 새로고침
		        	//location.reload();
		          	return false;
			     
		      	  }else{	//사용 가능한 ID
		      		var newtext='<font color="blue">비밀번호를 변경하지 못했습니다.</font>';
		      		$("#changepwResult").text('');
		      		$("#changepwResult").show();
		      		$("#changepwResult").append(newtext);
		      		$("#s_passwded").focus();
		      		
		      	  }
		 },error:function(request,status,error){
             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }
	 });
	 
 }

</script>

</head>
<body>
<div class="change" style="width:300px; height:200px;">
	<!-- <form method="post" action="shop_info_changepw.do"> -->
	<%-- <input type="hidden" id="s_email" name="s_email" value="${s_email}"> --%>
		<div class="form-group" >
			<label >비밀번호 변경</label><div><input type="password" id="s_passwded" name="s_passwded"></div>
		</div>
		<div class="form-group" >
			<label>비밀번호 확인</label><div><input type="password" id="s_passwd2" name="s_passwd2"></div>
		</div>
		<div>
			<input type="button" id="button" value="변경" onClick="pwResult()">
		</div>
	<!-- </form>	 -->
	<div id="changepwResult"></div>
	</div>
</body>
</html>