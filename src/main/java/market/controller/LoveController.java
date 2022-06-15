package market.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import market.model.LoveDTO;
import market.service.LoveService;

@Controller
public class LoveController {
	
	@Autowired
	private LoveService ls;
	
	// 관심상품 등록
	@RequestMapping("loveInsert.do")
	public String loveInsert(LoveDTO love, HttpSession session, Model model) throws Exception {
		System.out.println("p_no:"+love.getP_no());
		
		
        String m_email = (String)session.getAttribute("m_email");
        System.out.println("m_email:"+m_email);
        
        love.setM_email(m_email);
		
		// 해당 상품이 관심상품에 존재하는지 여부 판별
		boolean isAlreadyExisted = ls.findLoveProduct(love);
		System.out.println("isAlreadyExisted:"+isAlreadyExisted);
		
		if(isAlreadyExisted) {
			System.out.println("existed");
			
			String result = "existed";
			model.addAttribute("result", result);
			
			return "love/loveInsertResult";
		}else {
			ls.insert(love);
			System.out.println("success");
			
			String result = "success";
			model.addAttribute("result", result);
			
			return "love/loveInsertResult";
		}	
	}
	
	// 관심상품 목록
	@RequestMapping("loveList.do")
	public String loveList(HttpSession session, LoveDTO love, Model model) throws Exception {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		int total = ls.getTotal(m_email); // 검색 (데이터 갯수)
		System.out.println("total:"+total);

		List<LoveDTO> shopNo = ls.getShopNo(m_email);
		System.out.println("shopNo:"+shopNo);
		
		List loveList = ls.list(m_email);
		System.out.println("loveList:"+loveList);
		
		model.addAttribute("total", total);
		model.addAttribute("shopNo", shopNo);
		model.addAttribute("loveList", loveList);
			
		return "love/loveList";
	}
	
	// 관심상품 개별 삭제
	@RequestMapping("loveDelete.do")
	public String loveDelete(HttpSession session, int love_no, Model model) throws Exception {
		System.out.println("love_no:"+love_no);
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		ls.delete(love_no);
		System.out.println("삭제 완료");
		
		return "redirect:loveList.do?m_email=m_email";
	}
	
	// 관심상품 전체 삭제
	@RequestMapping("allLoveDelete.do")
	public String allLoveDelete(HttpSession session) {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		ls.allDelete(m_email);
		System.out.println("전체 삭제 완료");
		
		return "redirect:loveList.do?m_email=m_email";
	}
}
