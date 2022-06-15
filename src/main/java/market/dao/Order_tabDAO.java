package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.Order_manageDTO;
import market.model.Order_productDTO;

@Repository
public class Order_tabDAO {

	@Autowired
	private SqlSessionTemplate sst;

	public int lastseq() {
		return sst.selectOne("order_tabns.lastseq");
	}

	// 주문리스트 총갯수 구해오기
	public int getTotal(int s_no) {
		return sst.selectOne("order_managens.getTotal",s_no);
	}
	
	// 주문리스트 불러오기
	public List<Order_manageDTO> olist(Order_manageDTO order_manage) {
		return sst.selectList("order_managens.list", order_manage);
	}

	public List<Order_manageDTO> odlist(int o_no) {
		return sst.selectList("order_managens.odlist", o_no);
	}

	// 운송번호 입력
	public int deliNoInsert(Order_manageDTO omdto) {
		return sst.update("order_managens.dinsert", omdto);
	}

	// 배송완료처리
	public int deliOk(int op_no) {
		return sst.update("order_managens.deliOk", op_no);
	}

	// 품절 취소 처리
	public int cancel(Order_manageDTO omdto) {
		return sst.update("order_managens.cancel", omdto);
	}

	// 환불리스트 불러오기
	public List<Order_productDTO> oplist(int s_no) {
		return sst.selectList("order_managens.refundList", s_no);
	}

	// 환불승인
	public int refundOk(int op_no) {
		return sst.update("order_managens.refundOk", op_no);
	}

	// 환불거부
	public int refundNo(int op_no) {
		return sst.update("order_managens.refundNo", op_no);
	}

}
