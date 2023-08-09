package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.MemberInfo;

public class LoginDao {
	private JdbcTemplate jdbcTemplate;
	
	public LoginDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public MemberInfo getLoginInfo(String uid, String pwd) {
		String sql = "SELECT * FROM t_member_info WHERE mi_id = ? AND mi_pw = ? ";
		
		List<MemberInfo> results = jdbcTemplate.query(sql, new RowMapper<MemberInfo>() {
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_pw(rs.getString("mi_pw"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_bnum(rs.getString("mi_bnum"));
				mi.setMi_gender(rs.getString("mi_gender"));
				mi.setMi_birth(rs.getString("mi_birth"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_email(rs.getString("mi_email"));
				mi.setMi_point(rs.getInt("mi_point"));
				mi.setMi_status(rs.getString("mi_status"));
				mi.setMi_date(rs.getString("mi_date"));
				mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
				mi.setMi_type(rs.getString("mi_type"));
				mi.setMi_gname(rs.getString("mi_gname"));
				return mi;
			}
		}, uid, pwd);
		
		return results.isEmpty() ? null : results.get(0);	// 리스트가 비어있으면 null 리턴, 있으면 1개만 추출해오니까 0을 리턴
	}
}

