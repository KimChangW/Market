package market.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import market.model.Order_manageDTO;
import market.model.Order_productDTO;
import market.service.PagingPgm;
import market.service.ShopManageService;

@Controller
public class ShopManageController {

	@Autowired
	private ShopManageService sms;

	// 판매자 주문 리스트
	@RequestMapping("order_tabList.do")
	public String order_tabList(HttpSession session, HttpServletRequest request, Model model, String pageNum,
			Order_manageDTO order_manage) {

		session = request.getSession();

		int s_no = (int) session.getAttribute("s_no");

		order_manage.setS_no(s_no);

		final int rowPerPage = 5;

		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}

		int currentPage = Integer.parseInt(pageNum);

		int total = sms.getTotal(s_no);

		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);

		order_manage.setStartRow(startRow);
		order_manage.setEndRow(endRow);

		int no = total - startRow + 1;

		List<Order_manageDTO> olist = sms.olist(order_manage);
		model.addAttribute("olist", olist);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);

		return "shop_page/order_tabList";
	}

	// 주문처리상세
	@RequestMapping("shopOrderDetail.do")
	public String orderDetail(int o_no, Model model) {

		System.out.println("넘겨받은주문번호: " + o_no);

		List<Order_manageDTO> odlist = sms.odlist(o_no);
		model.addAttribute("odlist", odlist);

		return "shop_page/shopOrderDetail";
	}

	// 환불관리
	@RequestMapping("refundList.do")
	public String refundList(HttpSession session, HttpServletRequest request, Model model) {

		session = request.getSession();

		int s_no = (int) session.getAttribute("s_no");

		List<Order_productDTO> oplist = sms.oplist(s_no);
		model.addAttribute("oplist", oplist);

		return "shop_page/refundList";
	}

	// 환불승인
	@RequestMapping("refundOk")
	public String refundOk(Model model, int op_no, int o_no, String m_email) {
		
		int result = sms.refundOk(op_no);
		model.addAttribute("result", result);

		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "gcmarket99@gmail.com";
		String hostSMTPpwd = "rhkcoakzpt99";

		// 보내는 사람 Email, 제목, 내용
		String fromEmail = "gcmarket99@gmail.com";
		String fromName = "마켓관리자";
		String subject = "[과채마켓] 요청하신 환불 신청건이 처리되어 안내드립니다.";

		// 메일 송신
		String mail = m_email; // 수신받을 회원 이메일주소
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

			email.setHtmlMsg("<p align=center>요청하신 환불 신청건이 처리되었습니다.</p><br><p align=center>환불 금액이 다시 입금되기까지는 결제한</p><br><p align=center>수단에 따라 영업일 기준 최대 10일이</p><br><p align=center>걸릴수 있으니 이점 참고하시기 바랍니다.</p><br>");
			email.send();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "shop_page/refundOkResult";
	}

	// 환불거부
	@RequestMapping("refundNo")
	public String refundNo(Model model, int op_no, int o_no) {

		int result = sms.refundNo(op_no);

		model.addAttribute("result", result);

		return "shop_page/refundNoResult";
	}

	// 운송장 입력버튼 눌렀을때
	@RequestMapping("deliInsert.do")
	public String delivery(Model model, String dno, int opno, int o_no) {

		System.out.println("상품번호 : " + opno);
		System.out.println("운송장번호 : " + dno);
		System.out.println("받아온 o_no값은 ? : " + o_no);

		Order_manageDTO omdto = new Order_manageDTO();

		omdto.setOp_deli_no(dno);
		omdto.setOp_status("6");
		omdto.setOp_no(opno);

		int result = sms.deliNoInsert(omdto);

		if (result == 1)
			System.out.println("운송장번호 입력성공!");

		model.addAttribute("o_no", o_no);
		model.addAttribute("result", result);

		return "shop_page/deliInsertResult";
	}

	// 배송완료처리
	@RequestMapping("deliOk.do")
	public String deliOk(Model model, int op_no, int o_no) {

		int result = sms.deliOk(op_no);

		model.addAttribute("result", result);
		model.addAttribute("o_no", o_no);

		return "shop_page/deliOkResult";
	}

	// 품절취소
	@RequestMapping("shopOrderCancel.do")
	public String shopOrderCancel(int o_no, int op_no, String p_name, String m_email, Model model) {
		Order_manageDTO omdto = new Order_manageDTO();

		omdto.setOp_status("5");
		omdto.setOp_no(op_no);

		int result = sms.cancel(omdto);

		if (result == 1) {
			System.out.println("품절취소 상태변경 성공!");
		}

		model.addAttribute("o_no", o_no);
		model.addAttribute("result", result);

		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "gcmarket99@gmail.com";
		String hostSMTPpwd = "rhkcoakzpt99";

		// 보내는 사람 Email, 제목, 내용
		String fromEmail = "gcmarket99@gmail.com";
		String fromName = "마켓관리자";
		String subject = "[과채마켓] 품절로 인한 주문취소가 발생되어 안내드립니다.";

		// 메일 송신
		String mail = m_email; // 수신받을 회원 이메일주소
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

			email.setHtmlMsg("<p align='center'>주문하신 " + p_name + " 상품이 품절되어 취소안내 메일보내드립니다.</p>");
			email.send();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "shop_page/shopCancelResult";
	}

}
