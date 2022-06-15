package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.Order_productDAO;
import market.dao.Order_tabDAO;
import market.model.Order_manageDTO;
import market.model.Order_productDTO;

@Service
public class ShopManageService {
	@Autowired
	private Order_tabDAO otdao;

	//주문리스트 총갯수 구해오기
	public int getTotal(int s_no) {
		return otdao.getTotal(s_no);
	}
	
	// 주문리스트 불러오기
	public List<Order_manageDTO> olist(Order_manageDTO order_manage) {
		return otdao.olist(order_manage);
	}

	// 주문상세리스트 불러오기
	public List<Order_manageDTO> odlist(int o_no) {
		return otdao.odlist(o_no);
	}

	// 환불신청 리스트 불러오기
	public List<Order_productDTO> oplist(int s_no) {
		return otdao.oplist(s_no);
	}

	// 환불승인
	public int refundOk(int op_no) {
		return otdao.refundOk(op_no);
	}

	// 환불승인
	public int refundNo(int op_no) {
		return otdao.refundNo(op_no);
	}

	// 운송번호 입력
	public int deliNoInsert(Order_manageDTO omdto) {
		return otdao.deliNoInsert(omdto);
	}
	
	//배송완료처리
	public int deliOk(int op_no) {
		return otdao.deliOk(op_no);
	}

	// 품절취소처리
	public int cancel(Order_manageDTO omdto) {
		return otdao.cancel(omdto);
	}

}
