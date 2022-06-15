package market.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import market.dao.CartDAO;
import market.model.CartDTO;
import market.model.FollowDTO;
import market.model.ProductDTO;

@Service
public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO cd;

	@Override
	public boolean findCartProduct(CartDTO cart) {
		return cd.findCartProduct(cart);
	}
	
	@Override
	public void insert(CartDTO cart) {
		cd.insert(cart);
	}

	@Override
	public List<CartDTO> getShopNo(String m_email) {
		return cd.getShopNo(m_email);
	}
	
	@Override
	public List<CartDTO> list(String m_email) {
		return cd.list(m_email);
	}

	@Override
	public List<FollowDTO> getFollowList(String m_email) {
		return cd.getFollowList(m_email);
	}
	
	@Override
	public void update(CartDTO cart) {
		cd.update(cart);
	}

	@Override
	public void delete(int cart_no) {
		cd.delete(cart_no);
	}

	@Override
	public void allDelete(String m_email) {
		cd.allDelete(m_email);
	}

	@Override
	public int deleteOrderCart(CartDTO cart) {
		return cd.deleteOrderCart(cart);
	}







	

	
	
}
