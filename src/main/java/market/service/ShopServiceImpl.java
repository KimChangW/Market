package market.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.ShopDAO;
import market.dao.ShopDAOImpl;
import market.model.ShopDTO;

@Service
public class ShopServiceImpl {
	@Autowired
	private ShopDAOImpl shopDAO;
	// 회원가입
	public int insertShop_join(ShopDTO shop)throws Exception {
		return shopDAO.insertShop_join(shop);
	}
	// 로그인 인증
	public ShopDTO userCheck(String s_email)throws Exception {
		return shopDAO.userCheck(s_email);
	}
	// email중복 검사
	public int shop_emailcheck(String s_email)throws Exception {
		return shopDAO.shop_emailcheck(s_email);
	}
	
	// 상점 정보 수정
	public int shop_info_edit(ShopDTO shop)throws Exception {
		return shopDAO.shop_info_edit(shop);
	}
	
	// 폐점으로 바꾸기
	public void shop_del(ShopDTO dels)throws Exception {
		shopDAO.shop_del(dels);
	}
	
	//관리자 shoplist 입점 신청 내역
	public List<ShopDTO> shoplist()throws Exception{
		return shopDAO.shoplist();
	}
	//관리자 shoplist 회원 내역
	public List<ShopDTO> shoplist1()throws Exception{
		return shopDAO.shoplist1();
	}
	
	//입점 신청 총 데이터 개수 구하기
	public int getTotal(ShopDTO shop)throws Exception{
		return shopDAO.getTotal(shop);
	}
	//회원 총 데이터 개수 구하기
	public int getTotal2(ShopDTO shop)throws Exception{
		return shopDAO.getTotal2(shop);
	}
	
	//체크박스로 입점승인
	public int shopList_check(String email)throws Exception{
		return shopDAO.shopList_check(email);
	}
	//체크박스로 강제폐점
	public int shopList_del(String email)throws Exception{
		return shopDAO.shopList_del(email);
	}
	//비밀번호 찾기
	public ShopDTO shop_passwd(String s_email)throws Exception{
		
		return shopDAO.shop_passwd(s_email);
	}
	//임시비밀번호로 수정
	public int shop_passwdUpdate(ShopDTO shop)throws Exception{
		return shopDAO.shop_passwdUpdate(shop);
	}
	// 비밀번호 수정
	public int shop_info_changepw(ShopDTO shop)throws Exception{
		return shopDAO.shop_info_changepw(shop);
	}
	//email 찾기
	public ShopDTO shop_emailsearch(ShopDTO shop)throws Exception{
		return shopDAO.shop_emailsearch(shop);
	}
	// 관리자 list view구해오기
	public ShopDTO shopListView(String s_email)throws Exception{
		return shopDAO.shopListView(s_email);
	}
}