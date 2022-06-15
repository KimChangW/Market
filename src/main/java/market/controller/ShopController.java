package market.controller;

import java.io.File;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import market.model.ShopDTO;
import market.service.PagingPgm;
import market.service.SecurePw;
import market.service.ShopServiceImpl;

@Controller
public class ShopController {
	@Autowired
	private ShopServiceImpl shopService;

	// 회원가입 폼
	@RequestMapping("shop_join_form.do")
	public String shop_join_form() {
		return "shop/shop_join_form";
	}

	// email중복검사 ajax함수로 처리부분
	@RequestMapping(value = "shop_emailcheck.do", method = RequestMethod.POST)
	public String shop_checkemail(@RequestParam("email") String s_email, Model model) throws Exception {
		System.out.println("s_email:" + s_email);

		int result = shopService.shop_emailcheck(s_email);
		model.addAttribute("result", result);

		return "shop/emailCheckResult";
	}

	// 회원가입 저장
	@RequestMapping(value = "shop_join.do", method = RequestMethod.POST)
	public String shop_join(@RequestParam("s_file1") MultipartFile mf, ShopDTO shop, HttpServletRequest request,
			Model model) throws Exception {
		System.out.println("ShopDTO:" + shop);
		System.out.println("mf:" + mf);

		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();// 첨부파일 크기

		String path = request.getRealPath("upload/shop");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("Path=" + path);
		int result = 0;

		String file[] = new String[2];
		String newfilename = "";

		if (filename != "") { // 첨부파일이 전송된 경우

			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자 jpg

			if (size > 10000000) { // 10MB
				result = 1;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			}
		}

		if (size > 0) { // 첨부파일이 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
		}

		shop.setS_file(newfilename);

		// 비밀번호 암호화
		// salt 생성하기
		String salt = SecurePw.getSalt();
		byte[] password = shop.getS_passwd().getBytes(); // 비밀번호 byte화

		String hashedPw = null;

		try {
			hashedPw = SecurePw.hashing(password, salt);

			System.out.println("salt = " + salt);
			System.out.println("hashedPw = " + hashedPw);
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[ShopController hasing Error] : SecurePw.hashing Exception");
			e.printStackTrace();
		}

		shop.setS_seckey(salt);
		shop.setS_passwd(hashedPw);

		int result1 = 0;
		result1 = shopService.insertShop_join(shop);

		model.addAttribute("result1", result1);
		return "shop/joinResult";
	}

	// 판매자 페이지 경로
	@RequestMapping("shop_page.do")
	public String shop_page() {
		return "shop_page/shop_page";
	}

	// 로그인 폼
	@RequestMapping("shop_login_form.do")
	public String shop_login_form() {
		return "shop/shop_login_form";
	}

	// 로그인 인증
	@RequestMapping(value = "shop_login.do", method = RequestMethod.POST)
	public String shop_login(@RequestParam("s_email") String s_email, @RequestParam("s_passwd") String s_passwd,
			HttpSession session, Model model) throws Exception {
		int result = 0;
		ShopDTO shop = shopService.userCheck(s_email);

		if (shop == null) { // 등록되지 않은 회원
			result = 1;
			model.addAttribute("result", result);
			return "shop/loginResult";

		} else { // 등록된 회원 일때
			String salt = shop.getS_seckey();
			
			byte[] password = s_passwd.getBytes(); // 비밀번호 byte화

			String hashedPw = null;

			try {
				hashedPw = SecurePw.hashing(password, salt);

				System.out.println("salt = " + salt);
				System.out.println("hashedPw = " + hashedPw);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("[ShopController hasing Error] : SecurePw.hashing Exception");
				e.printStackTrace();
			}
			if (shop.getS_passwd().equals(hashedPw)) {
				session.setAttribute("s_email", s_email);
				int s_no = shop.getS_no();
				session.setAttribute("s_no", s_no);
				String s_status = shop.getS_status();
				session.setAttribute("s_status", s_status);
				System.out.println("s_status:" + s_status);
				model.addAttribute("shop", shop);
				return "shop_page/shop_page";

				/*
				 * if(shop.getS_passwd().equals(s_passwd)) { session.setAttribute("s_email",
				 * s_email); int s_no = shop.getS_no(); session.setAttribute("s_no", s_no);
				 * String s_status =shop.getS_status(); session.setAttribute("s_status",
				 * s_status); System.out.println("s_status:"+s_status);
				 * model.addAttribute("shop", shop); return "shop_page/shop_page";
				 */

			} else { // 비번이 다를 때

				result = 2;
				model.addAttribute("result", result);

				return "shop/loginResult";
			}
		}
	}

	// 상점 정보 보기
	@RequestMapping("shop_info.do")
	public String shop_info(HttpSession session, Model model) throws Exception {

		String s_email = (String) session.getAttribute("s_email");

		ShopDTO shop = shopService.userCheck(s_email);
		model.addAttribute("shop", shop);
		if (shop.getS_myself() != null) {
			String myself = shop.getS_myself().replaceAll("\n", "<br>");
			model.addAttribute("myself", myself);
		}
		return "shop/shop_info_form";
	}

	// 상점 정보 수정 폼
	@RequestMapping("shop_info_edit_form.do")
	public String shop_info_edit_form(HttpSession session, Model model) throws Exception {
		String s_email = (String) session.getAttribute("s_email");

		ShopDTO shop = shopService.userCheck(s_email);
		model.addAttribute("shop", shop);

		return "shop/shop_info_edit_form";
	}

	// 상점 정보 수정
	@RequestMapping(value = "shop_info_edit.do", method = RequestMethod.POST)
	public String shop_info_edit(@RequestParam("s_file1") MultipartFile mf,
			@RequestParam("s_profile1") MultipartFile mp, @RequestParam("s_myself") String s_myself, 
			@RequestParam("s_passwd") String s_passwd , ShopDTO shop,
			HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception {

		System.out.println("ShopDTO:" + shop);
		System.out.println("mf:" + mf);
		System.out.println("mp:" + mp);

		String filename = mf.getOriginalFilename();
		String filename1 = mp.getOriginalFilename();
		int size = (int) mf.getSize();// 첨부파일 크기
		int size1 = (int) mp.getSize();// 첨부파일 크기

		String path = request.getRealPath("upload/shop");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("filename1=" + filename1); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("size1=" + size1);
		System.out.println("Path=" + path);
		int result = 0;

		String file[] = new String[2];
		String newfilename = "";
		String newfilename1 = "";

		if (filename != "") { // 첨부파일이 전송된 경우

			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자 jpg

			if (size > 10000000) { // 10MB
				result = 1;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			}
		}
		if (filename1 != "") { // 첨부파일이 전송된 경우

			// 파일 중복문제 해결
			String extension1 = filename1.substring(filename1.lastIndexOf("."), filename1.length());
			System.out.println("extension1:" + extension1);

			UUID uuid = UUID.randomUUID();

			newfilename1 = uuid.toString() + extension1;
			System.out.println("newfilename1:" + newfilename1);

			StringTokenizer st = new StringTokenizer(filename1, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자 jpg

			if (size > 10000000) { // 10MB
				result = 1;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "shop/uploadResult";
			}
		}

		if (size > 0) { // 첨부파일이 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
			System.out.println("file 전송");
		}
		if (size1 > 0) { // 첨부파일이 전송된 경우
			mp.transferTo(new File(path + "/" + newfilename1));
			System.out.println("profile 전송");
		}

		String s_email = (String) session.getAttribute("s_email"); //세션 공유

		ShopDTO no_editfile = shopService.userCheck(s_email);

		if (size > 0) { // 첨부 파일이 수정됨
			shop.setS_file(newfilename);
			System.out.println("file 첨부파일이 수정됨");
		} else { // 첨부 파일이 수정되지 않으면 다시 넣어줌
			shop.setS_file(no_editfile.getS_file());
			System.out.println("file 첨부파일이 수정안됨");
		}
		if (size1 > 0) { // 첨부 파일이 수정됨
			shop.setS_profile(newfilename1);
			System.out.println("profile 첨부파일이 수정됨");
		} else { // 첨부 파일이 수정되지 않으면 다시 넣어줌
			shop.setS_profile(no_editfile.getS_profile());
			System.out.println("profile 첨부파일이 수정안됨");
		}
		// 암호와된 비밀번호 비교
		String salt = no_editfile.getS_seckey();
		
		byte[] password = s_passwd.getBytes(); // 비밀번호 byte화

		String hashedPw = null;

		try {
			hashedPw = SecurePw.hashing(password, salt);

			System.out.println("salt = " + salt);
			System.out.println("hashedPw = " + hashedPw);
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[ShopController hasing Error] : SecurePw.hashing Exception");
			e.printStackTrace();
		}
		if (no_editfile.getS_passwd().equals(hashedPw)) {
			
			/*
			 * session.setAttribute("s_email", s_email); int s_no = no_editfile.getS_no();
			 * session.setAttribute("s_no", s_no); String s_status =
			 * no_editfile.getS_status(); session.setAttribute("s_status", s_status);
			 * System.out.println("s_status:" + s_status);
			 */
			// String myself= s_myself.replace("\n","<br>");
			shop.setS_email(s_email);
			shop.setS_myself(s_myself);
			int result4 = 0;
			result4 = shopService.shop_info_edit(shop);
			System.out.println("result1:" + result4);
			model.addAttribute("result4", result4);
			return "shop/shop_info_editResult";
		}

//		    PrintWriter out = response.getWriter();
//		    if(result1 == 1) {
//		    	out.println("<script>");
//		    	out.println("alert('수정이 완료되었습니다');");
//		    	out.println("</script>");
//		    }else {
//		    	out.println("<script>");
//		    	out.println("alert('수정을 실패하였습니다');");
//		    	out.println("history.go(-1);");
//		    	out.println("</script>");
//		    	out.close();
//		    	return null;
//		    }
		return "shop/shop_info_editResult";
	}

	// 비밀번호 변경 폼
	@RequestMapping("shop_info_changepwform.do")
	public String shop_info_changepw_form(HttpSession session, Model model) throws Exception {
		String s_email = (String) session.getAttribute("s_email");
		model.addAttribute("s_email", s_email);
		return "shop/shop_info_changepw_form";
	}

	// 비밀번호 변경
	@RequestMapping(value = "shop_info_changepw.do", method = RequestMethod.POST)
	public String shop_info_changepw(@RequestParam("s_passwded") String s_passwded, HttpSession session, 
			Model model) throws Exception {
		System.out.println(s_passwded);
		String s_email = (String) session.getAttribute("s_email");
		ShopDTO shop = shopService.userCheck(s_email);
		
		String salt = shop.getS_seckey();
		
		byte[] password = s_passwded.getBytes(); // 비밀번호 byte화

		String hashedPw = null;

		try {
			hashedPw = SecurePw.hashing(password, salt);

			System.out.println("salt = " + salt);
			System.out.println("hashedPw = " + hashedPw);
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[ShopController hasing Error] : SecurePw.hashing Exception");
			e.printStackTrace();
		}
		shop.setS_email(s_email);
		shop.setS_passwd(hashedPw);
		int result = shopService.shop_info_changepw(shop);
		model.addAttribute("result", result);
		return "shop/emailCheckResult"; // 콜백
	}

	// 폐점 신청 폼
	@RequestMapping("shop_del_form.do")
	public String shop_del_form(HttpSession session, Model model) throws Exception {
		String s_email = (String) session.getAttribute("s_email");

		ShopDTO shop = shopService.userCheck(s_email);

		model.addAttribute("shop", shop);

		return "shop/shop_del_form";
	}

	// 폐점으로 바꾸기
	@RequestMapping(value = "shop_del.do", method = RequestMethod.POST)
	public String shop_del(@RequestParam("s_passwd") String s_passwd, @RequestParam("s_reason") String s_reason,
			HttpSession session, HttpServletRequest request) throws Exception {
		String s_email = (String) session.getAttribute("s_email");
		ShopDTO shop = shopService.userCheck(s_email);

		if (!shop.getS_passwd().equals(s_passwd)) {

			return "shop/shopdelResult";
		} else { // 비번이 같은 경우

			String up = request.getRealPath("upload/shop");
			String fname = shop.getS_file();
			System.out.println("up:" + up);
			System.out.println("fname:" + fname);

			// 디비에 저장된 기존 이진파일명을 가져옴
			if (fname != "") {// 기존 이진파일이 존재하면

				File delFile = new File(up);
				delFile.mkdir();
				File[] f = delFile.listFiles();

				for (int i = 0; i < f.length; i++) {
					if (f[i].getName().equals(fname)) {
						f[i].delete(); // 기존 이진파일을 삭제
					}
				}

			}
			ShopDTO dels = new ShopDTO();
			dels.setS_email(s_email);
			;
			dels.setS_reason(s_reason);

			shopService.shop_del(dels);// 삭제 메서드 호출

			session.invalidate(); // 세션만료

			return "redirect:shop_login_form.do";
		}
	}

	// 관리자 shoplist 입점 신청 내역
	@RequestMapping("shopList.do")
	public String shoplist(String pageNum, ShopDTO shop, Model model) throws Exception {

		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// 입점 신청 총데이터 갯수 구하기
		int total = shopService.getTotal(shop);
		System.out.println("total:" + total);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		// 페이징처리 클래스 import받기
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		shop.setStartRow(startRow);
		shop.setEndRow(endRow);
		int no = total - startRow + 1;
		// 입점신청 데이터 list로 구해오기
		List<ShopDTO> shoplist = shopService.shoplist();

		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		model.addAttribute("shoplist", shoplist);

		return "admin_page/shopList";
	}

	// 체크박스로 입점승인
	@RequestMapping(value = "shopList_check.do", method = RequestMethod.POST)
	// @ResponseBody @RequestBody
//	 public String shopList_check(Map<String, Object> arr) throws Exception{
//		 public String shopList_check(HttpServletRequest request) throws Exception{
	public String shopList_check(@RequestParam(value = "arr[]") List<String> arrlist, Model model) throws Exception {

//		 String[] str = request.getParameterValues("arr");
		System.out.println(arrlist);

		int result = 0;
		for (String e : arrlist) {
			result = shopService.shopList_check(e);
		}
//		 Map<String, String> param = new HashMap<String,String>();
//		 param.putAll(paramMap);
//		 System.out.println(paramMap.entrySet());
//		 System.out.println("arr:"+ arr); 
//		 System.out.println("arr:"+paramMap.get("arr")); 

		// shopService.shopList_check(param);
		model.addAttribute("result", result);
		return "shop/shopList_checkResult";
	}

	// 관리자 shoplist 회원 내역
	@RequestMapping("shopListdel.do")
	public String shoplistdel(String pageNum1, ShopDTO shop, Model model) throws Exception {

		final int rowPerPage = 10;
		if (pageNum1 == null || pageNum1.equals("")) {
			pageNum1 = "1";
		}
		int currentPage = Integer.parseInt(pageNum1);
		// 회원 총데이터 갯수 구하기
		int total = shopService.getTotal2(shop);
		int startRow1 = (currentPage - 1) * rowPerPage + 1;
		int endRow1 = startRow1 + rowPerPage - 1;
		// 페이징처리 클래스 import받기
		PagingPgm pp1 = new PagingPgm(total, rowPerPage, currentPage);
		shop.setStartRow(startRow1);
		shop.setEndRow(endRow1);
		int no1 = total - startRow1 + 1;
		// 모든 데이터 list로 구해오기
		List<ShopDTO> shoplist1 = shopService.shoplist1();

		model.addAttribute("no1", no1);
		model.addAttribute("pp1", pp1);
		model.addAttribute("shoplist1", shoplist1);

		return "admin_page/shopList_del";
		// return "redirect:shopList.do";
	}

	// 관리자 shoplist에서 email클릭시 view페이지 보여주기
	@RequestMapping("shopListView.do")
	public String shopListView(@RequestParam("s_email") String s_email, Model model) throws Exception {
		System.out.println(s_email);
		ShopDTO shop = shopService.shopListView(s_email);
		model.addAttribute("shop", shop);
		return "admin_page/shopListView";
	}

	// 체크박스로 강제폐점
	@RequestMapping(value = "shopList_del.do", method = RequestMethod.POST)

	public String shopList_del(@RequestParam(value = "arrdel[]") List<String> arrdelList, Model model)
			throws Exception {

		System.out.println(arrdelList);

		int result = 0;
		for (String e : arrdelList) {
			result = shopService.shopList_del(e);
		}

		model.addAttribute("result", result);

		return "shop/shopList_checkResult";
	}

	// 비밀번호 찾기 폼
	@RequestMapping("shop_passwd_form.do")
	public String shop_passwd_form() throws Exception {
		return "shop/shop_passwd_form";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "shop_passwd.do", method = RequestMethod.POST)
	public String shop_passwd(@RequestParam("s_email") String s_email, @RequestParam("s_ceo") String s_ceo,
			@RequestParam("s_tel") String s_tel, Model model) throws Exception {

		ShopDTO shop = shopService.shop_passwd(s_email);

		int result = 0;
		if (shop == null) { // 회원이 아닐 때
			result = 1;
			System.out.println(result);
			model.addAttribute("result", result);
			return "shop/shop_passwdResult";
		} else if (shop.getS_ceo().equals(s_ceo) && shop.getS_tel().equals(s_tel)
				&& shop.getS_email().equals(s_email)) {// 회원일 때
			result = 2;
			System.out.println(result);
			String uupw = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.
			uupw = uupw.substring(0, 10); // uupw를 앞에서부터 10자리 잘라줌.
			System.out.println("uupw:" + uupw);
			shop.setS_email(s_email);
			shop.setS_ceo(s_ceo);
			shop.setS_tel(s_tel);
			
			// 비밀번호 암호화
			// salt 생성하기
			String salt = shop.getS_seckey();
			byte[] password = uupw.getBytes(); // 비밀번호 byte화

			String hashedPw = null;

			try {
				hashedPw = SecurePw.hashing(password, salt);

				System.out.println("salt = " + salt);
				System.out.println("hashedPw = " + hashedPw);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("[ShopController hasing Error] : SecurePw.hashing Exception");
				e.printStackTrace();
			}

			
			shop.setS_passwd(hashedPw);
			
			//shop.setS_passwd(uupw);
			shopService.shop_passwdUpdate(shop);

			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.gmail.com";
			String hostSMTPid = "gcmarket99@gmail.com";
			String hostSMTPpwd = "rhkcoakzpt99"; // Email 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "gcmarket99@gmail.com";
			String fromName = "과채마켓관리자";
			String subject = "판매자 임시비밀번호 발급";

			// 받는 사람 E-Mail 주소
			String mail = shop.getS_email();
			// String mail = "sung-ho413@hanmail.net";

			try {
				HtmlEmail email = new HtmlEmail(); // HtmlEmail: Email 라이브러리 import
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true); // 보안프로토콜로 true면 프로토콜 사용하겠다는 의미
				email.setHostName(hostSMTP);
				email.setSmtpPort(465); // 네이버의 SMTOPORT번호를 알아야함

				email.setAuthentication(hostSMTPid, hostSMTPpwd); // id와 비번이 일치해야 인증받아서 메일이 보내짐
				email.setTLS(true);
				email.addTo(mail, charSet); // addTo는 받는 사람으로 받는 사람 email를 설정해야함
				email.setFrom(fromEmail, fromName, charSet); // setForm 보내는 사람 정보설정
				email.setSubject(subject); // setSubject는 subject변수에 저장된 내용을 보내줌
				email.setHtmlMsg("<p align = 'center'>과채마켓 관리자 입니다.</p>"
						+ "<p align = 'center'>임시비밀번호를 발급해 드립니다. 비밀번호는 별도로 수정해주시기 바랍니다.</p><br>"
						+ "<div align='center'> 임시비밀번호: " + uupw + "</div>");
				email.send(); // .send()를 쓰면 메일이 전송됨
			} catch (Exception e) {
				System.out.println(e);
			}
			model.addAttribute("result", result);

			return "shop/shop_passwdResult";
		} else {// 입력정보가 올바르지 않을 때
			System.out.println(result);
			model.addAttribute("result", result);
			return "shop/shop_passwdResult";
		}
	}

	// email 찾기 폼
	@RequestMapping("shop_emailsearch_form.do")
	public String shop_emailsearch_form() throws Exception {
		return "shop/shop_emailsearch";
	}

	// email 찾기
	@RequestMapping("shop_emailsearch.do")
	public String shop_emailsearch(@RequestParam("s_ceo") String s_ceo, @RequestParam("s_tel") String s_tel,
			ShopDTO shop, Model model) throws Exception {
		System.out.println(s_ceo);
		System.out.println(s_tel);
		shop.setS_ceo(s_ceo);
		shop.setS_tel(s_tel);

		shop = shopService.shop_emailsearch(shop);
		
		model.addAttribute("shop", shop);

		return "shop/shop_emailsearchResult";
	}

}
