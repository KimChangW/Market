package market.model;

public class OrderPageItemDTO {

	// cart
	private int cart_no;
	private int p_no;
	private int cart_qty;
	private String m_email;
	private String op_type;
	
	// product
	private String p_name;
	private int p_sell_price;
	private int p_group_price;
	private int p_follow_price;
	private int s_no;

	// shop
	private String s_name;
	
	// product_img
	private String p_img;
	
	// 공동구매
	private int group_op_no;
	private int group_order;
	
	// 만들어 낼 값
	private int total_price;

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
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

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	
	public String getOp_type() {
		return op_type;
	}

	public void setOp_type(String op_type) {
		this.op_type = op_type;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getP_sell_price() {
		return p_sell_price;
	}

	public void setP_sell_price(int p_sell_price) {
		this.p_sell_price = p_sell_price;
	}

	public int getP_group_price() {
		return p_group_price;
	}

	public void setP_group_price(int p_group_price) {
		this.p_group_price = p_group_price;
	}

	public int getP_follow_price() {
		return p_follow_price;
	}

	public void setP_follow_price(int p_follow_price) {
		this.p_follow_price = p_follow_price;
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
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

	public int getGroup_op_no() {
		return group_op_no;
	}

	public void setGroup_op_no(int group_op_no) {
		this.group_op_no = group_op_no;
	}

	public int getGroup_order() {
		return group_order;
	}

	public void setGroup_order(int group_order) {
		this.group_order = group_order;
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

	@Override
	public String toString() {
		return "OrderPageItemDTO [cart_no=" + cart_no + ", p_no=" + p_no + ", cart_qty=" + cart_qty + ", m_email="
				+ m_email + ", op_type=" + op_type + ", p_name=" + p_name + ", p_sell_price=" + p_sell_price
				+ ", p_group_price=" + p_group_price + ", p_follow_price=" + p_follow_price + ", s_no=" + s_no
				+ ", s_name=" + s_name + ", p_img=" + p_img + ",group_op_no="+ group_op_no + ",group_order="+ group_order + ", total_price=" + total_price + "]";
	}



	
	
	
	
	
	
}
