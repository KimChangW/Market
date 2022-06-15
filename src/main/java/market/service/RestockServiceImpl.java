package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.RestockDAO;
import market.model.RestockDTO;

@Service
public class RestockServiceImpl implements RestockService {
	@Autowired
	private RestockDAO rd;
	
	public boolean findRestockProduct(RestockDTO restock) {
		return rd.findRestockProduct(restock);
	}
	
	public void insert(RestockDTO restock) {
		rd.insert(restock);
	}
	
	public int getTotal(String m_email) {
		return rd.getTotal(m_email);
	}
	
	public List<RestockDTO> getShopNo(String m_email) {
		return rd.getShopNo(m_email);
	}
	
	public List<RestockDTO> list(String m_email) {
		return rd.list(m_email);
	}
	
	public void delete(int re_no) {
		rd.delete(re_no);
	}
	
	public void allDelete(String m_email) {
		rd.allDelete(m_email);
	}
}
