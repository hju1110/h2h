package vo;

import java.util.ArrayList;

public class ProductInfo {
	private String pi_id, pcs_id, pi_name, pi_img1, pi_img2, pi_img3, pi_desc, pi_size, pi_isview, pi_date, pi_last;
	private int pi_price, pi_read, pi_good, pi_stock, pi_sale;
	private String pcs_name;
	
	public ProductInfo(String pi_id, String pcs_id, String pi_name, String pi_img1, String pi_img2,
			String pi_img3, String pi_desc, String pi_size, String pi_isview, String pi_date, String pi_last,
			int pi_price, int pi_read, int pi_good,  int pi_stock, int pi_sale) {		
		this.pi_id = pi_id;
		this.pcs_id = pcs_id;
		this.pi_name = pi_name;
		this.pi_img1 = pi_img1;
		this.pi_img2 = pi_img2;
		this.pi_img3 = pi_img3;
		this.pi_desc = pi_desc;
		this.pi_size = pi_size;
		this.pi_isview = pi_isview;
		this.pi_date = pi_date;
		this.pi_last = pi_last;
		this.pi_price = pi_price;
		this.pi_read = pi_read;
		this.pi_good = pi_good;
		this.pi_stock = pi_stock;
		this.pi_sale = pi_sale;	
	}
	
	 public ProductInfo(String pi_id, String pcs_id, String pi_name, int pi_price, String pi_img1, 
             String pi_img2, String pi_img3, String pi_desc, int pi_read, int pi_sale,
             String pi_isview, String pi_date, String pi_last, String pcs_name, int pi_stock, int pi_good,
             String pi_size) {
		 	this.pi_id = pi_id;
		 	this.pcs_id = pcs_id;
		 	this.pi_name = pi_name;
		 	this.pi_price = pi_price;
		 	this.pi_img1 = pi_img1;
		 	this.pi_img2 = pi_img2;
		 	this.pi_img3 = pi_img3;
		 	this.pi_desc = pi_desc;
		 	this.pi_read = pi_read;
		 	this.pi_sale = pi_sale;
		 	this.pi_isview = pi_isview;
		 	this.pi_date = pi_date;
		 	this.pi_last = pi_last;
		 	this.pcs_name = pcs_name;
		 	
		 	this.pi_stock = pi_stock;
		 	this.pi_good = pi_good;
		 	this.pi_size = pi_size;
	 }
	 
   public ProductInfo(String pi_id, String pcs_id, String pi_name, int pi_price, int pi_stock, String pi_img1, String pi_img2, String pi_img3, String pi_desc) {
		this.pi_id = pi_id;
		this.pcs_id = pcs_id;
		this.pi_name = pi_name;
		this.pi_price = pi_price;
		this.pi_stock = pi_stock;
		this.pi_img1 = pi_img1;
		this.pi_img2 = pi_img2;
		this.pi_img3 = pi_img3;
		this.pi_desc = pi_desc;
	}

	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPcs_id() {
		return pcs_id;
	}
	public void setPcs_id(String pcs_id) {
		this.pcs_id = pcs_id;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}
	public String getPi_img2() {
		return pi_img2;
	}
	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}
	public String getPi_img3() {
		return pi_img3;
	}
	public void setPi_img3(String pi_img3) {
		this.pi_img3 = pi_img3;
	}
	public String getPi_desc() {
		return pi_desc;
	}
	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}
	public String getPi_size() {
		return pi_size;
	}
	public void setPi_size(String pi_size) {
		this.pi_size = pi_size;
	}
	public String getPi_isview() {
		return pi_isview;
	}
	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}
	public String getPi_date() {
		return pi_date;
	}
	public void setPi_date(String pi_date) {
		this.pi_date = pi_date;
	}
	public String getPi_last() {
		return pi_last;
	}
	public void setPi_last(String pi_last) {
		this.pi_last = pi_last;
	}
	public int getPi_price() {
		return pi_price;
	}
	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}
	public int getPi_read() {
		return pi_read;
	}
	public void setPi_read(int pi_read) {
		this.pi_read = pi_read;
	}
	public int getPi_good() {
		return pi_good;
	}
	public void setPi_good(int pi_good) {
		this.pi_good = pi_good;
	}

	public int getPi_stock() {
		return pi_stock;
	}
	public void setPi_stock(int pi_stock) {
		this.pi_stock = pi_stock;
	}
	public int getPi_sale() {
		return pi_sale;
	}
	public void setPi_sale(int pi_sale) {
		this.pi_sale = pi_sale;
	}

	public String getPcs_name() {
		return pcs_name;
	}

	public void setPcs_name(String pcs_name) {
		this.pcs_name = pcs_name;
	}
	
	
	
}
