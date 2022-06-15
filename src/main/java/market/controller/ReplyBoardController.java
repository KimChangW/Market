package market.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import market.model.Board;
import market.model.ReplyBoard;
import market.service.BoardService;
import market.service.ReplyBoardService;

@Controller
public class ReplyBoardController {
	@Autowired
	private ReplyBoardService rbs;
	@Autowired
	private BoardService bs;

	@RequestMapping("slist.do")
	public String slist(int num, Model model) {
		Board board = bs.select(num);
		List<ReplyBoard> slist = rbs.list(num);
		model.addAttribute("slist", slist);
		model.addAttribute("board", board);
		return "board/slist";
	}

	@RequestMapping("sInsert.do")
	public String sInsert(ReplyBoard rb, Model model) {
		rbs.insert(rb);
		return "redirect:slist.do?num=" + rb.getBno();
	}

	@RequestMapping("repDelete.do")
	public String delete(ReplyBoard rb, Model model) {
		rbs.delete(rb.getRno());
		return "redirect:slist.do?num=" + rb.getBno();
	}

	@RequestMapping("repUpdate.do")
	public String repUpdate(ReplyBoard rb, Model model) {
		rbs.update(rb);
		return "redirect:slist.do?num=" + rb.getBno();
	}
}