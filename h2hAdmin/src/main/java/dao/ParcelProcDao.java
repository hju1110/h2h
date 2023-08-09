package dao;

import java.util.*;
import java.io.PrintWriter;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class ParcelProcDao {
	private JdbcTemplate jdbc;
	
	public ParcelProcDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getParcelListCount(String where) {
		String sql = "select count(*) from t_order_info " + where;
		//System.out.println(sql);
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	public List<OrderProcInCtrl> getParcelList(String where, int cpage, int psize, String miid) {
		String sql = "select * from t_order_info " + where;
		//System.out.println(sql);
		List<OrderProcInCtrl> parcelList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
				OrderProcInCtrl op = new OrderProcInCtrl(
				rs.getString("oi_id"),	rs.getString("mi_id"),	rs.getString("pi_id"), rs.getString("oi_name"),	rs.getString("oi_phone"),
				rs.getString("oi_zip"),	rs.getString("oi_addr1"),	rs.getString("oi_addr2"),rs.getString("oi_memo"),
				rs.getString("oi_invoice"),	rs.getString("oi_status"), 	rs.getString("oi_date"), rs.getInt("oi_pay"),
				rs.getInt("oi_upoint"));
				return op;
			});
		
		return parcelList;
	}

	public ParcelInfo getParcelView(String miid, String pi_id, String oi_id) {
		String sql = "SELECT a.pi_name, a.pi_img1, b.* FROM t_product_info a JOIN t_order_info b ON a.pi_id = b.pi_id " + 
				"WHERE b.pi_id = ? AND b.oi_id = ? GROUP BY b.oi_id";
		System.out.println(sql);
		List<ParcelInfo> results = jdbc.query(sql, new RowMapper<ParcelInfo>() {
			public ParcelInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				ParcelInfo pi = new ParcelInfo();
				pi.setMi_id(rs.getString("mi_id"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setOi_id(rs.getString("oi_id"));
				pi.setMi_id(rs.getString("mi_id"));
				pi.setPi_id(rs.getString("pi_id"));
				pi.setOi_name(rs.getString("oi_name"));
				pi.setOi_phone(rs.getString("oi_phone"));
				pi.setOi_zip(rs.getString("oi_zip"));
				pi.setOi_addr1(rs.getString("oi_addr1"));
				pi.setOi_addr2(rs.getString("oi_addr2"));
				pi.setOi_memo(rs.getString("oi_memo"));
				pi.setOi_pay(rs.getInt("oi_pay"));
				pi.setOi_upoint(rs.getInt("oi_upoint"));
				pi.setOi_invoice(rs.getString("oi_invoice"));
				pi.setOi_status(rs.getString("oi_status"));
				pi.setOi_date(rs.getString("oi_date"));
				return pi;
			}
		}, pi_id, oi_id);
		
		return results.isEmpty() ? null : results.get(0);
	}

	public int orderProcUp(ParcelInfo pi) {
		String sql = "update t_order_info set oi_name = '" + pi.getOi_name() + "' , oi_phone = '" + pi.getOi_phone() + "'," +
	" oi_zip = '" + pi.getOi_zip() + "', oi_addr1 = '" + pi.getOi_addr1() + "', oi_addr2 = '" + pi.getOi_addr2() + "', " +
	" oi_memo = '" + pi.getOi_memo() + "' where mi_id = '" + pi.getMi_id() + "' and oi_id = '" + pi.getOi_id() + "' ";
		int result = jdbc.update(sql);

		return result;
	}

	public int orderProcB(String oi_id, String mi_id, String oi_status) {
		String sql = "update t_order_info set oi_status = 'b' where oi_id = '" + oi_id + "' ";
		
		int result = jdbc.update(sql);		
		return result;
	}

	public int orderProcC(String oi_id, String mi_id, String oi_status) {
		String sql = "update t_order_info set oi_status = 'c' where oi_id = '" + oi_id + "' ";
		
		int result = jdbc.update(sql);		
		return result;
	}

	public int orderProcD(String oi_id, String mi_id, String pi_id, int oi_pay) {
	String sql = "update t_order_info set oi_status = 'd' where oi_id = '" + oi_id + "' ";	
		int result = jdbc.update(sql);		
		
		sql = "update t_member_info set mi_point = mi_point + '" + oi_pay + "' where mi_id = '"	+ mi_id	+ "' ";
		result += jdbc.update(sql);
		//System.out.println(sql);
		
		sql = "UPDATE t_product_info SET pi_stock = pi_stock + 1, pi_sale = pi_sale - 1 WHERE pi_id = '" + pi_id + "' ";
		result += jdbc.update(sql);
		//System.out.println(sql);
		
		sql = "insert into t_member_point values (null, ?, 's', +?, '구매취소', '', now(), 0)";
		result += jdbc.update(sql, mi_id, oi_pay);
		
		return result;
	}



	
}
	

