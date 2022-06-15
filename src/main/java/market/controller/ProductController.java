package market.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import market.model.CategoryDTO;
import market.model.FollowDTO;
import market.model.Order_productDTO;
import market.model.ProductDTO;
import market.model.Product_imgDTO;
import market.model.ShopDTO;
import market.service.PagingPgm;
import market.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	private ProductService ps;

	@RequestMapping("main.do")	// 글작성 폼 (원문, 답변글)
	public String main(String pageNum, ProductDTO product, Model model) {
		//공동구매특가
		String search = "p_group_buying";
		String keyword = "Y";
		String orderCond = "p_regdate_DESC";
		
		product.setSearch(search);
		product.setKeyword(keyword);
		product.setOrderCond(orderCond);
		product.setStartRow(1);
		product.setEndRow(5);
		
		List<ProductDTO> glist = ps.listMain(product);
		System.out.println("glist:"+glist);

		//follow특가
		search = "p_follow_sale"; 	//나머지 옵션은 공동구매와 동일
		orderCond = "p_hit_DESC";
		
		product.setSearch(search);
		product.setKeyword(keyword);
		product.setOrderCond(orderCond);

		List<ProductDTO> flist = ps.listMain(product);		
		System.out.println("flist:"+flist);
		
		//공유
		model.addAttribute("glist", glist);
		model.addAttribute("flist", flist);
		model.addAttribute("search", product.getSearch());
		model.addAttribute("keyword", product.getKeyword());		
		
		return "common/main";
	}
	
	@RequestMapping("productInsertForm.do")	// 글작성 폼 (원문, 답변글)
	public String productInsertForm(Model model) {

		List<CategoryDTO> listCateNo = ps.listCateNo();
		model.addAttribute("listCateNo", listCateNo);
		return "product/productInsertForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "productInsert.do", method = RequestMethod.POST)	// 상품입력
	public String insert(ProductDTO product, Product_imgDTO product_img, Model model, 
						@RequestParam("article_file") List<MultipartFile> fileList,
						HttpServletRequest request) {

		System.out.println("productInsert");
		String strResult = "{ \"result\":\"FAIL\" }";
		
		// 상품정보 등록
		int result = ps.insert(product);
		System.out.println("s_no:"+product.getS_no());
		System.out.println("cate_no:"+product.getCate_no());
		System.out.println("p_detail:"+product.getP_detail());
		System.out.println("상품 저장성공");
		
		// 등록한 상품번호를 구해옴
		int number = ps.getMaxNum();
		System.out.println("number:"+number);
		
		try {
			// 등록한 이미지가 있으면
			if(fileList.size() > 0 && !fileList.get(0).getOriginalFilename().equals("")) {

				// 이미지DTO에 상품번호 등록
				product_img.setP_no(number);
				// product_img_order에 들어갈 기본값
				int i=1;
				
				// 저장경로 설정
				String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
				String path = contextRoot + "upload/product";
				System.out.println("path:"+path);
				
		       for (MultipartFile mf : fileList) {
		    	   
					int size = (int) mf.getSize(); // 첨부파일의 크기 (단위: Byte)
					String originalFileName = mf.getOriginalFilename();	//오리지날 파일명
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
		            	//폴더에 파일저장
		            	mf.transferTo(new File(path + "/" + savedFileName));
		                System.out.println("폴더저장성공");
		            } catch (IOException e) {
		                // TODO Auto-generated catch block
		                e.printStackTrace();
		            }
		            // product_imgDTO에 저장
		        	product_img.setP_img(savedFileName);
		        	product_img.setP_img_order(i++);
		        	// DB저장
		    		ps.insertImg(product_img);
		    		System.out.println("DB저장성공");
		       	}
		       	strResult = "{ \"result\":\"OK\" }";
	        } else 
				strResult = "{ \"result\":\"OK\" }";  // 파일첨부 안하고 상품만 등록하는경우
		}catch(Exception e){
			e.printStackTrace();
		}
		return strResult;
	}
	
	@RequestMapping("productView.do")	// 상세 페이지
	public String productView(int p_no, Product_imgDTO product_img, String pageNum, Model model, HttpSession session, ProductDTO pdto) {
		
		ps.selectUpdate(p_no);	// 조회수 증가
		ProductDTO product = ps.select(p_no);
		List<Product_imgDTO> listImg = ps.listImg(p_no);
		
		List<FollowDTO> followShop = ps.getFollowShopNo(product.getS_no());
		System.out.println("followShop:"+followShop);
		
		// 공동구매 팀 정보 구해오기
		pdto.setP_no(p_no);	
		System.out.println("p_no: "+p_no);
						
		List<Order_productDTO> group = ps.getGroup(pdto);
		
		System.out.println("product:"+product);
		System.out.println("product_img:"+product);
		
		model.addAttribute("product", product);
		model.addAttribute("listImg", listImg);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("followShop", followShop);
		model.addAttribute("group", group);
		
		return "product/productView";
	}
	
	@RequestMapping("productUpdateForm.do")  // 수정 폼
	public String productUpdateForm(int p_no, String pageNum, Model model) {

		List<CategoryDTO> listCateNo = ps.listCateNo();
		ProductDTO product = ps.select(p_no);
		System.out.println("listCateNo:"+listCateNo);
		System.out.println("product:"+product);
		model.addAttribute("listCateNo", listCateNo);
		model.addAttribute("product", product);
		model.addAttribute("pageNum", pageNum);
		
		return "product/productUpdateForm";
	}
	
	@RequestMapping("productUpdate.do")
	public String productUpdate(ProductDTO product, String pageNum, Model model) {
		
		int result = ps.update(product);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "product/productUpdate";
	}
	
	@RequestMapping("productList.do")	// 전체 목록, 검색 목록
	public String producList(HttpSession session, HttpServletRequest request,String pageNum, ProductDTO product, Model model) {

		session = request.getSession();

		int s_no = (int) session.getAttribute("s_no");
		System.out.println("s_no:"+s_no);
		
		product.setS_no(s_no);
		
		final int rowPerPage = 10;	// 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		
		int total = ps.getTotal(product); // 검색 (데이터 갯수)
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		String status = product.getStatus();
		if (status == null || status.equals("")) {
			status = "1";
		}

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		product.setStartRow(startRow);
		product.setEndRow(endRow);
		int no = total - startRow + 1;		// 화면 출력 번호
		List<ProductDTO> list = ps.list(product);
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		
		// 검색
		model.addAttribute("search", product.getSearch());
		model.addAttribute("keyword", product.getKeyword());
		model.addAttribute("orderCond", product.getOrderCond());
		model.addAttribute("status", status);
		
		return "product/productList";
	}
	
	@RequestMapping("productSearchList.do")	// 전체 목록, 검색 목록
	public String productSearchList(HttpSession session, HttpServletRequest request,String pageNum, ProductDTO product, Model model) {
		
		final int rowPerPage = 10;	// 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		
		int total = ps.getTotalMain(product); // 검색 (데이터 갯수)
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		product.setStartRow(startRow);
		product.setEndRow(endRow);

		List<ProductDTO> list = ps.listMain(product);

		System.out.println(product.getSearch());
		System.out.println(product.getKeyword());
		
		if (product.getSearch().equals("s_name")) {
			
			ShopDTO s = ps.getShopInfo(product);
			System.out.println("shop_info:"+s);
			
			//팔로잉을 위한 상점번호
			model.addAttribute("s", s);
		}
		//상품목록
		model.addAttribute("list", list);
		//페이징
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", product.getSearch());
		model.addAttribute("keyword", product.getKeyword());
		//정렬
		model.addAttribute("orderCond", product.getOrderCond());
		
		return "product/productSearchList";
	}
	
	@RequestMapping("productCategoryList.do")	// 전체 목록, 검색 목록
	public String producCategoryList(HttpSession session, HttpServletRequest request,String pageNum, ProductDTO product, Model model) {
		
		/*
		 * 익스플로어에서 카테고리 적용안되는 건 아래방식으로 해결 가능하긴 한데...
		 * if (product.getKeyword().equals("cate1")){product.setKeyword("과일");}
		 */
		final int rowPerPage = 10;	// 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		
		int total = ps.getTotalMain(product); // 검색 (데이터 갯수)
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		product.setStartRow(startRow);
		product.setEndRow(endRow);

		List<ProductDTO> list = ps.listMain(product);
		List<CategoryDTO> listCategory = ps.listCategory(product);
		
		//카테고리목록
		model.addAttribute("listCategory", listCategory);
		//상품목록
		model.addAttribute("list", list);
		//페이징
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", product.getSearch());
		model.addAttribute("keyword", product.getKeyword());
		//정렬
		model.addAttribute("orderCond", product.getOrderCond());
		
		return "product/productCategoryList";
	}


	@RequestMapping("productDelete.do")
	public String productDelete(int p_no, String pageNum, Model model) {
		
		int result = ps.delete(p_no);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "product/productDelete";
	}
	
	@RequestMapping("productStop.do")
	public String productStop(int p_no, String pageNum, Model model) {
		
		int result = ps.stop(p_no);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		
		return "product/productStop";
	}
	
	@RequestMapping("productManagerList.do")	// 전체 목록, 검색 목록
	public String productManagerList(String pageNum, ProductDTO product, Model model) {
		final int rowPerPage = 10;	// 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		
		int total = ps.mgetTotal(product); // 검색 (데이터 갯수)
		
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		String status = product.getStatus();
		if (status == null || status.equals("")) {
			status = "1";
		}
		
		int s_no = product.getS_no();
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		product.setStartRow(startRow);
		product.setEndRow(endRow);
		int no = total - startRow + 1;		// 화면 출력 번호
		
		List<ProductDTO> getShopNo = ps.getShopNo();
		model.addAttribute("getShopNo", getShopNo);
		List<ProductDTO> mlist = ps.mlist(product);
		
		model.addAttribute("mlist", mlist);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		
		// 검색
		model.addAttribute("search", product.getSearch());
		model.addAttribute("keyword", product.getKeyword());
		model.addAttribute("orderCond", product.getOrderCond());
		model.addAttribute("status", status);
		model.addAttribute("s_no", s_no);
		
		return "product/productManagerList";
	}
}
