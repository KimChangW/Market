package market.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import market.model.Board;
import market.model.ProductDTO;
import market.model.Product_imgDTO;
import market.service.BoardService;
import market.service.PagingPgm;
import market.service.ProductService;

@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	
	@RequestMapping("list.do")	// 전체 목록, 검색 목록
	public String list(String pageNum, Board board, Model model) {
		final int rowPerPage = 10;	// 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		
		// int total = bs.getTotal();
		int total = bs.getTotal(board); // 검색 (데이터 갯수)
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;		// 화면 출력 번호
		List<Board> list = bs.list(board);
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", board.getSearch());
		model.addAttribute("keyword", board.getKeyword());
		
		return "board/list";
	}

	@RequestMapping("insertForm.do")	// 글작성 폼 (원문, 답변글)
	public String insertForm(String nm, String pageNum, Model model) {
		int num = 0, ref = 0, re_level = 0, re_step = 0; // 원문
		if (nm != null) {	// 답변글
			num = Integer.parseInt(nm);
			Board board = bs.select(num);	// 부모글 정보 구해오기
			ref = board.getRef();
			re_level = board.getRe_level();
			re_step = board.getRe_step();
		}
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("re_step", re_step);
		model.addAttribute("pageNum", pageNum);
		
		return "board/insertForm";
	}

	@RequestMapping("insert.do")	// 글 작성
	public String insert(Board board, Model model, HttpServletRequest request) {
		int num = board.getNum();
		int number = bs.getMaxNum();
		if (num != 0) {		// 답변글
			bs.updateRe(board);
			board.setRe_level(board.getRe_level() + 1);
			board.setRe_step(board.getRe_step() + 1);
		} else				
			board.setRef(number); //원문
		// 원문 + 답글
			board.setNum(number);
			String ip = request.getRemoteAddr();
			board.setIp(ip);
			int result = bs.insert(board);
			model.addAttribute("result", result);
			
		return "board/insert";
	}

	@ResponseBody
	@RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
	public String fileUpload(Board board,
			@RequestParam("article_file") List<MultipartFile> multipartFile
			, HttpServletRequest request, Model model) {
		
		System.out.println("fileUpload");
		System.out.println("subject:"+board.getSubject());
		System.out.println("writer:"+board.getWriter());
		System.out.println("email:"+board.getEmail());
		System.out.println("passwd:"+board.getPasswd());
		System.out.println("content:"+board.getContent());
		String strResult = "{ \"result\":\"FAIL\" }";

		try {
			// 파일이 있을때 탄다.
			if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {

				String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
				String path = contextRoot + "upload/product";
				System.out.println("path:"+path);

				for(MultipartFile file:multipartFile) {
					int size = (int) file.getSize(); // 첨부파일의 크기 (단위: Byte)
					String originalFileName = file.getOriginalFilename();	//오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
					String savedFileName = UUID.randomUUID() +"_" + originalFileName;	//저장될 파일 명
					
					System.out.println("size:"+size);
					System.out.println("originalFileName:"+originalFileName);
					System.out.println("extension:"+extension);
					System.out.println("savedFileName:"+savedFileName);
					
					if(size > 10240000) { // 10MB
						strResult = "{ \"result\":\"BIGfile\" }";
						return strResult;
					}
					
					try {
						
						//서버에 파일이 저장되는 부분
						file.transferTo(new File(path + "/" + savedFileName));
						

					} catch (Exception e) {
						// TODO: handle exception
					}

					//DB에 파일명을 저장하는 부분
					
				}
				strResult = "{ \"result\":\"OK\" }";
			}
			// 파일 아무것도 첨부 안했을때 탄다.(게시판일때, 업로드 없이 글을 등록하는경우)
			else
				strResult = "{ \"result\":\"OK\" }";
		}catch(Exception e){
			e.printStackTrace();
		}
		return strResult;
	}
	@RequestMapping("view.do")	// 상세 페이지
	public String view(int num, String pageNum, Model model) {
		bs.selectUpdate(num);	// 조회수 증가
		Board board = bs.select(num);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		
		return "board/view";
	}

	@RequestMapping("updateForm.do")	// 수정 폼
	public String updateForm(int num, String pageNum, Model model) {
		Board board = bs.select(num);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		
		return "board/updateForm";
	}

	@RequestMapping("update.do")	// 수정
	public String update(Board board, String pageNum, Model model) {
		int result = bs.update(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "board/update";
	}

	@RequestMapping("deleteForm.do")
	public String deleteForm(int num, String pageNum, Model model) {
		Board board = bs.select(num);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		
		return "board/deleteForm";
	}

	@RequestMapping("delete.do")
	public String delete(int num, String pageNum, Model model) {
		int result = bs.delete(num);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "board/delete";
	}
}