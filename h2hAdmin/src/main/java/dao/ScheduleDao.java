package dao;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ScheduleDao {
	private JdbcTemplate jdbc;
	
	public ScheduleDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int scheduleInsert(ScheduleInfo si) {
		String sql = "INSERT INTO t_schedule_info (ai_id, si_date, si_time, si_content) VALUES " + 
				" ('" + si.getAi_id() + "', '" + si.getSi_date() + "', '" + si.getSi_time() + "', '" + si.getSi_content() + "')";
		int result = jdbc.update(sql);
		return result;
	}

	// 지정한 연월에 해당하는 일정들의 목록을 List<ScheduleInfo>로 리턴하는 메소드
	public List<ScheduleInfo> getScheduleList(String ai_id, int y, int m) {
		String sql = "SELECT * FROM t_schedule_info WHERE ai_id = '" + ai_id + "' AND si_date LIKE '" + y + "-"
				+ (m < 10 ? "0" + m : m) + "%' ORDER BY si_date, si_time";
		List<ScheduleInfo> scheduleList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ScheduleInfo si = new ScheduleInfo(rs.getInt("si_idx"), rs.getString("ai_id"), rs.getString("si_date"),
					rs.getString("si_time"), rs.getString("si_content"), rs.getString("si_regdate"));
			return si;
		});
		return scheduleList;
	}
}
