package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.QnaDAO;
import market.model.QnaDTO;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDAO qd;
	
	public int getTotal(QnaDTO qna) {
		return qd.getTotal(qna);
	}

	public List<QnaDTO> list(QnaDTO qna) {
		return qd.list(qna);
	}

	public List<QnaDTO> selectOrderList(QnaDTO qna) {
		return qd.selectOrderList(qna);
	}

	public QnaDTO selectOrderOne(QnaDTO qna) {
		return qd.selectOrderOne(qna);
	}

	public int insert(QnaDTO qna) {
		return qd.insert(qna);
	}

	public int answer(QnaDTO qna) {
		return qd.answer(qna);
	}
	
	public QnaDTO select(int qna_no) {
		return qd.select(qna_no);
	}

	public int update(QnaDTO qna) {
		return qd.update(qna);
	}

	public int delete(int qna_no) {
		return qd.delete(qna_no);
	}

}
