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
	
	public int getDonaMemListCount(String miid) {
		String sql = "SELECT COUNT(*) FROM t_donation_info a, t_member_dona b WHERE a.di_idx = b.di_idx and b.md_id = '" + miid + "' ";
		System.out.println(sql);
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	public List<DonationInfo> getDonaMemList(String miid) {
		String sql = "SELECT  a.di_sponsor, b.* FROM t_donation_info a, t_member_dona b where b.md_id = '" + miid + "'  and a.di_idx = b.di_idx  ORDER BY b.md_sdate DESC";
		//System.out.println(sql);
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


	public String getDonaTotalPrice(String where) {
		String sql = "SELECT SUM(b.md_price) price FROM t_donation_info a, t_member_dona b ";
		if (where != null && !where.trim().isEmpty()) {
	        sql += where;
	    }
		//System.out.println(sql);
		String total = jdbc.queryForObject(sql, String.class);
		return total;
	}

	public int donaDel(String miid, int di_idx, int md_idx, int md_price) {
		String sql = "update t_member_dona set md_ctgr = 'c', md_price  = 0, md_edate = now() where md_id = '" + miid + "' " +
		" and md_ctgr = 'b' and md_idx = '" + md_idx + "' ";	
		int result = jdbc.update(sql);		
		
		sql = "update t_donation_info set di_rprice = di_rprice - '" + md_price + "' where di_idx = '" + di_idx +"' ";
		result += jdbc.update(sql);
		return result;
	}

	public int getDonaMemInfo(MemberInfo mi) {
		String sql = "SELECT mi_name, mi_birth, mi_phone, " + 
				" mi_type, CASE WHEN mi_type <> 'a' THEN mi_gname ELSE NULL END AS mi_gname FROM t_member_info";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public int donaInsert(MemberInfo mi, DonationInfo di) {
		String sql = "INSERT INTO t_member_dona (di_idx, md_id, md_name, md_type, md_ctgr, md_sponsor, md_price " + 
				" , md_payment, mi_bnum, md_gname) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int result = jdbc.update(sql, di.getDi_idx(),mi.getMi_id(), di.getMd_name(), di.getMd_type(), di.getMd_ctgr(), 
				di.getMd_sponsor().substring(0,1), di.getMd_price(), di.getMd_payment(), mi.getMi_bnum(), mi.getMi_gname());
		System.out.println(sql);
		
		sql = "UPDATE t_member_dona SET mi_bnum = (SELECT mi_bnum FROM t_member_info WHERE mi_id = '" + mi.getMi_id() + "'), " + 
				" md_gname = (SELECT mi_gname FROM t_member_info WHERE mi_id = '" + mi.getMi_id() + "') " + 
				" WHERE md_type = '" + di.getMd_type() + "' ";
		System.out.println(sql);
		result += jdbc.update(sql);
		
		String sql2 = "";
		if (di.getMd_ctgr().equals("a")) {
			sql2 = "UPDATE t_donation_info SET di_gprice = di_gprice + " + di.getMd_price() + " WHERE di_sponsor = '" + di.getMd_sponsor().substring(0,1) + "' ";
		} else {
			sql2 = "UPDATE t_donation_info SET di_rprice = di_rprice + " + di.getMd_price() + " WHERE di_sponsor = '" + di.getMd_sponsor().substring(0,1) + "' ";
		}
		
		System.out.println(sql2);
		result += jdbc.update(sql2);
		
		return result;
	}
}
