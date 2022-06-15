
 function Check(){
	 if($.trim($("#s_email").val())==""){
		 alert("이메일을 입력하세요!");
		 $("#s_email").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwd").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#s_passwd").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwd1").val())==""){
		 alert("비밀번호확인을 해주세요!");
		 $("#s_passwd1").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwd").val()) != $.trim($("#s_passwd1").val())){
		 //!=같지않다 연산. 비번이 다를 경우
		 alert("비밀번호가 다릅니다!");
		 $("#s_passwd").val("");
		 $("#s_passwd1").val("");
		 $("#s_passwd").focus();
		 return false;
	 }
	 if($.trim($("#s_name").val())==""){
		 alert("상호명을 입력하세요!");
		 $("#s_name").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_ceo").val())==""){
		 alert("대표자명을 입력하세요!");
		 $("#s_ceo").val("").focus();
		 return false;
	 }
	
	 if($.trim($("#s_bizno").val())==""){
		 alert("사업자번호를 입력하세요!");
		 $("#s_bizno").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_tongsin").val())==""){
		 alert("통신판매업번호를 입력하세요!");
		 $("#s_tongsin").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_post").val())==""){
		 alert("우편번호를 입력하세요!");
		 $("#s_post").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_address").val())==""){
		 alert("주소를 입력하세요!");
		 $("#s_address").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_tel").val())==""){
		 alert("전화번호를 입력하세요!");
		 $("#s_tel").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_bank").val())==""){
		 alert("은행명을 입력하세요!");
		 $("#s_bank").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_account").val())==""){
		 alert("정산계좌를 입력하세요!");
		 $("#s_account").val("").focus();
		 return false;
	 }
	  if($.trim($("#s_file").val())==""){
		 alert("서류를 첨부해주세요!");
		 $("#s_file").val("").focus();
		 return false;
	 }
	 	 
 }

/*function button(){
	$("#submit").attr("disabled", true);
	alert("email중복검사를 해주세요!");
}*/





 
//function post_search(){
//	alert("우편번호 검색 버튼을 클릭하세요!");
//}
//
//function post_check(){
//	window.open("zipcode_find.nhn","우편번호검색",
//			"width=420,height=200,scrollbars=yes");
//	//폭이 420이고 높이가 200,스크롤바가 생성되는 새로운 공지창을 만듬
//}

/* 아이디 중복 체크*/
function email_check(){
	$("#emailcheck").hide();//idcheck span 아이디 영역을 숨긴다.
	var email=$("#s_email").val();
	

	//입력아이디 유효성 검사
	if(!(validate_userid(email))){ //밑에서 정의한 validate_userid(memid)함수는 일치하지 않을 때 false를 리턴하기 때문에 !를 붙여 true로 조건을 만듬
		var newtext='<font color="red">email에 @와 .com을 입력해주세요</font>';
		$("#emailcheck").text('');//문자 초기화
		$("#emailcheck").show();//span 아이디 영역을 보이게 한다.
		$("#emailcheck").append(newtext);
		$("#s_email").val("").focus();
		return false;
	};
	

	//아이디 중복확인
    $.ajax({
        type:"POST",
        url:"shop_emailcheck.do",
        data: {"email":email},        
        success: function (data) { 
        	//alert("return success="+data);
      	  if(data==1){	//중복 ID
      		var newtext='<font color="red">중복 email입니다.</font>';
      			$("#emailcheck").text('');
        		$("#emailcheck").show();
        		$("#emailcheck").append(newtext);
          		$("#s_email").val('').focus();
          		$("#submit").attr("disabled", true);
          		return false;
	     
      	  }else{	//사용 가능한 ID
      		var newtext='<font color="blue">사용가능한 email입니다.</font>';
      		$("#emailcheck").text('');
      		$("#emailcheck").show();
      		$("#emailcheck").append(newtext);
      		$("#s_passwd").focus();
      		$("#submit").attr("disabled", false);
      	  }  	    	  
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });//$.ajax	
};
/*아이디 중복 체크 끝*/

function validate_userid(email){
		var pattern= new RegExp(/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/i);
		//'~~~@~~~.~~~' 형식이다.
		//'@' 앞에 오는 이메일 계정 이름에는 알파벳과 숫자, '_', '-', '+', '.'의 조합만 허용한다.
		//'@'과 '.' 사이의 도메인명은 알파벳과 숫자, '-'의 조합만 허용한다.
		//'.' 뒤의 최상위 도메인은 알파벳과 숫자만 사용할 수 있으며, 그 길이는 2~4글자이다.
		//대소문자는 무시한다.
		
		//영문 소문자,숫자 ,_가능,정규표현식
		return pattern.test(email); //pattern.test()는 값이 일치하면 true리턴함
	};
 
//function domain_list() {
//	 var num=f.mail_list.selectedIndex;
//	/*selectedIndex속성은 select객체하위의 속성으로서 해당리스트 목록번호를 반환
//	*/
//	if ( num == -1 ) {
//	//num==-1은 해당 리스트목록이 없다
//	return true;
//	 }
//	 if(f.mail_list.value=="0") // 직접입력
//	 {
//	/*리스트에서 직접입력을 선택했을때*/
//	 f.join_maildomain.value="";
//	//@뒤의 도메인입력란을 빈공간시켜라.
//	 f.join_maildomain.readOnly=false;
//	//@뒤의 도메인입력란을 쓰기 가능
//	f.join_maildomain.focus();
//	//도메인입력란으로 입력대기상태
//	}
//	 
//	 else {
//	//리스트목록을 선택했을때
//	 
//	f.join_maildomain.value=f.mail_list.options[num].value;
//	/*num변수에는 해당리스트 목록번호가 저장되어있다.해당리스트 번호의 option value값이 도메인입력란에 선택된다.options속성은 select객체의 속성으로서 해당리스트번호의 value값을 가져온다
//	*/
//	f.join_maildomain.readOnly=true;
//	 }
// }

 
 /* 회원정보 수정 경고창 */
function edit(){
	
	if($.trim($("#s_passwd").val())==""){
		alert("비밀번호를 입력하세요!");
		$("#s_passwd").val("").focus();
		return false;
	}
	/* if($.trim($("#s_passwd1").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#s_passwd1").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_passwd").val()) != $.trim($("#s_passwd1").val())){
		 //!=같지않다 연산. 비번이 다를 경우
		 alert("비번이 다릅니다!");
		 $("#s_passwd1").val("");
		
		 $("#s_passwd1").focus();
		 return false;
	 }*/
	 if($.trim($("#s_name").val())==""){
		 alert("상호명을 입력하세요!");
		 $("#s_name").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_ceo").val())==""){
		 alert("대표자명을 입력하세요!");
		 $("#s_ceo").val("").focus();
		 return false;
	 }
	
	 if($.trim($("#s_bizno").val())==""){
		 alert("사업자번호를 입력하세요!");
		 $("#s_bizno").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_tongsin").val())==""){
		 alert("통신판매업번호를 입력하세요!");
		 $("#s_tongsin").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_post").val())==""){
		 alert("우편번호를 입력하세요!");
		 $("#s_post").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_address").val())==""){
		 alert("주소를 입력하세요!");
		 $("#s_address").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_tel").val())==""){
		 alert("전화번호를 입력하세요!");
		 $("#s_tel").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_bank").val())==""){
		 alert("은행명을 입력하세요!");
		 $("#s_bank").val("").focus();
		 return false;
	 }
	 if($.trim($("#s_account").val())==""){
		 alert("정산계좌를 입력하세요!");
		 $("#s_account").val("").focus();
		 return false;
	 }
	//  alert("수정이 완료되었습니다.");
}
 
 












 
 
 
 