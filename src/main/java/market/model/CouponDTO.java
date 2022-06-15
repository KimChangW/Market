package market.model;

import java.util.Date;

public class CouponDTO {

	private int cp_no;
	private String cp_type;
	private String cp_name;
	private int cp_sale_price;
	private int cp_sale_rate;
	private Date cp_start_date;
	private Date cp_end_date;
	private String cp_delstatus;
	
	public int getCp_no() {
		return cp_no;
	}
	public void setCp_no(int cp_no) {
		this.cp_no = cp_no;
	}
	public String getCp_type() {
		return cp_type;
	}
	public void setCp_type(String cp_type) {
		this.cp_type = cp_type;
	}
	public String getCp_name() {
		return cp_name;
	}
	public void setCp_name(String cp_name) {
		this.cp_name = cp_name;
	}
	public int getCp_sale_price() {
		return cp_sale_price;
	}
	public void setCp_sale_price(int cp_sale_price) {
		this.cp_sale_price = cp_sale_price;
	}
	public int getCp_sale_rate() {
		return cp_sale_rate;
	}
	public void setCp_sale_rate(int cp_sale_rate) {
		this.cp_sale_rate = cp_sale_rate;
	}
	public Date getCp_start_date() {
		return cp_start_date;
	}
	public void setCp_start_date(Date cp_start_date) {
		this.cp_start_date = cp_start_date;
	}
	public Date getCp_end_date() {
		return cp_end_date;
	}
	public void setCp_end_date(Date cp_end_date) {
		this.cp_end_date = cp_end_date;
	}
	public String getCp_delstatus() {
		return cp_delstatus;
	}
	public void setCp_delstatus(String cp_delstatus) {
		this.cp_delstatus = cp_delstatus;
	}
}
