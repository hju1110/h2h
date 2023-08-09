package dao;

import javax.sql.*;
import org.springframework.dao.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;
	
	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int memberInsert(MemberInfo mi) {
		String sql = "";
		int result = 0;
		
		if (mi.getMi_type().equals("a")) {
			sql = "INSERT INTO t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			result = jdbc.update(sql, mi.getMi_id(), mi.getMi_pw(), mi.getMi_name(), mi.getMi_gender(), mi.getMi_birth(), mi.getMi_phone(), mi.getMi_email(), mi.getMi_type());
		} else if (mi.getMi_type().equals("b")) {
			sql = "INSERT INTO t_member_info (mi_id, mi_bnum, mi_pw, mi_name, mi_phone, mi_email, mi_type, mi_gname) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			result = jdbc.update(sql, mi.getMi_id(), mi.getMi_bnum(), mi.getMi_pw(), mi.getMi_name(), mi.getMi_phone(), mi.getMi_email(), mi.getMi_type(), mi.getMi_gname());
		} else if (mi.getMi_type().equals("c")) {
			sql = "INSERT INTO t_member_info (mi_id, mi_pw, mi_name, mi_phone, mi_email, mi_type, mi_gname) VALUES (?, ?, ?, ?, ?, ?, ?)";
			result = jdbc.update(sql, mi.getMi_id(), mi.getMi_pw(), mi.getMi_name(), mi.getMi_phone(), mi.getMi_email(), mi.getMi_type(), mi.getMi_gname());
		}
		
		return result;
	}

	public int chkDupEmail(String email) {
		String sql = "SELECT COUNT(*) FROM t_member_info WHERE mi_email = '" + email + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		
		return result;
	}

	public int memberAddrInsert(MemberAddr2 ma) {
		String sql = "INSERT INTO t_member_addr (mi_id, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2) VALUES ('" + ma.getMi_id() + "', '" + ma.getMa_name() + "', '" + ma.getMa_rname() + "', '" + ma.getMa_phone() + "', '" + ma.getMa_zip() + "', '" + ma.getMa_addr1() + "', '" + ma.getMa_addr2() + "')";
		int result = jdbc.update(sql);
		
		return result;
	}

	public String findId(String name, String email) {
		String result;
		String sql = "SELECT mi_id FROM t_member_info WHERE mi_name = '" + name + "' AND mi_email = '" + email + "' ";
		try {
			result = jdbc.queryForObject(sql, String.class);
		} catch (IncorrectResultSizeDataAccessException e) {
			return null;
		}
	
		return result;
	}

	public int findPw(String id, String name, String email) {
		int result;
		String sql = "SELECT COUNT(*) FROM t_member_info WHERE mi_name = '" + name + "' AND mi_email = '" + email + "' AND mi_id = '" + id + "' ";
		try {
			result = jdbc.queryForObject(sql, Integer.class);
		} catch (IncorrectResultSizeDataAccessException e) {
			return 0;
		}

		return result;
	}

	public int findPw(String id, String pw) {
		String sql = "UPDATE t_member_info SET mi_pw = '" + pw + "' WHERE mi_id = '" + id + "' ";
		// System.out.println(sql);
		int result = jdbc.update(sql);
		
		return result;
	}

	public int chkPw(String id, String pw) {
		String sql = "SELECT COUNT(*) FROM t_member_info WHERE mi_id = '" + id + "' AND mi_pw = '" + pw + "'";
		// System.out.println(sql);
		int result = jdbc.queryForObject(sql, Integer.class);
		
		return result;
	}

	public int chgMemberInfo(MemberInfo mi) {
		String sql = "";
		
		if (mi.getMi_type().equals("a")) {
			sql = "UPDATE t_member_info SET mi_phone = '" + mi.getMi_phone() + "', mi_email = '" + mi.getMi_email() + "' WHERE mi_id = '" + mi.getMi_id() + "'";
		} else {
			sql = "UPDATE t_member_info SET mi_phone = '" + mi.getMi_phone() + "', mi_email = '" + mi.getMi_email() + "', mi_name = '" + mi.getMi_name() + "' WHERE mi_id = '" + mi.getMi_id() + "' ";
		}
		
		int result = jdbc.update(sql);
		
		return result;
	}

}
