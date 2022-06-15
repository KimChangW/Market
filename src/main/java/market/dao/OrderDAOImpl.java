package market.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.CartDTO;
import market.model.DeliveryDTO;
import market.model.OrderPageItemDTO;
import market.model.Order_productDTO;
import market.model.Order_tabDTO;
import market.model.ProductDTO;

@Repository
public class OrderDAOImpl implements OrderDAO{

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public OrderPageItemDTO getProductInfo(int p_no) {
		return sst.selectOne("orderpagens.getProductInfo", p_no);
	}

	@Override
	public DeliveryDTO getDeliveryInfo(String m_email) {
		return sst.selectOne("orderpagens.getDeliveryInfo", m_email);
	}


	@Override
	public int getAddressCount(String m_email) {
		return sst.selectOne("orderpagens.getAddressCount", m_email);
	}
	
	@Override
	public int deliveryInsertY(DeliveryDTO delivery) {
		return sst.insert("orderpagens.deliveryInsertY", delivery);
	}
	
	@Override
	public int deliveryInsertN(DeliveryDTO delivery) {
		return sst.insert("orderpagens.deliveryInsertN", delivery);
	}

	@Override
	public List<DeliveryDTO> getDeliveryList(String m_email) {
		return sst.selectList("orderpagens.getDeliveryList", m_email);
	}

	@Override
	public int UpdateDefaultN(String m_email) {
		return sst.update("orderpagens.UpdateDefaultN", m_email);
	}

	@Override
	public int UpdateDefaultY(int d_no) {
		return sst.update("orderpagens.UpdateDefaultY", d_no);
	}

	@Override
	public int addressUpdate(DeliveryDTO delivery) {
		return sst.update("orderpagens.addressUpdate", delivery);
	}

	@Override
	public int deleteAddr(int d_no) {
		return sst.delete("orderpagens.deleteAddr", d_no);
	}

	@Override
	public DeliveryDTO getDelivery(int d_no) {
		return sst.selectOne("orderpagens.getDelivery", d_no);
	}

	@Override
	public Order_productDTO getOrderInfo(int p_no) {
		System.out.println("p_no:"+p_no);
		return sst.selectOne("orderpagens.getOrderInfo", p_no);
	}
	
	@Override
	public int orderInsert(Order_tabDTO product) {
		return sst.insert("orderpagens.orderInsert", product);
	}
	
	@Override
	public Order_tabDTO getOrderNo(Order_tabDTO otd) {
		return sst.selectOne("orderpagens.getOrderNo", otd);
	}
	
	@Override
	public int orderGroupProductInsert(Order_productDTO opd) {
		// TODO Auto-generated method stub
		return sst.insert("orderpagens.orderGroupProductInsert", opd);
	}
	
	@Override
	public int orderProductInsert(Order_productDTO opd) {
		return sst.insert("orderpagens.orderProductInsert", opd);
	}
	
	@Override
	public List<Order_productDTO> getPNo(int o_no) {
		// TODO Auto-generated method stub
		return sst.selectList("orderpagens.getPNo", o_no);
	}
	
	@Override
	public ProductDTO productInfo(int p_no) {
		return sst.selectOne("orderpagens.productInfo", p_no);
	}

	@Override
	public int updateStock(ProductDTO product) {
		return sst.update("orderpagens.updateStock", product);
	}

	@Override
	public int orderProductDelete(int o_no) {
		return sst.delete("orderpagens.orderProductDelete", o_no);
	}

	@Override
	public int orderDelete(int o_no) {
		return sst.delete("orderpagens.orderDelete", o_no);
	}











}
