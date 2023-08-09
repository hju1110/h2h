package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;


public class OrderProcDao {
	private JdbcTemplate jdbc;
	
	public OrderProcDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<OrderCart> getBuyList(String string) {
		String sql = string;
		//System.out.println(sql);
		List<OrderCart> pdtList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
				OrderCart oc = new OrderCart(
				rs.getString("pi_name"), rs.getString("pi_img1"),
				rs.getInt("pi_price"),   rs.getString("pi_size"),
				rs.getInt("pi_stock"),	 rs.getInt("cnt"));
				return oc;
			});
		
		return pdtList;
	}

	public List<MemberAddr> getAddrList(String miid) {
		String sql = "select a.mi_name, a.mi_email, a.mi_phone, b.* from t_member_info a, t_member_addr b " + 
				" where a.mi_id = b.mi_id and b.mi_id = '" + miid + "' order by ma_basic desc";
		//System.out.println(sql);
		List<MemberAddr> addrList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
				MemberAddr ar = new MemberAddr(
				rs.getInt("ma_idx"), rs.getString("mi_id"), rs.getString("mi_name"), rs.getString("mi_email"),  
				rs.getString("mi_phone"), rs.getString("ma_name"),  rs.getString("ma_rname"),  rs.getString("ma_phone"), 
				rs.getString("ma_zip"), rs.getString("ma_addr1"), rs.getString("ma_addr2"), rs.getString("ma_basic"),
				rs.getString("ma_date"));
				return ar;
			});

		return addrList;
	}

	public int orderProcIn(OrderProcInCtrl oi, String pi_id) {
		String sql = "insert into t_order_info values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'a', now())";
	
			int result = jdbc.update(sql, oi.getOi_id(), oi.getMi_id(), oi.getPi_id(),oi.getOi_name(),oi.getOi_phone(), oi.getOi_zip(), 
			oi.getOi_addr1(), oi.getOi_addr2(),oi.getOi_memo(), oi.getOi_pay(), oi.getOi_upoint(), oi.getOi_invoice());
			//System.out.println(sql);
			
			sql = "update t_member_info set mi_point = mi_point - '" + oi.getOi_upoint() + "' where mi_id = '"	+ oi.getMi_id()		+ "' ";
			result += jdbc.update(sql);
			//System.out.println(sql);
			
			sql = "UPDATE t_product_info SET pi_stock = pi_stock - 1 WHERE pi_id = '" + pi_id + "' ";
			result += jdbc.update(sql);
			//System.out.println(sql);
			
			sql = "insert into t_member_point values (null, ?, 'u', ?, '상품구매', '', now(), 0)";
			result += jdbc.update(sql, oi.getMi_id(), oi.getOi_upoint());
			//System.out.println(sql);
			
			return result;
	}
}
