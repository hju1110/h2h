package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class ProductProcDao {
	private JdbcTemplate jdbc;
	
	public ProductProcDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	
	public int getProductCount(String where) {
		String sql = "select count(*) from t_product_info a where a.pi_isview = 'y'";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}


	public List<ProductInfo> getProductList(int cpage, int psize) {
	    String sql = "select * from t_product_info where pi_isview = 'y' and pi_stock > 0" + 
	    		 " limit " + ((cpage - 1) * psize) + ", " + psize;	
	    //System.out.println(sql);
	    List<ProductInfo> productList = (List<ProductInfo>) jdbc.query(sql, 
	        (ResultSet rs, int rowNum) -> {
	            ProductInfo pi = new ProductInfo(
	                rs.getString("pi_id"), 		rs.getString("pcs_id"), 
	                rs.getString("pi_name"), 	
	                rs.getString("pi_img1"),	rs.getString("pi_img2"),
	                rs.getString("pi_img3"), 	rs.getString("pi_desc"), 	
	                rs.getString("pi_size"), 	rs.getString("pi_isview"), 
	                rs.getString("pi_date"), 	rs.getString("pi_last"), 
	                rs.getInt("pi_price"),		rs.getInt("pi_read"),
	                rs.getInt("pi_good"),		
	                rs.getInt("pi_stock"),		rs.getInt("pi_sale"));
	            return pi;
	    });

	    return productList;
	}


	public int readUpdate(String piid) {
		String sql = "update t_product_info set pi_read = pi_read + 1 where pi_isview = 'y' and pi_id = '" + piid +"' ";
		int result = jdbc.update(sql);
		return result;
	}


	public ProductInfo getProductInfo(String piid) {
	    String sql = "select a.*, b.pcs_name from t_product_info a, t_product_ctgr_small b where a.pcs_id = b.pcs_id and a.pi_isview = 'y' and a.pi_id = ?";

	    List<ProductInfo> results = jdbc.query(sql, new RowMapper<ProductInfo>() {
	        public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
	            // Use the second constructor to create a new ProductInfo object
	            ProductInfo pi = new ProductInfo(
                    rs.getString("pi_id"),
                    rs.getString("pcs_id"),
                    rs.getString("pi_name"),
                    rs.getInt("pi_price"),
                    rs.getString("pi_img1"),
                    rs.getString("pi_img2"),
                    rs.getString("pi_img3"),
                    rs.getString("pi_desc"),
                    rs.getInt("pi_read"),
                    rs.getInt("pi_sale"),
                    rs.getString("pi_isview"),
                    rs.getString("pi_date"),
                    rs.getString("pi_last"),
                    rs.getString("pcs_name"),
                    rs.getInt("pi_stock"),
                    rs.getInt("pi_good"),
                    rs.getString("pi_size")
	            );
	            return pi;
	        }
	    }, piid);

	    return results.isEmpty() ? null : results.get(0);
	}


	public int productInsert(ProductInfo pi) {
		String sql = "insert into t_product_info (pi_id, pcs_id, pi_name, pi_price, pi_img1, pi_img2, pi_img3, pi_desc, pi_stock, pi_isview) " + 
		" values ('" + pi.getPi_id() + "', '" + pi.getPcs_id() + "', '" + pi.getPi_name() + "', '" + pi.getPi_price() + "', " +
		" '" + pi.getPi_img1() + "','" + pi.getPi_img2() + "','" + pi.getPi_img3() + "','" + pi.getPi_desc() + "', '" + pi.getPi_stock() + "',  'y')";			
		int result = jdbc.update(sql);	
		return result;
	}


	public List<ProductInfo> getProductList1(int cpage, int psize) {
	    String sql = "select * from t_product_info where pi_isview = 'y' and pi_stock <= 0" + 
	    		 " limit " + ((cpage - 1) * psize) + ", " + psize;	
	    //System.out.println(sql);
	    List<ProductInfo> productList = (List<ProductInfo>) jdbc.query(sql, 
	        (ResultSet rs, int rowNum) -> {
	            ProductInfo pi = new ProductInfo(
	                rs.getString("pi_id"), 		rs.getString("pcs_id"), 
	                rs.getString("pi_name"), 	
	                rs.getString("pi_img1"),	rs.getString("pi_img2"),
	                rs.getString("pi_img3"), 	rs.getString("pi_desc"), 	
	                rs.getString("pi_size"), 	rs.getString("pi_isview"), 
	                rs.getString("pi_date"), 	rs.getString("pi_last"), 
	                rs.getInt("pi_price"),		rs.getInt("pi_read"),
	                rs.getInt("pi_good"),		
	                rs.getInt("pi_stock"),		rs.getInt("pi_sale"));
	            return pi;
	    });
	    
	    return productList;
	}


	public ProductInfo productUp(String pi_id) {
		 String sql = "select a.*, b.pcs_name from t_product_info a, t_product_ctgr_small b where a.pcs_id = b.pcs_id and a.pi_isview = 'y' and a.pi_id = ?";
		 List<ProductInfo> results = jdbc.query(sql, new RowMapper<ProductInfo>() {
	        public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
	            // Use the second constructor to create a new ProductInfo object
	            ProductInfo pi = new ProductInfo(
                    rs.getString("pi_id"),
                    rs.getString("pcs_id"),
                    rs.getString("pi_name"),
                    rs.getInt("pi_price"),
                    rs.getString("pi_img1"),
                    rs.getString("pi_img2"),
                    rs.getString("pi_img3"),
                    rs.getString("pi_desc"),
                    rs.getInt("pi_read"),
                    rs.getInt("pi_sale"),
                    rs.getString("pi_isview"),
                    rs.getString("pi_date"),
                    rs.getString("pi_last"),
                    rs.getString("pcs_name"),
                    rs.getInt("pi_stock"),
                    rs.getInt("pi_good"),
                    rs.getString("pi_size")
	            );
	            return pi;
	        }
	    }, pi_id);
	    return results.isEmpty() ? null : results.get(0);
	}


	public int productUpdate(ProductInfo pi) {
		String sql = "update t_product_info set pcs_id = '" + pi.getPcs_id() + "', " + 
		"pi_name = '" + pi.getPi_name() + "', pi_price = '" + pi.getPi_price() + "', pi_img1 = '" + pi.getPi_img1()  + "'," + 
		"  pi_img2 = '" + pi.getPi_img2() + "',  pi_img3 = '" + pi.getPi_img3() + "', pi_desc = '" + pi.getPi_desc() + "'," + 
		" pi_stock = '" + pi.getPi_stock() + "' where pi_id = '" + pi.getPi_id() + "' ";
		//System.out.println(sql);
		int result = jdbc.update(sql);	
		return result;
	
	}
}

