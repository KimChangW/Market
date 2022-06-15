package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.CartDTO;
import market.model.FollowDTO;
import market.model.ProductDTO;

@Repository
public class CartDAOImpl implements CartDAO{
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public boolean findCartProduct(CartDTO cart) {
		String result = sst.selectOne("cartns.findCartProduct", cart);
		return Boolean.parseBoolean(result);
	}

	@Override
	public void insert(CartDTO cart) {
		sst.insert("cartns.insert", cart);
	}
	
	@Override
	public List<CartDTO> getShopNo(String m_email) {
		return sst.selectList("cartns.getShopNo", m_email);
	}

	@Override
	public List<CartDTO> list(String m_email) {
		return sst.selectList("cartns.list", m_email);
	}

	@Override
	public List<FollowDTO> getFollowList(String m_email) {
		return sst.selectList("cartns.getFollowList", m_email);
	}
	
	@Override
	public void update(CartDTO cart) {
		sst.update("cartns.update", cart);
	}

	@Override
	public void delete(int cart_no) {
		sst.delete("cartns.delete", cart_no);
	}

	@Override
	public void allDelete(String m_email) {
		sst.delete("cartns.allDelete", m_email);
	}

	@Override
	public int deleteOrderCart(CartDTO cart) {
		return sst.delete("cartns.deleteOrderCart", cart);
	}








}
