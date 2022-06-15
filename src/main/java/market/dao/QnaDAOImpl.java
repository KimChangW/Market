package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.QnaDTO;

@Repository
public class QnaDAOImpl implements QnaDAO {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public int getTotal(QnaDTO qna) {
		return sst.selectOne("qnans.getTotal", qna);
	}

	public List<QnaDTO> list(QnaDTO qna) {
		return sst.selectList("qnans.list", qna);
	}
	
	public List<QnaDTO> selectOrderList(QnaDTO qna) {
		return sst.selectList("qnans.selectOrderList", qna);
	}

	public QnaDTO selectOrderOne(QnaDTO qna) {
		return sst.selectOne("qnans.selectOrderOne", qna);
	}

	public int insert(QnaDTO qna) {
		return sst.insert("qnans.insert", qna);
	}

	public int answer(QnaDTO qna) {
		return sst.update("qnans.answer", qna);
	}

	public QnaDTO select(int qna_no) {
		return sst.selectOne("qnans.select", qna_no);
	}

	public int update(QnaDTO qna) {
		return sst.update("qnans.update", qna);
	}

	public int delete(int qna_no) {
		return sst.update("qnans.delete", qna_no);
	}

}
