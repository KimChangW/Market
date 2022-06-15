package market.model;

import java.util.Date;

public class CartDTO {

	private int cart_no;
	private String m_email;
	private int p_no;
	private int cart_qty;
	private Date cart_regdate;
	
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
	
	// product_img
	private String p_img;
	
	// order_product
	private String op_type;
	
	
	// 새로 만든  파라미터
	private int total_price;
	
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
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
	public int getCart_qty() {
		return cart_qty;
	}
	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}
	public Date getCart_regdate() {
		return cart_regdate;
	}
	public void setCart_regdate(Date cart_regdate) {
		this.cart_regdate = cart_regdate;
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
	
	public int getTotal_price() {
		return total_price;
	}

	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	public void totalPrice() {
		this.total_price = this.p_sell_price*this.cart_qty;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	public String getOp_type() {
		return op_type;
	}
	public void setOp_type(String op_type) {
		this.op_type = op_type;
	}
	
}

