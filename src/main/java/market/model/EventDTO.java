package market.model;

import java.util.Date;

public class EventDTO {

	private int e_no;
	private String e_fix;
	private String e_title;
	private String e_content;
	private Date e_writedate;
	private String e_delstatus;
	
	public int getE_no() {
		return e_no;
	}
	public void setE_no(int e_no) {
		this.e_no = e_no;
	}
	public String getE_fix() {
		return e_fix;
	}
	public void setE_fix(String e_fix) {
		this.e_fix = e_fix;
	}
	public String getE_title() {
		return e_title;
	}
	public void setE_title(String e_title) {
		this.e_title = e_title;
	}
	public String getE_content() {
		return e_content;
	}
	public void setE_content(String e_content) {
		this.e_content = e_content;
	}
	public Date getE_writedate() {
		return e_writedate;
	}
	public void setE_writedate(Date e_writedate) {
		this.e_writedate = e_writedate;
	}
	public String getE_delstatus() {
		return e_delstatus;
	}
	public void setE_delstatus(String e_delstatus) {
		this.e_delstatus = e_delstatus;
	}
}
