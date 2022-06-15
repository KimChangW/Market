package market.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import market.model.FollowDTO;
import market.service.FollowService;

@Controller 
public class FollowController {
	
	@Autowired
	private FollowService fs;
	
	// 팔로우 상점 등록
	@RequestMapping("followInsert.do") 
	public String followInsert(FollowDTO follow, HttpSession session, Model model) throws Exception {
		
		System.out.println("s_no:"+follow.getS_no());
		
		String m_email = (String)session.getAttribute("m_email");
        System.out.println("m_email:"+m_email);
        
        follow.setM_email(m_email);
        
	    // 팔로우 상점이 팔로우 상점목록에 존재하는지 여부 판별
		boolean isAlreadyExisted = fs.findFollowShop(follow);
		System.out.println("isAlreadyExisted:"+isAlreadyExisted);
		
		if(isAlreadyExisted) {
			System.out.println("existed");
			
			String result = "existed";
			model.addAttribute("result", result);
			
			return "follow/followInsertResult";
		}else {
			fs.insert(follow);
			System.out.println("success");
			
			String result = "success";
			model.addAttribute("result", result);
			
			return "follow/followInsertResult";
		}	
	}
	
	// 팔로우 상점 목록
	@RequestMapping("followList.do")
	public String followList(HttpSession session, FollowDTO follow, Model model) throws Exception {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		int total = fs.getTotal(m_email); // 검색 (데이터 갯수)
		System.out.println("total:"+total);
	
		List<FollowDTO> shopNo = fs.getShopNo(m_email);
		System.out.println("shopNo:"+shopNo);
		
		List followList = fs.list(m_email);
		System.out.println("followList:"+followList);
		
		model.addAttribute("total", total);
		model.addAttribute("shopNo", shopNo);
		model.addAttribute("followList", followList);
			
		return "follow/followList";
	}
	
	// 팔로우 상점 개별 삭제
	@RequestMapping("followDelete.do")
	public String followDelete(HttpSession session, int f_no, Model model) throws Exception {
		System.out.println("f_no:"+f_no);
		
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		fs.delete(f_no);
		System.out.println("삭제 완료");
		
		return "redirect:followList.do?m_email=m_email";
	}
	
	// 팔로우 상점 전체 삭제
	@RequestMapping("allFollowDelete.do")
	public String allFollowDelete(HttpSession session) {
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("m_email:"+m_email);
		
		fs.allDelete(m_email);
		System.out.println("전체 삭제 완료");
		
		return "redirect:followList.do?m_email=m_email";
 	}
}

