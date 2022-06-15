package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.FollowDTO;

@Repository
public class FollowDAOImpl implements FollowDAO {
	@Autowired
	private SqlSessionTemplate sst;

	public boolean findFollowShop(FollowDTO follow) {
		String result = sst.selectOne("followns.findFollowShop", follow);
		return Boolean.parseBoolean(result);
	}
	
	public void insert(FollowDTO follow) {
		sst.insert("followns.insert", follow);
	}
	
	public int getTotal(String m_email) {
		return sst.selectOne("followns.getTotal", m_email);
	}
	
	public List<FollowDTO> getShopNo(String m_email) {
		return sst.selectList("followns.getShopNo", m_email);
	}
	
	public List<FollowDTO> list(String m_email) {
		return sst.selectList("followns.list", m_email);
	}
	
	public void delete(int f_no) {
		sst.delete("followns.delete", f_no);
	}
	
	public void allDelete(String m_email) {
		sst.delete("followns.allDelete", m_email);
	}
}
