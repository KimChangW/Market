
package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.LoveDAO;
import market.model.LoveDTO;

@Service
public class LoveServiceImpl implements LoveService{
	@Autowired
	private LoveDAO ld;

	public boolean findLoveProduct(LoveDTO love) {
		return ld.findLoveProduct(love);
	}
	
	public void insert(LoveDTO love) {
		ld.insert(love);
	}
	
	public int getTotal(String m_email) {
		return ld.getTotal(m_email);
	}
	
	public List<LoveDTO> getShopNo(String m_email) {
		return ld.getShopNo(m_email);
	}
	
	public List<LoveDTO> list(String m_email) {
		return ld.list(m_email);
	}
	
	public void delete(int love_no) {
		ld.delete(love_no);
	}
	
	public void allDelete(String m_email) {
		ld.allDelete(m_email);
	}
}
