package market.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import market.model.Order_productDTO;
import market.model.ReviewDTO;
import market.service.Order_productServiceImpl;
import market.service.PagingPgm;
import market.service.ReviewServiceImpl;


@Controller
public class Order_productController {

	@Autowired
	private Order_productServiceImpl ops;
	
	@Autowired
	private ReviewServiceImpl rs;

	// 주문 목록 불러오기
	@RequestMapping("orderList.do")
	public String orderList(Model model, HttpSession session, 
							String pageNum, Order_productDTO opdto) throws Exception {
		
		// 세션 값 가져오기
		String m_email = (String)session.getAttribute("m_email");
		opdto.setM_email(m_email);
		
		// 페이징 처리
		final int rowPerPage = 5;		// 한 번에 출력할 데이터 개수
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		int total = ops.getTotal(m_email);		// 주문 상품 개수
		
		System.out.println("total: "+total);
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		opdto.setStartRow(startRow);
		opdto.setEndRow(endRow);
		
		int no = total - startRow + 1;		// 화면 출력 번호
		List<Order_productDTO> orderList = ops.orderList(opdto);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		
		return "my_page/orderList";
	}
	
	// 주문 상세 내용 불러오기
	@RequestMapping("orderDetail.do")
	public String orderDetail(Model model, @RequestParam("op_no") int op_no, 
							  @RequestParam("o_no") int o_no, Order_productDTO detail) throws Exception{
		
		detail = ops.orderDetail(op_no);
		List<Order_productDTO> detailList = ops.detailList(o_no);
		System.out.println("detailList: "+ detailList);
		
		model.addAttribute("detail", detail);
		model.addAttribute("detailList", detailList);
				
		return "my_page/orderDetail";
	}
	
	// 주문취소
	@RequestMapping("cancel.do")
	public String cancel(Model model, @RequestParam("op_no") int op_no) throws Exception{
		int result = ops.cancel(op_no);
		System.out.println("주문취소 :" + result);
		model.addAttribute("result", result);
		
		return "my_page/cancelResult";
	}
	
	// 환불 요청 작성 폼
	@RequestMapping("refund.do")
	public String refund(Model model, @RequestParam("op_no") int op_no) throws Exception{
		model.addAttribute("op_no", op_no);
		
		return "my_page/refundForm";
	}
	
	// 환불 요청 접수
	@RequestMapping("refundForm.do")
	public String refundForm(Model model, Order_productDTO opdto, @RequestParam("op_no") int op_no, 
							@RequestParam("op_refund_why") String op_refund_why) throws Exception{
		
		opdto.setOp_no(op_no);
		opdto.setOp_refund_why(op_refund_why);
		
		int result = ops.refundForm(opdto);
		System.out.println("환불요청 결과: "+result);
		
		model.addAttribute("result", result);
		
		return "my_page/refundResult";
	}
	
	// 구매확정
	@RequestMapping("confirm.do")
	public String confirm(Model model, @RequestParam("op_no") int op_no,
						  @RequestParam("s_no") int s_no, Order_productDTO opdto) throws Exception{
		
		int result = ops.confirm(op_no);
		System.out.println("구매확정 결과: "+result);
		
		opdto.setOp_no(op_no);
		opdto.setS_no(s_no);
		
		Order_productDTO shopInfo = ops.shopInfo(opdto);
		System.out.println("shopInfo" + shopInfo);
		
		model.addAttribute("result", result);
		model.addAttribute("shopInfo", shopInfo);
		
		return "my_page/confirmResult";
	}
	
}
