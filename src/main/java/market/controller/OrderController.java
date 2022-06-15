package market.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sun.istack.logging.Logger;

import market.model.CartDTO;
import market.model.DeliveryDTO;
import market.model.MemberDTO;
import market.model.OrderPageDTO;
import market.model.OrderPageItemDTO;
import market.model.Order_productDTO;
import market.model.Order_tabDTO;
import market.model.ProductDTO;
import market.service.CartService;
import market.service.MemberServiceImpl;
import market.service.OrdereService;
import market.service.ProductService;
import scala.PartialFunction.OrElse;

@Controller
public class OrderController {
	
	@Autowired
	private OrdereService os;
	
	@Autowired
	private MemberServiceImpl ms;
	
	@Autowired
	private CartService cs;
	
	@Autowired
	private ProductService ps;
	
	// 주문페이지
	@RequestMapping("order.do")
	public String orderPage(HttpSession session,OrderPageDTO opd ,HttpServletRequest request, Model model) throws Exception {

		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		System.out.println("orders:"+opd.getOrders());
		
		// 주문 상품 정보
		List<OrderPageItemDTO> orders = opd.getOrders();
		List<OrderPageItemDTO> productInfo = new ArrayList<OrderPageItemDTO>();
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO product = os.getProductInfo(ord.getP_no());			

			product.setCart_qty(ord.getCart_qty());    // 주문 수량
			product.setOp_type(ord.getOp_type());      // 상품 타입(일반/팔로워/공동구매)
			product.setGroup_op_no(ord.getGroup_op_no());	// 공동구매 첫 번째 사람 op_no
			product.setGroup_order(ord.getGroup_order());	// 공동구매 순서
			
			if(product.getOp_type().equals("1")) {           // 일반 판매 상품
				product.setP_sell_price(product.getP_sell_price());
				System.out.println("일반:"+product.getP_sell_price());
				
			}else if(product.getOp_type().equals("2")) {     // 팔로우 특가 상품
				int originPrice = product.getP_sell_price();
				product.setP_sell_price(product.getP_follow_price());
				System.out.println("특가:"+product.getP_sell_price());
				
				model.addAttribute("originPrice", originPrice);
				
			}else if(product.getOp_type().equals("3")) {     // 공동구매 상품
				int originPrice = product.getP_sell_price();
				product.setP_sell_price(product.getP_group_price());
				System.out.println("공동:"+product.getP_sell_price());
				
				model.addAttribute("originPrice", originPrice);
			}	
			
			product.totalPrice();    // p_sell_price * cart_qty
			System.out.println("product:"+product);
			
			productInfo.add(product);
		}	
		
		// 주문자 정보 조회
		MemberDTO memberList = ms.select(m_email);
		System.out.println("memberList:"+memberList);
		
		// 기본 배송지 조회
		DeliveryDTO deliveryInfo = os.getDeliveryInfo(m_email);
		System.out.println("deliveryInfo:"+deliveryInfo);
		
		model.addAttribute("productInfo",productInfo);
		model.addAttribute("memberList", memberList);
		model.addAttribute("deliveryInfo", deliveryInfo);
		
		
		return "order/order";
	}
	
	// 배송지 등록 폼
	@RequestMapping("deliveryInsertForm.do")
	public String deliveryInsertForm() {
		return "order/deliveryInsertForm";	
	}
	
	
	// 배송지 등록
	@RequestMapping("deliveryInsert.do")
	public String deliveryInsert(HttpSession session,DeliveryDTO delivery, Model model, HttpServletRequest request) throws Exception {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		System.out.println("delivery:"+delivery);
		
		delivery.setM_email(m_email);
		
		// 배송지 등록이 처음인지 여부 확인
		int addressCount = os.getAddressCount(m_email);
		System.out.println("addressCount:"+addressCount);
				
		int result = 0;
				
		// 첫 등록하는 주소를 기본 배송지로 설정
		if(addressCount == 0) {
			result = os.deliveryInsertY(delivery);
			System.out.println("result:"+result);
		}else if(addressCount>=1) {
			result = os.deliveryInsertN(delivery);
			System.out.println("result:"+result);
		}
		
		model.addAttribute("result", result);
		
		return "order/deliveryInsertResult";
	}
	
	// 배송지 목록 팝업창
	@GetMapping("deliveryListPop.do")
	public String deliveryList(HttpSession session, Model model) throws Exception{
		System.out.println("deliveryListPop");
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		List<DeliveryDTO> deliveryList = os.getDeliveryList(m_email);
		System.out.println("deliveryList:"+deliveryList);
		
		if(!deliveryList.isEmpty()) {    // 저장된 주소가 있는 경우
			model.addAttribute("deliveryList", deliveryList); 
		}else {                          // 저장된 주소가 없는 경우
			model.addAttribute("listCheck", "empty");
		}
		return "order/deliveryListPop";
	}
	
	
	// 기본배송지 변경
	@RequestMapping("updateDefaultAddr.do")
	public String UpdateDefaultAddr(int d_no, HttpSession session, Model model) throws Exception{
		System.out.println("d_no:"+d_no);
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		// 기존에 있던 기본배송지의 d_default값을 N으로 변경
		int result1 = os.UpdateDefaultN(m_email);
		System.out.println("result1:"+result1);
		
		if(result1 == 1) {
			// 선택된 배송지의 d_default값을 Y로 변경
			int result2 = os.UpdateDefaultY(d_no);
			System.out.println("result2:"+result2);
		}
		
		return "order/updateDefaultResult";
	}
	
	// 배송지 수정 폼
	@RequestMapping("deliveryUpdateForm.do")
	public String deliveryUpdateForm(int d_no, Model model) {
		System.out.println("d_no:"+d_no);
		
		DeliveryDTO delivery = os.getDelivery(d_no);
		
		model.addAttribute("dl", delivery);
		
		return "order/deliveryUpdateForm";
	}
	
	// 배송지 수정
	@RequestMapping("deliveryUpdate.do")
	public String  deliveryUpdate(DeliveryDTO delivery) throws Exception{
		System.out.println("delivery:"+delivery);
		
		int result = os.addressUpdate(delivery);
		System.out.println("result:"+result);
		
		return "order/deliveryUpdateResult";
	}
	
	// 배송지 삭제
	@RequestMapping("deliveryDelete.do")
	public String deleteAddr( int d_no, Model model) throws Exception{
		System.out.println("d_no:"+d_no);
		
		int result = os.deleteAddr(d_no);
		System.out.println("result:"+result);
		
		model.addAttribute("result", result);
		
		return "order/deliveryDeleteResult";
	}

	// 주문 등록
	@RequestMapping("orderRequest.do")
	public String orderRequest(Order_tabDTO otd, HttpSession session, Model model) throws Exception{
		System.out.println("orderRequest");
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);

		otd.setM_email(m_email);
		System.out.println("otd:"+otd);
		
		
		// 주문 정보
		List<Order_productDTO> opds = new ArrayList<>();
		for(Order_productDTO opd : otd.getOrders()) {

			Order_productDTO orderProduct = os.getOrderInfo(opd.getP_no());

			orderProduct.setOp_qty(opd.getCart_qty());
			
			if(opd.getOp_type().equals("1")) {          // 일반 판매 상품
				orderProduct.setOp_price(orderProduct.getP_sell_price());
			}else if(opd.getOp_type().equals("2")) {    // 팔로우 특가 상품
				orderProduct.setOp_price(orderProduct.getP_follow_price());
			}else if(opd.getOp_type().equals("3")) {    // 공동구매 상품
				orderProduct.setOp_price(orderProduct.getP_group_price());
			}
			
			orderProduct.setOp_refund(orderProduct.getOp_price()*orderProduct.getOp_qty());
			orderProduct.setOp_calc(orderProduct.getOp_refund());
			orderProduct.setD_no(otd.getD_no());
			orderProduct.setM_email(otd.getM_email());
			orderProduct.setOp_type(opd.getOp_type());
			orderProduct.setGroup_op_no(opd.getGroup_op_no());
			orderProduct.setGroup_order(opd.getGroup_order());
			
			opds.add(orderProduct);
			
			System.out.println("p_no:"+orderProduct.getP_no());
			System.out.println("op_price:"+orderProduct.getOp_price());
			System.out.println("Op_qty:"+opd.getCart_qty());
			System.out.println("op_refund:"+orderProduct.getOp_refund());
			System.out.println("op_calc:"+orderProduct.getOp_calc());
			System.out.println("d_no:"+orderProduct.getD_no());
			System.out.println("M_email:"+orderProduct.getM_email());
			System.out.println("op_refund:"+orderProduct.getOp_refund());
			System.out.println("Op_type:"+orderProduct.getOp_type());
			System.out.println("group_op_no: "+opd.getGroup_op_no());
			System.out.println("group_order: "+ opd.getGroup_order());
		}		
		System.out.println("opds:"+opds);
		
		otd.setOrders(opds);
		otd.getOrderPriceInfo();
		
		System.out.println("d_msg:"+otd.getD_msg());
		System.out.println("o_pay_price:"+otd.getO_pay_price());
		System.out.println("o_pay_type:"+otd.getO_pay_type());
		System.out.println("orders:"+otd.getOrders());
		
		// 결제정보
		MemberDTO memberList = ms.select(m_email);
		DeliveryDTO deliveryInfo = os.getDeliveryInfo(m_email);
		
		// 주문,주문상품 테이블에 저장
		int result1 = os.orderInsert(otd);  // order_tab 등록
		System.out.println("order_tab입력 :"+result1);

		if(result1 == 1) {
			for(Order_productDTO opd : otd.getOrders()) {
										
				Order_tabDTO orderNo = os.getOrderNo(otd);
				System.out.println("orderNo:"+orderNo);
										
				opd.setO_no(orderNo.getO_no());			
				System.out.println("opd:"+opd);
							
				opd.setM_email(m_email);
				int result2 = 0;	
							
				if(opd.getOp_type().equals("3")) {
					result2 = os.orderGroupProductInsert(opd); // 공동구매 상품 order_product 등록
					int result = ps.updateGroupOrder(opd);
					System.out.println("공동구매 첫 번째 사람: "+result);
				}else {
					result2 = os.orderProductInsert(opd); // 일반 상품 / 팔로우 특가 상품 order_product 등록
				}
							
				System.out.println("order_product입력"+result2); 
							
				model.addAttribute("orderNo", orderNo.getO_no());
			}
		} 
		
		
		model.addAttribute("ml", memberList);
		model.addAttribute("di", deliveryInfo);
		model.addAttribute("otd", otd);
		model.addAttribute("opd", otd.getOrders());


		return "order/iamportPayment";
	}
	
	@RequestMapping("orderInsert.do")
	public String orderInsert(int o_no, Model model, HttpSession session) {
		System.out.println("결제 성공 orderInsert");
		System.out.println("o_no:"+o_no);
		
		String m_email = (String)session.getAttribute("m_email");
		int result=0, result1=0, result2=0;
				
		List<Order_productDTO> orderProduct = os.getPNo(o_no);	
		
				// 재고 변동 적용
				for(Order_productDTO opd : orderProduct) {
					// 변동 재고 값 구하기
					ProductDTO product = os.productInfo(opd.getP_no());
					System.out.println("변경 전 재고:"+product.getP_stock());
							
					product.setP_stock(product.getP_stock()-opd.getOp_qty());
					System.out.println("변경 후 재고:"+product.getP_stock());
							
					result1 = os.updateStock(product);
					System.out.println("재고 변동 :"+result1);
				}
								
				// 장바구니 제거
				for(Order_productDTO opd :orderProduct) {
					CartDTO cart = new CartDTO();
					cart.setM_email(m_email);
					cart.setP_no(opd.getP_no());
									
					result2 = cs.deleteOrderCart(cart);
					System.out.println("장바구니 제거"+result2);
				}			
		
		result = result1 + result2;
		
		model.addAttribute("result", result);
		return "order/orderInsertResult";
	}
	
	@RequestMapping("orderMail.do")
	public String orderMail(HttpSession session) throws Exception {
		System.out.println("orderMail");
		String m_email = (String)session.getAttribute("m_email");
		
		MemberDTO member = ms.select(m_email);
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "gcmarket99@gmail.com";
		String hostSMTPpwd = "rhkcoakzpt99"; // 비밀번호 입력해야함

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "gcmarket99@gmail.com";
		String fromName = "마켓관리자";
		String subject = member.getM_name()+"님 주문 내역을 알려드립니다.";

		// 받는 사람 E-Mail 주소
		String mail = m_email;
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
				email.setHtmlMsg("<p align = 'center'>안녕하세요. 신선한 농산물을 직거래하는 과채마켓입니다.</p><br>" + 
				"<div align='center'>주문하신 상품의 결제가 정상적으로 완료했습니다.<br>"
				+ "자세한 주문내역은 마이페이지>주문내역 을 확인해주시기 바랍니다.<br>"
				+ "저희 과채마켓을 이용해주셔서 진심으로 감사드립니다.</div>");
				email.send();
		} catch (Exception e) {
			System.out.println(e);
		}		
		
		return "redirect:orderList.do";
	}

	@RequestMapping("orderDelete.do")
	public String orderDelete(int o_no, Model model, HttpSession session) {
		System.out.println("결제 취소 orderDelete");
		System.out.println("o_no:"+o_no);
		
		int result1 = os.orderProductDelete(o_no);
		
		int result2 = os.orderDelete(o_no);
		System.out.println("result2:"+result2);
		
		model.addAttribute("result", result2);
		
		return "order/orderDeleteResult";
	}
}
