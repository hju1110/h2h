package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.MemberManagementInfo;

public class MemberInfoDao {
	private JdbcTemplate jdbc;
	
	public MemberInfoDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberManagementInfo> getMemberManagementInfo(String where, int cpage, int psize) {
		String sql = "SELECT mi_id, mi_name, mi_birth, mi_phone, mi_email, mi_gname, mi_type, mi_bnum, IF(CURDATE() = DATE(mi_date), RIGHT(mi_date, 8), MID(mi_date, 3, 8)) wdate FROM t_member_info " + where + " ORDER BY mi_date DESC LIMIT " + ((cpage - 1) * psize) + ", " + psize;
		// System.out.println(sql);
		List<MemberManagementInfo> memberManagementInfo = jdbc.query(sql,
			(ResultSet rs, int rowNum) -> {
			MemberManagementInfo mi = new MemberManagementInfo();
			mi.setMi_id(rs.getString("mi_id"));
			mi.setMi_name(rs.getString("mi_name"));
			mi.setMi_phone(rs.getString("mi_phone"));
			mi.setMi_email(rs.getString("mi_email"));
			mi.setMi_gname(rs.getString("mi_gname"));
			mi.setMi_type(rs.getString("mi_type"));
			mi.setMi_bnum(rs.getString("mi_bnum"));
			mi.setMi_birth(rs.getString("mi_birth"));
			mi.setMi_date(rs.getString("wdate"));
			
			return mi;
		});
		
		return memberManagementInfo;
	}

	public int getMemberListCount(String where) {
		String sql = "SELECT COUNT(*) FROM t_member_info " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		
		return rcnt;
	}

}
