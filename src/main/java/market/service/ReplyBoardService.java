package market.service;

import java.util.List;
import market.model.ReplyBoard;

public interface ReplyBoardService {
	List<ReplyBoard> list(int num);

	void insert(ReplyBoard rb);

	void delete(int rno);

	void update(ReplyBoard rb);
}