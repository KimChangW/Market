package market.auth;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.oauth.OAuth20Service;

public class NaverLoginBO {
	
	// 네이버 애플리케이션에서 가져온 기본정보를 전역변수로 설정
	private final static String CLIENT_ID = "YuP9zVu5GOivsYv31zzW";
	private final static String CLIENT_SECRET = "vEBdoAOHD5";
	private final static String REDIRECT_URI = "http://54.180.153.210/callback.do";
	private final static String SESSION_STATE = "oauth_state";
	/* 프로필 조회 API URL */ 
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";

	//네이버 아이디로 인증 URL 생성 Method
	public String getAuthorizationUrl(HttpSession session) {
		String state = generateRandomString();
		setSession(session, state);
		
		// 빌드 방식으로 OAuth20Service 객체 생성
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state)
				.build(NaverLoginApi.instance());
		
		return oauthService.getAuthorizationUrl();
		
	}
	
	// 액세스 토큰 얻어오기
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) 
			throws IOException{
		String sessionState = getSession(session);
		if(StringUtils.pathEquals(sessionState, state)) {
			
			OAuth20Service oauthService = new ServiceBuilder()
					.apiKey(CLIENT_ID)
					.apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI)
					.state(state)
					.build(NaverLoginApi.instance());
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}
	
	// 랜덤 문자 생성으로 oauth_state 값 설정
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}
	
	// 액세스 토큰으로 유저정보 받아오기
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
		
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).build(NaverLoginApi.instance());
		
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);	
		Response response = request.send();
		
		return response.getBody();
	}
	
	
}
