package market.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import market.dao.CartDAO;
import market.dao.MemberDAO;
import market.dao.OrderDAO;
import market.dao.ProductDAO;
import market.model.CartDTO;
import market.model.DeliveryDTO;
import market.model.OrderPageItemDTO;
import market.model.Order_productDTO;
import market.model.Order_tabDTO;
import market.model.ProductDTO;

@Service
public class OrderServiceImpl implements OrdereService{

	@Autowired
	private OrderDAO od;
	
	@Autowired
	private CartDAO cd;
	
	@Autowired
	private ProductDAO pd;

	@Override
	public OrderPageItemDTO getProductInfo(int p_no){	
		return od.getProductInfo(p_no);
	}
	
	@Override
	public DeliveryDTO getDeliveryInfo(String m_email) {
		System.out.println("OrderServiceImpl");
		return od.getDeliveryInfo(m_email);
	}

	@Override
	public int getAddressCount(String m_email) {
		return od.getAddressCount(m_email);
	}
	
	
	@Override
	public int deliveryInsertY(DeliveryDTO delivery) {
		return od.deliveryInsertY(delivery);
	}
	
	@Override
	public int deliveryInsertN(DeliveryDTO delivery) {
		return od.deliveryInsertN(delivery);
	}

	@Override
	public List<DeliveryDTO> getDeliveryList(String m_email) {
		return od.getDeliveryList(m_email);
	}

	@Override
	public int UpdateDefaultN(String m_email) {
		return od.UpdateDefaultN(m_email);
	}

	@Override
	public int UpdateDefaultY(int d_no) {
		return od.UpdateDefaultY(d_no);
	}

	@Override
	public int addressUpdate(DeliveryDTO delivery) {
		return od.addressUpdate(delivery);
	}

	@Override
	public int deleteAddr(int d_no) {
		return od.deleteAddr(d_no);
	}

	@Override
	public DeliveryDTO getDelivery(int d_no) {
		return od.getDelivery(d_no);
	}

	@Override
	public Order_productDTO getOrderInfo(int p_no) {
		return od.getOrderInfo(p_no);
	}
	
	@Override
	public Order_tabDTO getOrderNo(Order_tabDTO otd) {
		return od.getOrderNo(otd);
	}

	@Override
	public int orderInsert(Order_tabDTO otd) {
		return od.orderInsert(otd);
	}

	@Override
	public int orderGroupProductInsert(Order_productDTO opd) {
		return od.orderGroupProductInsert(opd);
	}

	@Override
	public int orderProductInsert(Order_productDTO opd) {
		return od.orderProductInsert(opd);
	}

	@Override
	public List<Order_productDTO> getPNo(int o_no) {
		return od.getPNo(o_no);
	}
	
	@Override
	public ProductDTO productInfo(int p_no) {
		return od.productInfo(p_no);
	}

	@Override
	public int updateStock(ProductDTO product) {
		return od.updateStock(product);
	}

	@Override
	public int orderProductDelete(int o_no) {
		return od.orderProductDelete(o_no);
	}

	@Override
	public int orderDelete(int o_no) {
		return od.orderDelete(o_no);
	}









}
