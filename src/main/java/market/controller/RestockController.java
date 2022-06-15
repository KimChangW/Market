package market.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import market.model.RestockDTO;
import market.service.RestockService;

@Controller 
public class RestockController {
  
	@Autowired 
	private RestockService rs;
 
	// 재입고신청 등록
	@RequestMapping("restockInsert.do") 
	public String restockInsert(RestockDTO restock, HttpSession session, Model model) throws Exception {
		
		System.out.println("p_no:"+restock.getP_no());
		
		String m_email = (String)session.getAttribute("m_email");
        System.out.println("m_email:"+m_email);
        
        restock.setM_email(m_email);
        
	    // 해당 상품이 재입고신청목록에 존재하는지 여부 판별
		boolean isAlreadyExisted = rs.findRestockProduct(restock);
		System.out.println("isAlreadyExisted:"+isAlreadyExisted);
		
		if(isAlreadyExisted) {
			System.out.println("existed");
			
			String result = "existed";
			model.addAttribute("result", result);
			
			return "restock/restockInsertResult";
		}else {
			rs.insert(restock);
			System.out.println("success");
			
			String result = "success";
			model.addAttribute("result", result);
			
			return "restock/restockInsertResult";
		}	
	}
	
	// 재입고신청 목록
	@RequestMapping("restockList.do")
	public String restockList(HttpSession session, RestockDTO restock, Model model) throws Exception {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		int total = rs.getTotal(m_email); // 검색 (데이터 갯수)
		System.out.println("total:"+total);
	
		List<RestockDTO> shopNo = rs.getShopNo(m_email);
		System.out.println("shopNo:"+shopNo);
		
		List restockList = rs.list(m_email);
		System.out.println("restockList:"+restockList);
		
		model.addAttribute("total", total);
		model.addAttribute("shopNo", shopNo);
		model.addAttribute("restockList", restockList);
			
		return "restock/restockList";
	}
	
	// 재입고신청상품 개별 삭제
	@RequestMapping("restockDelete.do")
	public String restockDelete(HttpSession session, int re_no, Model model) throws Exception {
		System.out.println("re_no:"+re_no);
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		rs.delete(re_no);
		System.out.println("삭제 완료");
		
		return "redirect:restockList.do?m_email=m_email";
	}
	
	// 관심상품 전체 삭제
	@RequestMapping("allRestockDelete.do")
	public String allRestockDelete(HttpSession session) {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		rs.allDelete(m_email);
		System.out.println("전체 삭제 완료");
		
		return "redirect:restockList.do?m_email=m_email";
 	}
}
