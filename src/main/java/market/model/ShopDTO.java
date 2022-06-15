package market.model;

import java.util.Date;

public class ShopDTO {
	private int s_no; /*상점번호*/
	private String s_email; /* 상점이메일 */
	private String s_passwd; /* 비밀번호 */
	private String s_seckey; /* 보안키 */
	private String s_name; /* 상호명 */
	private String s_ceo; /* 대표자명 */
	private String s_bizno; /* 사업자번호 */
	private String s_tongsin; /* 통신판매업번호 */
	private String s_file; /* 서류첨부 */
	private String s_address; /* 주소 */
	private String s_tel; /* 전화번호 */
	private String s_bank; /* 은행명 */
	private String s_account; /* 정산계좌 */
	private Date s_regdate; /* 가입일 */
	private Date s_deldate; /* 폐점일 */
	private String s_reason; /* 폐점사유 */
	private String s_status; /* 상태 */
	private String s_post; /*우편번호*/
	private String s_profile;
	private String s_myself;
	
	// page
	private int startRow;
	private int endRow;
	//
	private int startRow1;
	private int endRow1;
	
	public int getStartRow1() {
		return startRow1;
	}
	public void setStartRow1(int startRow1) {
		this.startRow1 = startRow1;
	}
	public int getEndRow1() {
		return endRow1;
	}
	public void setEndRow1(int endRow1) {
		this.endRow1 = endRow1;
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
	public int getS_no() {
		return s_no;
	}
	public void setS_no(int s_no) {
		this.s_no = s_no;
	}
	public String getS_email() {
		return s_email;
	}
	public void setS_email(String s_email) {
		this.s_email = s_email;
	}
	public String getS_passwd() {
		return s_passwd;
	}
	public void setS_passwd(String s_passwd) {
		this.s_passwd = s_passwd;
	}
	public String getS_seckey() {
		return s_seckey;
	}
	public void setS_seckey(String s_seckey) {
		this.s_seckey = s_seckey;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_ceo() {
		return s_ceo;
	}
	public void setS_ceo(String s_ceo) {
		this.s_ceo = s_ceo;
	}
	public String getS_bizno() {
		return s_bizno;
	}
	public void setS_bizno(String s_bizno) {
		this.s_bizno = s_bizno;
	}
	public String getS_tongsin() {
		return s_tongsin;
	}
	public void setS_tongsin(String s_tongsin) {
		this.s_tongsin = s_tongsin;
	}
	public String getS_file() {
		return s_file;
	}
	public void setS_file(String s_file) {
		this.s_file = s_file;
	}
	public String getS_address() {
		return s_address;
	}
	public void setS_address(String s_address) {
		this.s_address = s_address;
	}
	public String getS_tel() {
		return s_tel;
	}
	public void setS_tel(String s_tel) {
		this.s_tel = s_tel;
	}
	public String getS_bank() {
		return s_bank;
	}
	public void setS_bank(String s_bank) {
		this.s_bank = s_bank;
	}
	public String getS_account() {
		return s_account;
	}
	public void setS_account(String s_account) {
		this.s_account = s_account;
	}
	public Date getS_regdate() {
		return s_regdate;
	}
	public void setS_regdate(Date s_regdate) {
		this.s_regdate = s_regdate;
	}
	public Date getS_deldate() {
		return s_deldate;
	}
	public void setS_deldate(Date s_deldate) {
		this.s_deldate = s_deldate;
	}
	public String getS_reason() {
		return s_reason;
	}
	public void setS_reason(String s_reason) {
		this.s_reason = s_reason;
	}
	public String getS_status() {
		return s_status;
	}
	public void setS_status(String s_status) {
		this.s_status = s_status;
	}
	public String getS_post() {
		return s_post;
	}
	public void setS_post(String s_post) {
		this.s_post = s_post;
	}
	public String getS_profile() {
		return s_profile;
	}
	public void setS_profile(String s_profile) {
		this.s_profile = s_profile;
	}
	public String getS_myself() {
		return s_myself;
	}
	public void setS_myself(String s_myself) {
		this.s_myself = s_myself;
	}
	
	
	
	
}
