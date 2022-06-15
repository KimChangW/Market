package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.LoveDTO;

@Repository
public class LoveDAOImpl implements LoveDAO {
	@Autowired
	private SqlSessionTemplate sst;

	public boolean findLoveProduct(LoveDTO love) {
		String result = sst.selectOne("lovens.findLoveProduct", love);
		return Boolean.parseBoolean(result);
	}
	
	public void insert(LoveDTO love) {
		sst.insert("lovens.insert", love);
	}
	
	public int getTotal(String m_email) {
		return sst.selectOne("lovens.getTotal", m_email);
	}
	
	public List<LoveDTO> getShopNo(String m_email) {
		return sst.selectList("lovens.getShopNo", m_email);
	}
	
	public List<LoveDTO> list(String m_email) {
		return sst.selectList("lovens.list", m_email);
	}
	
	public void delete(int love_no) {
		sst.delete("lovens.delete", love_no);
	}
	
	public void allDelete(String m_email) {
		sst.delete("lovens.allDelete", m_email);
	}
}
