package market.auth;

import com.github.scribejava.core.builder.api.DefaultApi20;

// NaverLoginApi는 DefaultApi20를 상속받는다
public class NaverLoginApi extends DefaultApi20{
	protected NaverLoginApi() {
	}
	
	// 싱글톤 방식으로 NaverLoginApi 생성하기
	private static class InstanceHolder {
		private static final NaverLoginApi INSTANCE = new NaverLoginApi();
	}
	
	// 싱글톤 방식으로 객체 돌려주기
	public static NaverLoginApi instance() {
		return InstanceHolder.INSTANCE;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://nid.naver.com/oauth2.0/authorize";
	}

}
