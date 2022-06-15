package market.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import market.auth.NaverLoginBO;
import market.model.MemberDTO;
import market.service.MemberServiceImpl;
import market.service.PagingPgm;

@Controller
public class MemberController {
	
	// NaverLoginBO 선언, 회원정보 받아올 apiResult 변수 초기화
		private NaverLoginBO naverLoginBO;
		private String apiResult = null;

		// set 메소드로 naverLoginBO 객체 주입
		@Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}

	@Autowired
	private MemberServiceImpl ms;
	private ServletRequest session;

//	// 메인페이지
//	@RequestMapping(value = "/main.do")
//	public String main() {
//		return "common/main";
//	}

	// 마이페이지
	@RequestMapping(value = "myPage.do")
	public String my_page() {
		return "my_page/myPage";

	}

	// 회원가입 폼
	@RequestMapping(value = "/memberInsertForm.do")
	public String memberInsertForm() {
		System.out.println("가입폼등장");
		return "member/memberInsertForm";

	}
	//회원가입 중 email중복검사 ajax함수 
	
		@RequestMapping(value = "memberEmailCheck.do", method = RequestMethod.POST)
		public String memberEmailCheck(@RequestParam("email") String m_email, Model model) throws Exception {
		System.out.println("m_email:"+m_email);
				
		int result = ms.memberEmailCheck(m_email);
		model.addAttribute("result", result);

		return "member/memberEmailCheckResult";
		}
	
	// 회원가입 저장
	@RequestMapping(value = "/memberInsert.do", method = RequestMethod.POST)
	public String memberInsert(MemberDTO member, Model model) throws Exception {
		System.out.println("좋아 저장됐다");
		
		int result = ms.memberInsert(member);
		if (result == 1)
			System.out.println("회원가입 성공");
		model.addAttribute("result", result);
		return "member/memberInsert";
	}

	// 로그인폼뷰, 네이버 인증 URL 생성
		@RequestMapping(value = "/loginForm.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String loginForm(Model model, HttpSession session) {
			
			// 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의
			// getAuthorizationUrl 메소드 호출 
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			
			System.out.println("네이버:" + naverAuthUrl);
			
			// 네이버로그인인증 url을 가지고 로그인 폼으로 넘어간다
			model.addAttribute("url", naverAuthUrl);
			
			return "member/loginForm";
		}
		
		// 네이버 URL로 로그인 인증후 액세스 토큰을 발급받아 해당토큰으로 회원정보를 받아온다
		@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
				throws Exception {
			System.out.println("여기는 callback 컨트롤러 들어왔냐?");
			
			//액세스 토큰을 저장할 객체 생성
			OAuth2AccessToken oauthToken;
			
			// 액세스 토큰 받아오기
			oauthToken = naverLoginBO.getAccessToken(session, code, state);
			
			//토큰으로 회원정보를 apiResult 변수에 json형태로 받아온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken);
			
			// 받아온 json 데이터를 파싱하여 원하는 요소만 추출
			// 원칙적으로 컨트롤러는 간결해야 하기 때문에 컨트롤러에 파싱 코드를 넣는건 좋은 방법이 아님
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;

			JSONObject response_obj = (JSONObject) jsonObj.get("response");
			
			//회원이름
			String name = (String) response_obj.get("name");
			
			//회원이메일
			String email = (String) response_obj.get("email");

			System.out.println(apiResult);
			
			MemberDTO loginNaver = ms.loginCheck(email);
			
			if(loginNaver==null) {
				int result = 0;
				
				MemberDTO naver = new MemberDTO();
				naver.setM_email(email);
				naver.setM_name(name);
				result = ms.naverlogin(naver);
				
				MemberDTO loginNaver2 = ms.loginCheck(email);
				
				session.setAttribute("m_email",loginNaver2.getM_email());
				
				return "redirect:main.do";
			
			}else if(loginNaver.getM_email().equals(email)) { // 등록되어 있는 회원
				session.setAttribute("m_email", email);
				return "redirect:main.do";
			}
			
			return "";
		}

	
	// 로그인인증
	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public String loginCheck(String m_email, String m_passwd, HttpSession session, Model model) throws Exception {
		System.out.println("인증갔니 자래따");

		int result = 0;
		MemberDTO loginm = ms.loginCheck(m_email);

		if (loginm == null) { // 등록되지 않은 회원일때

			result = 1;
			model.addAttribute("result", result);

			return "member/loginCheck";

		} else { // 등록된 회원일때
			if (loginm.getM_passwd().equals(m_passwd)) {
				// session.setAttribute("m_email", m_email);
				System.out.println("M_passwd" + m_passwd);
				// String m_name = loginm.getM_name();

				session.setAttribute("m_email", loginm.getM_email());

				return "redirect:main.do";
			} else { // 비번이 다를때
				result = 2;
				model.addAttribute("result", result);

				System.out.println("돌아왔니 로긴 인증성공");
				return "member/loginCheck";
			}

		}
	}
	//카카오톡 로그인
		@RequestMapping("kakaologin.do")
		public String kakaologin(@RequestParam("email") String m_email, HttpSession session)throws Exception {
			
			System.out.println("m_email:"+m_email);
			MemberDTO logink = ms.loginCheck(m_email);
			if(logink==null) {
				int result=0;
				MemberDTO kakao = new MemberDTO();
				kakao.setM_email(m_email);
				result = ms.kakaologin(kakao);
				MemberDTO logink2 = ms.loginCheck(m_email);
				session.setAttribute("m_email",logink2.getM_email());
				return "redirect:main.do";
			}else if(logink.getM_email().equals(m_email)) { // 등록되어 있는 회원
				session.setAttribute("m_email", m_email);
				return "redirect:main.do";
			}
			
			return "";
		}
	// 회원정보 확인 폼
	@RequestMapping(value = "/memberConfirmForm.do", method = RequestMethod.GET)
	public String memberConfirmForm(HttpSession session, Model model) throws Exception {

		String m_email = (String) session.getAttribute("m_email");
		System.out.println("email: " + m_email);

		MemberDTO old = ms.select(m_email);
		System.out.println("old"+old);
		model.addAttribute("old", old);

		return "member/memberConfirmForm";
	}

/*	// 회원정보 확인
	@RequestMapping(value = "/memberConfirm.do", method = RequestMethod.POST) 
	public String memberConfirm(MemberDTO member, Model model) throws Exception {
		int result = ms.memberConfirm(member);
		model.addAttribute("result", result);
		
		return "member/memberUpdatForm";
	}
	*/
	//회원정보 수정 폼
	@RequestMapping (value = "/memberUpdateForm.do", method = RequestMethod.GET)
		public String memberUpdateForm(HttpSession session, Model model) throws Exception {

			String m_email = (String) session.getAttribute("m_email");
			System.out.println("email: " + m_email);

			MemberDTO old = ms.select(m_email);
			model.addAttribute("old", old);

			return "member/memberUpdateForm";
		}
	
	//	회원정보 수정 
	@RequestMapping(value ="/memberUpdate.do", method = RequestMethod.POST)
	public String memberUpdate(@RequestParam("m_passwd2")String passwd2, 
								@RequestParam("m_passwd3") String passwd3, 
								HttpSession session, MemberDTO old, Model model,
								MemberDTO member)throws Exception{
		
		String m_email = (String)session.getAttribute("m_email");   //세션에서 이메일을 가져오는
		
		old = ms.select(m_email);      //db에 저장된 모든값을 가져와서 old에 돌려주기
		
		String oldPasswd = old.getM_passwd(); //db에 저장된 패스워드를 oldpasswd에 받은거
		
		if(oldPasswd.equals(passwd2)) {
			member.setM_passwd(passwd3);
			member.setM_email(m_email);
			
			int result = 0; 
			
			result = ms.memberUpdate(member);
			System.out.println("result: "+result);
			model.addAttribute("result", result);
		}else {
			int result = -1;
			model.addAttribute("result",result);
		}
		
		return "member/updateResult";
	}

	//비번찾기 폼
	@RequestMapping(value = "/passwdSearchForm.do")
	public String passwdSearchForm() {
		return "member/passwdSearchForm";
	}

	//비번찾기 완료 
	@RequestMapping(value = "/passwdSearch.do", method = RequestMethod.POST)
	public String passwdCheck(@ModelAttribute MemberDTO member, HttpServletResponse response,
							  @RequestParam("m_email") String m_email,
							  @RequestParam("m_name") String m_name,  Model model)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		
		int result = 0;
		MemberDTO mem = ms.passwdSearch(member);

		if (mem == null) {// 값이 없는 경우
			result=1;
			model.addAttribute("result", result);
			return "member/passwdSearchResult";

		} else {
			result=2;
			String uupw = UUID.randomUUID().toString().replaceAll("-", "");
			uupw = uupw.substring(0,10);   //uupw를 앞에서부터 10자리까지 잘라줌 
			System.out.println("uupw:"+uupw);
			
			mem.setM_email(m_email);
			mem.setM_name(m_name);
			mem.setM_passwd(uupw);
			
			ms.passwdUpdate(mem);
			
			
			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.gmail.com";
			String hostSMTPid = "gcmarket99@gmail.com";
			String hostSMTPpwd = "rhkcoakzpt99"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "gcmarket99@gmail.com";
			String fromName = "마켓관리자";
			String subject = "마켓에서 비밀번호를 알려드립니다:-)";

			// 받는 사람 E-Mail 주소
			String mail = mem.getM_email();
			System.out.println("m_email"+mail);
			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(465);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'>마켓 임시 비밀번호를 발송 해 드립니다</p><br>" + 
				"<div align='center'> 임시 비밀번호 :"  + uupw + "</div>");
				email.send();
			} catch (Exception e) {
				System.out.println(e);
			}
			model.addAttribute("result", result);
			System.out.println("result"+ result);
			model.addAttribute("passwdSearch", "등록된 email을 확인 하세요:-)");
			return "member/passwdSearchResult";
		}
		}
/*회원리스트 
	 @RequestMapping(value ="/memberList.do")
	 public String memberList(Model model)throws Exception {

		 List<MemberDTO> memberList = ms.memberList();
		 
		 model.addAttribute("memberList",memberList);
		 return "admin_page/memberList";
	 }*/
	
//회원리스트+ 페이징처리 
	 @RequestMapping("memberList.do")
	 public String memberList(String pageNum, MemberDTO member, Model model)throws Exception{
	 
		 final int rowPerPage = 10;
		 if (pageNum == null  || pageNum.equals("")) {
			 pageNum ="1";
	 }
		 int currentPage = Integer.parseInt(pageNum);
		 //총데이터 갯수 구하기 
		 int total = ms.getTotal(member);
		 int startRow = (currentPage -1) * rowPerPage +1;
		 int endRow = startRow + rowPerPage -1;
		
		 //페이징처리 클래스 import받기 
		 PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		 member.setStartRow(startRow);   //DTO에 StartRow, EndRow 를 만들어야해 getter,setter까지:-)
		 member.setEndRow(endRow);
		 int no = total - startRow +1;
	
		 //모든 데이터를 list로 구해오기 
		 List<MemberDTO> memberList = ms.memberList();
		 
		 model.addAttribute("no", no);
		 model.addAttribute("pp", pp);
		 model.addAttribute("memberList", memberList);
		 
		 
		 return "admin_page/memberList";
	 }


//회원리스트 체크박스로 강제탈퇴 
	 @RequestMapping(value="memberListCheck.do", method= RequestMethod.POST)
	 public String memberListCheck(@RequestParam(value="arr[]") 
	  								List<String> arrlist, Model model) throws Exception{
		 
		 int result = 0;
		 for(String e : arrlist) {
			 result = ms.memberListCheck(e);       
		 }
//		 return "member/memberListCheckResult";
		 return "redirect:memberList.do";		 
	 }
	 


//비번찾기 폼
		@RequestMapping(value = "/emailSearchForm.do")
		public String emailSearchForm() {
			return "member/emailSearchForm";
		}
//아이디(이메일)찾기
		@RequestMapping(value = "/emailSearch.do", method = RequestMethod.POST)
		public String passwdCheck(MemberDTO mem, Model model) throws Exception {
			
			int result = 0;
			MemberDTO member = ms.emailSearch(mem);
			
			if(member == null) {	//값이 없는경우 
				result = 1;
				model.addAttribute("result", result);
				return "member/emailSearchForm";
			}else {
				result = 2;
				model.addAttribute("m_email", member.getM_email());
				model.addAttribute("result", result);
				System.out.println("아이디(이메일)찾기 성공");
					
				return "member/emailSearchResult";
				
			}
				
			}
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();

		return "member/logout";
	}
	//회원탈퇴 폼
	@RequestMapping("memberDeleteForm.do")
	public String memberDelete(HttpSession session, Model model)throws Exception{
		
		String email = (String)session.getAttribute("m_email");
		MemberDTO deleteM = ms.select(email);
		System.out.println("db비번:" + deleteM.getM_passwd());
		
		
		model.addAttribute("m_email", email);
		model.addAttribute("deleteM", deleteM);

		System.out.println("탈퇴폼까지 왔다");
		return "member/memberDeleteForm";
	}
	
	//회원탈퇴 완료 
	@RequestMapping(value= "/memberDelete.do", method= RequestMethod.POST)
	public String memberDelete(HttpSession session, MemberDTO member, Model model)throws Exception{
				
		int result = ms.deleteMember(member);
		System.out.println("회원 탈퇴 결과:" + result);
		
		model.addAttribute("result", result);
		
		session.invalidate();		
		
		return "member/memberDeleteResult";
		
	}
}
							
	
	
	


