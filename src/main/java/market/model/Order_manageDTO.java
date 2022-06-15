package market.model;

import java.util.Date;

public class Order_manageDTO {

	private int o_no;
	private int op_no;
	private int s_no;
	private String m_email;
	private String d_address;
	private String d_detail_address;
	private String d_name;
	private String d_msg;
	private int o_total_price;
	private int o_sale_price;
	private int o_pay_price;
	private String o_pay_type;
	private Date o_date;
	private int p_no;
	private String p_name;
	private int op_qty;
	private int p_sell_price;
	private String op_status;
	private String op_deli_no;

	// page
	private int startRow;
	private int endRow;

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

	public String getOp_deli_no() {
		return op_deli_no;
	}

	public void setOp_deli_no(String op_deli_no) {
		this.op_deli_no = op_deli_no;
	}

	public String getOp_status() {
		return op_status;
	}

	public void setOp_status(String op_status) {
		this.op_status = op_status;
	}

	public int getO_no() {
		return o_no;
	}

	public void setO_no(int o_no) {
		this.o_no = o_no;
	}

	public int getOp_no() {
		return op_no;
	}

	public void setOp_no(int op_no) {
		this.op_no = op_no;
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getD_address() {
		return d_address;
	}

	public void setD_address(String d_address) {
		this.d_address = d_address;
	}

	public String getD_detail_address() {
		return d_detail_address;
	}

	public void setD_detail_address(String d_detail_address) {
		this.d_detail_address = d_detail_address;
	}

	public String getD_name() {
		return d_name;
	}

	public void setD_name(String d_name) {
		this.d_name = d_name;
	}

	public String getD_msg() {
		return d_msg;
	}

	public void setD_msg(String d_msg) {
		this.d_msg = d_msg;
	}

	public int getO_total_price() {
		return o_total_price;
	}

	public void setO_total_price(int o_total_price) {
		this.o_total_price = o_total_price;
	}

	public int getO_sale_price() {
		return o_sale_price;
	}

	public void setO_sale_price(int o_sale_price) {
		this.o_sale_price = o_sale_price;
	}

	public int getO_pay_price() {
		return o_pay_price;
	}

	public void setO_pay_price(int o_pay_price) {
		this.o_pay_price = o_pay_price;
	}

	public String getO_pay_type() {
		return o_pay_type;
	}

	public void setO_pay_type(String o_pay_type) {
		this.o_pay_type = o_pay_type;
	}

	public Date getO_date() {
		return o_date;
	}

	public void setO_date(Date o_date) {
		this.o_date = o_date;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getOp_qty() {
		return op_qty;
	}

	public void setOp_qty(int op_qty) {
		this.op_qty = op_qty;
	}

	public int getP_sell_price() {
		return p_sell_price;
	}

	public void setP_sell_price(int p_sell_price) {
		this.p_sell_price = p_sell_price;
	}

}
