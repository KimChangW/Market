package market.model;

import java.util.Date;

public class RestockDTO {

	private int re_no;
	private String m_email;
	private int p_no;
	
	// product
	private int cate_no;
	private int s_no;
	private String p_group_buying;
	private String p_follow_sale;
	private String p_name;
	private String p_detail;
	private int p_group_price;
	private int p_sell_price;
	private int p_follow_price;
	private int p_stock;
	private Date p_regdate;
	private String p_status;
	private int p_hit;
	
	// shop
	private String s_name;
	
	//product_img
	private String p_img;
	
	private int total;

	public int getRe_no() {
		return re_no;
	}

	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public int getCate_no() {
		return cate_no;
	}

	public void setCate_no(int cate_no) {
		this.cate_no = cate_no;
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
	}

	public String getP_group_buying() {
		return p_group_buying;
	}

	public void setP_group_buying(String p_group_buying) {
		this.p_group_buying = p_group_buying;
	}

	public String getP_follow_sale() {
		return p_follow_sale;
	}

	public void setP_follow_sale(String p_follow_sale) {
		this.p_follow_sale = p_follow_sale;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_detail() {
		return p_detail;
	}

	public void setP_detail(String p_detail) {
		this.p_detail = p_detail;
	}

	public int getP_group_price() {
		return p_group_price;
	}

	public void setP_group_price(int p_group_price) {
		this.p_group_price = p_group_price;
	}

	public int getP_sell_price() {
		return p_sell_price;
	}

	public void setP_sell_price(int p_sell_price) {
		this.p_sell_price = p_sell_price;
	}

	public int getP_follow_price() {
		return p_follow_price;
	}

	public void setP_follow_price(int p_follow_price) {
		this.p_follow_price = p_follow_price;
	}

	public int getP_stock() {
		return p_stock;
	}

	public void setP_stock(int p_stock) {
		this.p_stock = p_stock;
	}

	public Date getP_regdate() {
		return p_regdate;
	}

	public void setP_regdate(Date p_regdate) {
		this.p_regdate = p_regdate;
	}

	public String getP_status() {
		return p_status;
	}

	public void setP_status(String p_status) {
		this.p_status = p_status;
	}

	public int getP_hit() {
		return p_hit;
	}

	public void setP_hit(int p_hit) {
		this.p_hit = p_hit;
	}

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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
}
