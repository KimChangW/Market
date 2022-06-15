package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.Order_productDTO;

@Repository
public class Order_productDAOImpl implements Order_productDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Order_productDTO> orderList(Order_productDTO opdto) throws Exception{
		return sst.selectList("order_product.orderList",opdto);
	}
	
	public int getTotal(String m_email) throws Exception{
		return sst.selectOne("order_product.getTotal",m_email);
	}
	
	public Order_productDTO orderDetail(int op_no) throws Exception{
		return sst.selectOne("order_product.orderDetail", op_no);
	}
	
	public List<Order_productDTO> detailList(int o_no) throws Exception{
		return sst.selectList("order_product.detailList", o_no);
	}
	
	public int cancel(int op_no) throws Exception{
		return sst.update("order_product.cancel", op_no);
	}
	
	public int refundForm(Order_productDTO opdto) throws Exception{
		return sst.update("order_product.refundForm", opdto);
	}
	
	public int confirm(int op_no) throws Exception{
		return sst.update("order_product.confirm", op_no);
	}
	
	public Order_productDTO shopInfo(Order_productDTO opdto) throws Exception{
		return sst.selectOne("order_product.shopInfo", opdto);
	}
	
}
