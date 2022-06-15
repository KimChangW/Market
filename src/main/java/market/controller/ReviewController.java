package market.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import market.model.Order_productDTO;
import market.model.ProductDTO;
import market.model.ReviewDTO;
import market.service.PagingPgm;
import market.service.ReviewServiceImpl;

@Controller
public class ReviewController {

	@Autowired
	private ReviewServiceImpl rs;
	
	// 리뷰 작성 폼
	@RequestMapping("reviewForm.do")
	public String reviewForm(Model model, @RequestParam("p_no") int p_no,
							 @RequestParam("o_no") int o_no,
							 HttpSession session) throws Exception{
		
		// session 에서 이메일 구해오기
		String m_email = (String)session.getAttribute("m_email");
		System.out.println("이메일: "+m_email);
		
		// 상품명 구해오기
		ProductDTO product = rs.getProductName(p_no);
		
		model.addAttribute("product", product);
		model.addAttribute("m_email", m_email);
		model.addAttribute("o_no", o_no);
		
		return "review/reviewForm";
	}
	
	// 리뷰 작성
	@RequestMapping(value = "reviewInsert.do", method = RequestMethod.POST)
	public String reviewInsert(Model model, ReviewDTO review) throws Exception{
		
		int result = 0;
		
		result = rs.insert(review);
		System.out.println("입력 결과:"+result);
		
		model.addAttribute("result", result);
		
		return "review/reviewResult";
	}
	
	// 내가 쓴 리뷰 목록 불러오기
	@RequestMapping("myReviewList.do")
	public String myReviewList(HttpSession session, Model model,
							   String pageNum, ReviewDTO review) throws Exception{
		
		String m_email = (String) session.getAttribute("m_email");
		
		// 페이징 처리
		final int rowPerPage = 10;		// 한 번에 출력할 데이터 개수
					
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
					
		int reviewCount = rs.reviewCount(m_email);
					
		System.out.println("내가 쓴 리뷰 개수: " + reviewCount);
					
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
					
		PagingPgm pp = new PagingPgm(reviewCount, rowPerPage, currentPage);
		review.setStartRow(startRow);
		review.setEndRow(endRow);
					
		int no = reviewCount - startRow + 1;		// 화면 출력 번호
					
		// 리뷰 목록
		List<ReviewDTO> reviewList = rs.myReviewList(m_email);
					
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		model.addAttribute("reviewCount",reviewCount);

		
		return "review/myReviewList";
	}
	
	// 리뷰 상세 
	@RequestMapping("reviewDetail.do")
	public String reviewDetail(@RequestParam("r_no") int r_no, 
							   @RequestParam("p_no") int p_no,
							   Model model, ReviewDTO review) throws Exception{
		
		// 조회수 증가
		int result = rs.updateHit(r_no);
		System.out.println("조회수 증가 결과: "+ result);
		
		// 상품명
		ProductDTO product = rs.getProductName(p_no);
		
		// 리뷰 내용 구해오기
		review = rs.select(r_no);
		System.out.println("리뷰 상세 내용: "+review);
		
		String content = review.getR_content().replace("\n","<br>");
		
		model.addAttribute("review", review);
		model.addAttribute("content", content);
		model.addAttribute("product", product);

		if(review.getR_img() != null) {
		
			String imgs = review.getR_img();		
			String[] img = imgs.split("/");
			model.addAttribute("img", img);
		}
		
				
		return "review/reviewDetail";
	}
	
	// 리뷰 삭제
	@RequestMapping("reviewDelete.do")
	public String reviewDelete(Model model, @RequestParam("r_no") int r_no) throws Exception{
		
		// r_delstatus 값 Y로 업데이트
		int result = rs.delete(r_no);
		System.out.println("리뷰 삭제 결과: "+ result);
		
		model.addAttribute("result", result);
		
		return "review/reviewDeleteResult";
	}
	
	// 리뷰 존재 여부 확인 (ajax)
		@RequestMapping(value = "reviewCheck.do", method = RequestMethod.POST)
		public String reviewCheck(Model model, @RequestParam("p_no") int p_no,
								  @RequestParam("o_no") int o_no, HttpSession session, ReviewDTO review) throws Exception{
			
			String m_email = (String) session.getAttribute("m_email");
			
			System.out.println("p_no: "+p_no);
			System.out.println("o_no: "+o_no);
			System.out.println("m_email: "+m_email);
			
			review.setM_email(m_email);
			review.setP_no(p_no);
			review.setO_no(o_no);
			
			int result = 0;
			result = rs.reviewCheck(review);
			
			System.out.println("result:"+result);
			
			model.addAttribute("result", result);
			
			return "review/reviewCheckResult";
		}
		
	// 상품 상세 페이지에 불러올 리뷰 목록
		@RequestMapping("productReviewList.do")
		public String productReviewList(Model model, String pageNum,
										@RequestParam("p_no") int p_no,
										ReviewDTO review) throws Exception{
			// 페이징 처리
			final int rowPerPage = 10;		// 한 번에 출력할 데이터 개수
			
			if(pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			
			int total = rs.getTotal(p_no);		// 해당 상품에 대한 리뷰 개수
			
			System.out.println("total: "+total);
			
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			
			PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
			review.setStartRow(startRow);
			review.setEndRow(endRow);
			
			int no = total - startRow + 1;		// 화면 출력 번호
			
			List<ReviewDTO> list = rs.reviewList(p_no);
			
			System.out.println("상품 리뷰 목록:" + list);
			
			model.addAttribute("list", list);
			model.addAttribute("no", no);
			model.addAttribute("pp", pp);
			
			return "review/productReviewList";
		}
}
