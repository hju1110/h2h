package vo;

public class MemberAddr {
	private int ma_idx;
	private String mi_id, mi_name,mi_email, mi_phone;
	private String ma_name, ma_rname, ma_phone;
	private String ma_zip, ma_addr1, ma_addr2, ma_basic, ma_date;
	
	
	
	
	
	public MemberAddr(int ma_idx, String mi_id, String mi_name, String mi_email, String mi_phone, String ma_name,
			String ma_rname, String ma_phone, String ma_zip, String ma_addr1, String ma_addr2, String ma_basic,
			String ma_date) {
		super();
		this.ma_idx = ma_idx;
		this.mi_id = mi_id;
		this.mi_name = mi_name;
		this.mi_email = mi_email;
		this.mi_phone = mi_phone;
		this.ma_name = ma_name;
		this.ma_rname = ma_rname;
		this.ma_phone = ma_phone;
		this.ma_zip = ma_zip;
		this.ma_addr1 = ma_addr1;
		this.ma_addr2 = ma_addr2;
		this.ma_basic = ma_basic;
		this.ma_date = ma_date;
	}
	public String getMi_name() {
		return mi_name;
	}
	public void setMi_name(String mi_name) {
		this.mi_name = mi_name;
	}
	public String getMi_email() {
		return mi_email;
	}
	public void setMi_email(String mi_email) {
		this.mi_email = mi_email;
	}
	public String getMi_phone() {
		return mi_phone;
	}
	public void setMi_phone(String mi_phone) {
		this.mi_phone = mi_phone;
	}
	public int getMa_idx() {
		return ma_idx;
	}
	public void setMa_idx(int ma_idx) {
		this.ma_idx = ma_idx;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getMa_name() {
		return ma_name;
	}
	public void setMa_name(String ma_name) {
		this.ma_name = ma_name;
	}
	public String getMa_rname() {
		return ma_rname;
	}
	public void setMa_rname(String ma_rname) {
		this.ma_rname = ma_rname;
	}
	public String getMa_phone() {
		return ma_phone;
	}
	public void setMa_phone(String ma_phone) {
		this.ma_phone = ma_phone;
	}
	public String getMa_zip() {
		return ma_zip;
	}
	public void setMa_zip(String ma_zip) {
		this.ma_zip = ma_zip;
	}
	public String getMa_addr1() {
		return ma_addr1;
	}
	public void setMa_addr1(String ma_addr1) {
		this.ma_addr1 = ma_addr1;
	}
	public String getMa_addr2() {
		return ma_addr2;
	}
	public void setMa_addr2(String ma_addr2) {
		this.ma_addr2 = ma_addr2;
	}
	public String getMa_basic() {
		return ma_basic;
	}
	public void setMa_basic(String ma_basic) {
		this.ma_basic = ma_basic;
	}
	public String getMa_date() {
		return ma_date;
	}
	public void setMa_date(String ma_date) {
		this.ma_date = ma_date;
	}
	
}
