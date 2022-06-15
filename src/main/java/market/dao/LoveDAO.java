package market.dao;

import java.util.List;

import market.model.LoveDTO;

public interface LoveDAO {
	
	boolean findLoveProduct(LoveDTO love);
	
	void insert(LoveDTO love);
	
	int getTotal(String m_email);
	
	List<LoveDTO> getShopNo(String m_email);
	
	List<LoveDTO> list(String m_email);
	
	void delete(int love_no);
	
	void allDelete(String m_email);
}
