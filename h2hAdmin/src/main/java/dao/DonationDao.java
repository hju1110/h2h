package dao;

import java.sql.*;
import javax.sql.*;
import java.util.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class DonationDao {
	private JdbcTemplate jdbc;
	
	public DonationDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getDonaMemListCount(String where) {
		String sql = "SELECT COUNT(*) FROM t_donation_info a, t_member_dona b " + where;
		//System.out.println(sql);
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	public List<DonationInfo> getDonaMemList(String where, int cpage, int psize) {
		String sql = "SELECT  a.di_sponsor, b.* FROM t_donation_info a, t_member_dona b " + where + 
			" ORDER BY b.md_sdate DESC limit " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		List<DonationInfo> results = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			DonationInfo dl = new DonationInfo();
			dl.setDi_sponsor(rs.getString("di_sponsor"));
			dl.setMd_idx(rs.getInt("md_idx"));
			dl.setDi_idx(rs.getInt("di_idx"));
			dl.setMd_id(rs.getString("md_id"));
			dl.setMd_name(rs.getString("md_name"));
			dl.setMd_type(rs.getString("md_type"));
			dl.setMd_ctgr(rs.getString("md_ctgr"));
			dl.setMd_price(rs.getInt("md_price"));
			dl.setMd_agree(rs.getString("md_agree"));
			dl.setMd_payment(rs.getString("md_payment"));
			dl.setMd_sdate(rs.getString("md_sdate"));
			dl.setMd_edate(rs.getString("md_edate"));
			dl.setMd_bnum(rs.getString("mi_bnum"));
			dl.setMd_gname(rs.getString("md_gname"));
			return dl;
		});
		return results;
	}

	public DonationInfo getDonaTotal() {
	    String sql = "select sum(di_rprice) rprice, sum(di_gprice) gprice from t_donation_info";
	    List<DonationInfo> results = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			DonationInfo di = new DonationInfo();
			di.setDi_gprice(rs.getInt("gprice"));
			di.setDi_rprice(rs.getInt("rprice"));
			return di;
		});
	    
	    return results.isEmpty() ? null : results.get(0);
	}

	public String getDonaTotalPrice(String where) {
		String sql = "SELECT SUM(b.md_price) price FROM t_donation_info a, t_member_dona b ";
		if (where != null && !where.trim().isEmpty()) {
	        sql += where;
	    }
	//	System.out.println(sql);
		String total = jdbc.queryForObject(sql, String.class);
		return total;
	}
	
	public List<DonationInfo> getDonaStatistics() {
		String sql = "SELECT 'x', 'x', SUM(di_rprice) rprice, SUM(di_gprice) gprice " + 
				" FROM t_donation_info UNION SELECT di_sponsor, di_name, di_gprice, di_rprice FROM t_donation_info";
	    List<DonationInfo> results = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			DonationInfo di = new DonationInfo();
			di.setDi_sponsor(rs.getString(1));
			di.setDi_name(rs.getString(2));
			di.setDi_gprice(rs.getInt(3));
			di.setDi_rprice(rs.getInt(4));
			return di;
		});	    
	    return results;
	}
}
