package market.controller;


import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import market.model.CartDTO;
import market.service.CartService;

@Controller
public class CartController {

	@Autowired
	private CartService cs;
	
	// 장바구니에 상품 등록
	@RequestMapping("cartInsert.do")
	public String cartInsert(CartDTO cart, HttpSession session, Model model) throws Exception {
		System.out.println("p_no:"+cart.getP_no());
		System.out.println("cart_qty:"+cart.getCart_qty());
		System.out.println("op_type:"+cart.getOp_type());
		
        String m_email = (String)session.getAttribute("m_email");
        System.out.println("m_email:"+m_email);
        
        cart.setM_email(m_email);
		
		// 해당 상품이 장바구니에 존재하는지 여부 판별
		boolean isAlreadyExisted = cs.findCartProduct(cart);
		System.out.println("isAlreadyExisted:"+isAlreadyExisted);
		
		if(isAlreadyExisted) {   // 동일한 상품이 이미 있는 경우
			System.out.println("existed");
			
			String result = "existed";
			model.addAttribute("result", result);
			
			return "cart/cartInsertResult";
		}else {                  // 동일한 상품이 없는 경우
			cs.insert(cart);
			System.out.println("success");
			
			String result = "success";
			model.addAttribute("result", result);
			
			return "cart/cartInsertResult";
		}
		
		
	}
	
	// 장바구니 목록
	@RequestMapping("cartList.do")
	public String cartList(String op_type ,HttpSession session, Model model) throws Exception {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		System.out.println("op_type:"+op_type);
		
		// 장바구니에 있는 상품들의 상점번호 조회
		List<CartDTO> shopNo = cs.getShopNo(m_email);
		System.out.println("shopNo:"+shopNo);
		
		// 장바구니 상품 목록
		List cartList = cs.list(m_email);
		System.out.println("cartList:"+cartList);
		
		// 팔로우한 상점 목록
		List followList = cs.getFollowList(m_email);
		System.out.println("followList:"+followList);
		
		model.addAttribute("shopNo", shopNo);
		model.addAttribute("cartList", cartList);
		model.addAttribute("op_type", op_type);
		model.addAttribute("followList", followList);
			
		return "cart/cartList";
	}
	
	// 장바구니 상품 수량 수정
	@RequestMapping("cartQtyUpdate.do")
	public String cartQtyUpdate(HttpSession session, CartDTO cart, Model model) throws Exception {
		System.out.println("cart_no:"+cart.getCart_no());
		System.out.println("cart_qty:"+cart.getCart_qty());

		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		cs.update(cart);
		
		return "redirect:cartList.do?m_email=m_email";
	}
	
	// 장바구니 개별상품 삭제
	@RequestMapping("cartDelete.do")
	public String cartDelete(HttpSession session, int cart_no, Model model) throws Exception {
		System.out.println("cart_no:"+cart_no);
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		cs.delete(cart_no);
		System.out.println("삭제 완료");
		
		return "redirect:cartList.do?m_email=m_email";
	}
	
	// 장바구니 전체 삭제
	@RequestMapping("allCartDelete.do")
	public String allCartDelete(HttpSession session) {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		cs.allDelete(m_email);
		System.out.println("전체 삭제 완료");
		
		return "redirect:cartList.do?m_email=m_email";
	}
	
}
