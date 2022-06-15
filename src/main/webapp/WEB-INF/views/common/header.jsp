<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
</style>
<!-- header 영역 -->
<div class="container">
	<table width=100%>
		<tr>
			<td valign="middle" align="right"
				style="font-size: 12px; text-decoration: none;">
	<!-- m_email세션이 없는 경우 --> 
				<c:if test="${empty sessionScope.m_email }">
					<a href="${path }/memberInsertForm.do">회원가입</a> |
					<a href="${path }/loginForm.do">로그인</a> |
				</c:if>

	<!-- m_email세션이 있는 경우 --> 
				<c:if test="${!empty sessionScope.m_email}">
					<img src="${path}/images/person-hearts.svg" width=15px>  ${sessionScope.m_email }님 환영합니다 &nbsp; |
					<a href="${path }/orderList.do">마이페이지</a> |
				</c:if>

				<c:if test="${!empty sessionScope.m_email || !empty sessionScope.s_email}">
					<a href="${path }/logout.do"><img src="${path}/images/power.svg"></a> |
				</c:if>
				
	<!-- s_email세션이 있는 경우 --> 
				<c:if test="${!empty sessionScope.s_email}">
					<a href="${path }/shop_info.do">SHOP매니저</a> |
				</c:if>
	<!-- s_email세션이 없는 경우 --> 
				<c:if test="${empty sessionScope.s_email }">
					<a href="${path }/shop_login_form.do">SHOP로그인</a> |
					<a href="${path }/shop_join_form.do">입점신청</a> |
				</c:if>	
	<!-- 관리자 세션이 있는 경우 --> 
				<c:if test="${!empty sessionScope.s_email && sessionScope.s_status =='m'}">
				<a href="${path }/memberList.do">관리자페이지</a>
				</c:if>			
			</td>
		</tr>
	<!-- 로고 (이미지) --> 
		<tr>
			<td align="center">
				<div class="vf-wide-screen">
				<table width=100% >
					<tr>
						<td align=center><a href="${path }/main.do"><img src="${path}/images/logo7.PNG" width=150px></a></td>
					</tr>
				</table>
				</div>
				<div class="vf-less-wide-screen">
				<table width=100% >
					<tr>
						<td align=center>
							<form action="${path}/productSearchList.do?pageNum=1" style="padding: 0px; margin:0px;">
								<input type=hidden name="search" value="p_name">
								<table width=100%>
									<tr>
										<td width=130px><a href="${path }/main.do"><img src="${path}/images/logo7.PNG" width=120px></a></td>
										<td><input type=text name="keyword" class="vf_search form-control" autocomplete="on"></td>
										<td width=50px align=center><input type = "image" src = "${path }/images/search.svg" width=22px alt = "검색버튼" ></td>
									</tr>
								</table>
							</form>
						</td>
					</tr>
				</table>

				</div>
			</td>
		</tr>
		<tr>
			<td>
				<!-- 메인 메뉴 (아래부분) -->
				<div class="vf_header_menu">
					<div>
						<a href="${path}/productCategoryList.do?search=cate_large&keyword=과일">
							<c:if test="${keyword == '과일'}">
								<font style="font-size: 18px; font-weight: bold;">과일</font>
							</c:if>
							<c:if test="${keyword != '과일'}">과일</c:if>
						</a>
					</div>
					<div>
						<a href="${path}/productCategoryList.do?search=cate_large&keyword=채소">
							<c:if test="${keyword == '채소'}">
								<font style="font-size: 18px; font-weight: bold;">채소</font>
							</c:if>
							<c:if test="${keyword != '채소'}">채소</c:if>
						</a>
					</div>
					<div>
						<a href="${path}/productCategoryList.do?search=cate_large&keyword=잡곡">
							<c:if test="${keyword == '잡곡'}">
								<font style="font-size: 18px; font-weight: bold;">잡곡</font>
							</c:if>
							<c:if test="${keyword != '잡곡'}">잡곡</c:if>
						</a>
					</div>
					<div>
						<a href="${path}/productSearchList.do?pageNum=1&search=p_name&keyword=">
							<c:if test="${keyword == ''}">
								<font style="font-size: 18px; font-weight: bold;">전체보기</font>
							</c:if>
							<c:if test="${keyword != ''}">전체보기</c:if>
						</a>
					</div>

					<div class="vf_header_menu_search" style="width: 210px; padding: 0px;">
						<form action="${path}/productSearchList.do?pageNum=1" style="padding: 0px; margin:0px;">
							<input type=hidden name="search" value="p_name">
							<table>
								<tr>
									<td><input type=text name="keyword" class="vf_search form-control" autocomplete="on"></td>
									<td width=25px align=right><input type = "image" src = "${path }/images/search.svg" width=22px alt = "검색버튼" ></td>
								</tr>
							</table>
						</form>
					</div>
					<div style="width: 24px; margin:0 0 0 10; padding:0 0 0 0;">
						<a href="cartList.do"><img src="${path }/images/cart2.svg" style="width:100%"></a>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
