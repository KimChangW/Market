package market.dao;

import java.util.List;

import market.model.FollowDTO;

public interface FollowDAO {
	
	boolean findFollowShop(FollowDTO follow);
	
	void insert(FollowDTO follow);
	
	int getTotal(String m_email);
	
	List<FollowDTO> getShopNo(String m_email);
	
	List<FollowDTO> list(String m_email);
	
	void delete(int f_no);
	
	void allDelete(String m_email);

}
