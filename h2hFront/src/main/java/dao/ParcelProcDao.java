package dao;

import java.util.*;
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

	public List<OrderProcInCtrl> getParcelList(String miid) {
		String sql = "select * from t_order_info where mi_id = '" + miid + "' ";
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
		String sql = "SELECT a.pi_name, a.pi_img1, a.pi_name, b.* FROM t_product_info a JOIN t_order_info b ON a.pi_id = b.pi_id " + 
				"WHERE b.pi_id = ? AND b.mi_id = ? AND b.oi_id = ? GROUP BY b.oi_id";
		
		List<ParcelInfo> results = jdbc.query(sql, new RowMapper<ParcelInfo>() {
			public ParcelInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				ParcelInfo pi = new ParcelInfo();
				pi.setMi_id(rs.getString("mi_id"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_name(rs.getString("pi_name"));
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
		}, pi_id, miid, oi_id);
		
		return results.isEmpty() ? null : results.get(0);
	}
}
	

