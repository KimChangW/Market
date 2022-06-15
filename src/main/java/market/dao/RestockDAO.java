package market.dao;

import java.util.List;

import market.model.RestockDTO;

public interface RestockDAO {
	
	boolean findRestockProduct(RestockDTO restock);
	
	void insert(RestockDTO restock);
	
	int getTotal(String m_email);
	
	List<RestockDTO> getShopNo(String m_email);
	
	List<RestockDTO> list(String m_email);
	
	void delete(int re_no);
	
	void allDelete(String m_email);

}
