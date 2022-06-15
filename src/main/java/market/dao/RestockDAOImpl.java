package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.RestockDTO;

@Repository
public class RestockDAOImpl implements RestockDAO{
	@Autowired
	private SqlSessionTemplate sst;

	public boolean findRestockProduct(RestockDTO restock) {
		String result = sst.selectOne("restockns.findRestockProduct", restock);
		return Boolean.parseBoolean(result);
	}
	
	public void insert(RestockDTO restock) {
		sst.insert("restockns.insert", restock);
	}
	
	public int getTotal(String m_email) {
		return sst.selectOne("restockns.getTotal", m_email);
	}
	
	public List<RestockDTO> getShopNo(String m_email) {
		return sst.selectList("restockns.getShopNo", m_email);
	}
	
	public List<RestockDTO> list(String m_email) {
		return sst.selectList("restockns.list", m_email);
	}
	
	public void delete(int re_no) {
		sst.delete("restockns.delete", re_no);
	}
	
	public void allDelete(String m_email) {
		sst.delete("restockns.allDelete", m_email);
	}
}
