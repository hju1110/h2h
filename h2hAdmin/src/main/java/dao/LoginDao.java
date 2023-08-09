package dao;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class LoginDao {
	private JdbcTemplate jdbcTemplate;
	
	public LoginDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public AdminInfo getLoginInfo(String uid, String pwd) {
		String sql = "SELECT * FROM t_admin_info WHERE ai_id = ? AND ai_pw = ? ";
		
		List<AdminInfo> results = jdbcTemplate.query(sql, new RowMapper<AdminInfo>() {
			public AdminInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				AdminInfo ai = new AdminInfo();
				ai = new AdminInfo();
				ai.setAi_idx(rs.getInt("ai_idx"));
				ai.setAi_id(rs.getString("ai_id"));
				ai.setAi_pw(rs.getString("ai_pw"));
				ai.setAi_name(rs.getString("ai_name"));
				ai.setAi_use(rs.getString("ai_use"));
				ai.setAi_date(rs.getString("ai_date"));
				return ai;
			}
		}, uid, pwd);
		
		return results.isEmpty() ? null : results.get(0);	// 리스트가 비어있으면 null 리턴, 있으면 1개만 추출해오니까 0을 리턴
	}
}

