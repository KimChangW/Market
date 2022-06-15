package market.model;

import java.util.Date;

public class QnaDTO {

	private int qna_no;
	private int p_no;
	private int op_no;
	private String m_email;
	private String qna_title;
	private String qna_question;
	private String qna_answer;
	private int qna_ref;
	private String qna_secret;
	private int s_no;
	private Date qna_writedate;
	private String qna_delstatus;

	// page
	private int startRow;
	private int endRow;
	
	// 검색
	private String search;
	private String keyword;
	
	//member join
	private String m_name;
	
	//product join
	private String p_name;
	private int p_sell_price;
	
	//order_product join
	private int o_no;
	private Date op_date; 
	
	//shop join
	private String s_name;
	
	//product_img join
	private String p_img;	

	
	

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	public String getP_img() {
		return p_img;
	}

	public void setP_img(String p_img) {
		this.p_img = p_img;
	}

	public int getP_sell_price() {
		return p_sell_price;
	}

	public void setP_sell_price(int p_sell_price) {
		this.p_sell_price = p_sell_price;
	}

	public int getO_no() {
		return o_no;
	}

	public void setO_no(int o_no) {
		this.o_no = o_no;
	}

	public Date getOp_date() {
		return op_date;
	}

	public void setOp_date(Date op_date) {
		this.op_date = op_date;
	}


	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public int getOp_no() {
		return op_no;
	}

	public void setOp_no(int op_no) {
		this.op_no = op_no;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_question() {
		return qna_question;
	}

	public void setQna_question(String qna_question) {
		this.qna_question = qna_question;
	}

	public String getQna_answer() {
		return qna_answer;
	}

	public void setQna_answer(String qna_answer) {
		this.qna_answer = qna_answer;
	}

	public int getQna_ref() {
		return qna_ref;
	}

	public void setQna_ref(int qna_ref) {
		this.qna_ref = qna_ref;
	}

	public String getQna_secret() {
		return qna_secret;
	}

	public void setQna_secret(String qna_secret) {
		this.qna_secret = qna_secret;
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
	}

	public Date getQna_writedate() {
		return qna_writedate;
	}

	public void setQna_writedate(Date qna_writedate) {
		this.qna_writedate = qna_writedate;
	}

	public String getQna_delstatus() {
		return qna_delstatus;
	}

	public void setQna_delstatus(String qna_delstatus) {
		this.qna_delstatus = qna_delstatus;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	
}
