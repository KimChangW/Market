package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.Order_productDAOImpl;
import market.model.Order_productDTO;


@Service
public class Order_productServiceImpl implements Order_productService{

	@Autowired
	private Order_productDAOImpl opdao;
	
	public List<Order_productDTO> orderList(Order_productDTO opdto) throws Exception{
		return opdao.orderList(opdto);
	}
	
	public int getTotal(String m_email) throws Exception{
		int result = opdao.getTotal(m_email);
		return result;
	}
	
	public Order_productDTO orderDetail(int op_no) throws Exception{
		Order_productDTO detail = opdao.orderDetail(op_no);
		return detail;
	}
	
	public List<Order_productDTO> detailList(int o_no) throws Exception{
		List<Order_productDTO> detailList = opdao.detailList(o_no);
		return detailList;
	}
	
	public int cancel(int op_no) throws Exception{
		int result = opdao.cancel(op_no);
		return result;
	}
	
	public int refundForm(Order_productDTO opdto) throws Exception{
		int result = opdao.refundForm(opdto);
		return result;
	}
	
	public int confirm(int op_no) throws Exception{
		int result = opdao.confirm(op_no);
		return result;
	}
	
	public Order_productDTO shopInfo(Order_productDTO opdto) throws Exception{
		Order_productDTO shopInfo = opdao.shopInfo(opdto);
		return shopInfo;
	}
	
	
}
