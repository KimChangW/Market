package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.FollowDAO;
import market.model.FollowDTO;

@Service
public class FollowServiceImpl implements FollowService {
	@Autowired
	private FollowDAO fd;

	public boolean findFollowShop(FollowDTO follow) {
		return fd.findFollowShop(follow);
	}
	
	public void insert(FollowDTO follow) {
		fd.insert(follow);
	}
	
	public int getTotal(String m_email) {
		return fd.getTotal(m_email);
	}
	
	public List<FollowDTO> getShopNo(String m_email) {
		return fd.getShopNo(m_email);
	}
	
	public List<FollowDTO> list(String m_email) {
		return fd.list(m_email);
	}
	
	public void delete(int f_no) {
		fd.delete(f_no);
	}
	
	public void allDelete(String m_email) {
		fd.allDelete(m_email);
	}
}
