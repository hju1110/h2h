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
		String sql = "SELECT * FROM t_admin_info WHERE ai_id = ? AND ai_pw = ? ";
		
		List<MemberInfo> results = jdbcTemplate.query(sql, new RowMapper<MemberInfo>() {
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi = new MemberInfo();
				mi.setAi_idx(rs.getInt("ai_idx"));
				mi.setAi_id(rs.getString("ai_id"));
				mi.setAi_pw(rs.getString("ai_pw"));
				mi.setAi_name(rs.getString("ai_name"));
				mi.setAi_use(rs.getString("ai_use"));
				mi.setAi_date(rs.getString("ai_date"));
				return mi;
			}
		}, uid, pwd);
		
		return results.isEmpty() ? null : results.get(0);	// 리스트가 비어있으면 null 리턴, 있으면 1개만 추출해오니까 0을 리턴
	}
}

