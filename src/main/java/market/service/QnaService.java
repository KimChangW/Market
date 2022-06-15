package market.service;

import java.util.List;

import market.model.QnaDTO;

public interface QnaService {
	
	int getTotal(QnaDTO qna);

	List<QnaDTO> list(QnaDTO qna);
	
	List<QnaDTO> selectOrderList(QnaDTO qna);
	
	QnaDTO selectOrderOne(QnaDTO qna);

	int insert(QnaDTO qna);
	
	int answer(QnaDTO qna);
	
	QnaDTO select(int qna_no);

	int update(QnaDTO qna);

	int delete(int qna_no);


}