<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('8bc04ead732cd20712b9651a91283c59'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
        	 var email =response.kakao_account.email;
        	  location.href="kakaologin.do?email="+email;
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
</head>
<body>
<%@ include file="../common/header.jsp"%>

	<div class="container" align=center>
		<div class="vf-wide300-card">
	<div id="loginform" class="form-group">
		<h2 class="login_title">로그인</h2>
		<form name="l" method="post" action="loginCheck.do" onSubmit="return loginf()">
			<table id="logintable" class = "table" style = "margin:3px">
				<tr>
					<th>이메일</th>
					<td><input type="text" name="m_email" id="m_email" size="20"
						class="form-control" required="required"/></td>
				</tr>

				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="m_passwd" id="m_passwd" size="20"
						class="form-control" required="required"/></td>
				</tr>
			</table>             
			<div id="login_menu">
				
			<table border=0>
				<tr>
			<!-- 	<td align="center" height=50px> -->	
					<td align="center" style="padding-bottom: 5px">    
						<input type="submit" value="로그인" class="btn-block btn btn-success" /> 
						<!-- <input type="button" value="회원가입" class="btn btn-warning"
							onClick="location='memberInsertForm.do'" />  -->
					


					</td>
				</tr>
				<tr>
					<td style="padding:0 0 5 0">
		<!-- 				<input type="button" value="아이디(이메일)찾기" class="btn btn-outline-warning" 
							onClick ="location =''"/> -->
							<a href="emailSearchForm.do"><small>아이디(이메일)찾기</small></a> |
						<!-- <input type="button" value="비밀번호찾기" class="btn btn-warning" 
							onClick ="location ='passwdSearchForm.do'"/> -->
							<a href="passwdSearchForm.do"><small>비밀번호 찾기</small></a>
					</td>
				</tr>
				<tr>
					<td>
						<!-- 네이버 로그인 창으로 이동 -->
				<div id="naver_id_login" style="text-align: center; margin-bottom:5px;">
					<a href="${url}"> <img width="182" 
						src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
				</div>
					</td>
				</tr>
				
				
						
						
							<!-- <div onclick="kakaoLogout();"><a href="javascript:void(0)">
									<span>카카오 로그아웃</span>
							</a></div> -->
						
				
					<%-- <td height=70px ><a href=""  onclick="kakaoLogin();"><img src="${path}/images/kakao_login.png" class="btn-block"></a>
						<!--<a href="" onclick="kakaoLogout();"><span>카카오 로그아웃</span> </a>-->
					</td> --%>
				
						
			</table>
							<div onclick="kakaoLogin();"><a href="javascript:void(0)">
									<a href="javascript:void(0)"><img src="${path}/images/kakao_login.png"></a>
							</a></div>
			</div>
		</form>
	</div>
	</div>
	</div>
</body>
</html>

