package market.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.ShopDTO;

@Repository
public class ShopDAOImpl {
	@Autowired
	private SqlSession sqlsession;

	// 회원가입
	public int insertShop_join(ShopDTO shop) throws Exception {
		return sqlsession.insert("shopns.shop_insert", shop);
	}

	// 로그인 인증
	public ShopDTO userCheck(String s_email) throws Exception {
		return sqlsession.selectOne("shopns.shop_select", s_email);
		
//		List list  = sqlsession.selectList("shopns.shop_select", s_email);
//		System.out.println(list.get(1));
//		return (ShopDTO)list.get(0);
	}

	// email 중복검사
	public int shop_emailcheck(String s_email) throws Exception {

		int re = -1; // 사용 가능한 ID

		ShopDTO s = sqlsession.selectOne("shopns.shop_select", s_email);
		if (s != null)
			re = 1; // 중복id

		return re;

	}

	// 상점 정보 수정
	public int shop_info_edit(ShopDTO shop) throws Exception {
		return sqlsession.update("shopns.shop_update", shop);
	}

	// 폐점으로 바꾸기
	public void shop_del(ShopDTO dels) throws Exception {
		sqlsession.update("shopns.shop_del", dels);
	}

	// 관리자 shoplist 입점 신청 내역
	public List<ShopDTO> shoplist() throws Exception {
		return sqlsession.selectList("shopns.shoplist");
	}

	// 관리자 shoplist 회원 내역
	public List<ShopDTO> shoplist1() throws Exception {
		return sqlsession.selectList("shopns.shoplist1");
	}

	// 입점 신청 총 데이터 개수 구하기
	public int getTotal(ShopDTO shop) throws Exception {
		return sqlsession.selectOne("shopns.shoptotal", shop);
	}

	// 회원 총 데이터 개수 구하기
	public int getTotal2(ShopDTO shop) throws Exception {
		return sqlsession.selectOne("shopns.shoptotal2", shop);
	}

	// 체크박스로 입점승인
	public int shopList_check(String email) throws Exception {
		return sqlsession.update("shopns.shopupdate", email);
	}

	// 체크박스로 강제폐점
	public int shopList_del(String email) throws Exception {
		return sqlsession.update("shopns.shopdel", email);
	}

	// 비밀번호 찾기
	public ShopDTO shop_passwd(String s_email) throws Exception {

		return sqlsession.selectOne("shopns.shop_select", s_email);
	}

	// 임시비밀번호로 수정
	public int shop_passwdUpdate(ShopDTO shop) throws Exception {
		return sqlsession.update("shopns.shop_passwdUp", shop);
	}

	// 비밀번호 수정
	public int shop_info_changepw(ShopDTO shop) throws Exception {
		return sqlsession.update("shopns.shop_passwdedit", shop);
	}

	// email 찾기
	public ShopDTO shop_emailsearch(ShopDTO shop) throws Exception {
		return sqlsession.selectOne("shopns.shop_emailsearch", shop);
	}

	// 관리자 list view구해오기
	public ShopDTO shopListView(String s_email) throws Exception {
		return sqlsession.selectOne("shopns.shop_select1",s_email);
	}

}
