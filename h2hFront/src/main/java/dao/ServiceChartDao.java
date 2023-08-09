package dao;

import java.sql.*;
import javax.sql.*;
import java.util.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ServiceChartDao {
	private JdbcTemplate jdbc;
		
	public ServiceChartDao (DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getServiceChartInfoCount(String where) {
		// 검색된(검색어가 있을경우) 게시글의 총 개수를 리턴하는 메소드 여기서 작업
			String sql = "select count(*) from t_service_info " + where;
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}

	public List<ServiceChartInfo> getServiceChartInfo(String where, int cpage, int psize) {
		String sql = "select si_idx, si_recruit, CASE WHEN si_recruit = 'y' THEN '모집' WHEN si_recruit = 'n' THEN '모집종료' ELSE '대기'  END AS si_is_recruit,si_title, si_person, si_acdate, si_place , "
				+ "if(curdate() = date(si_date), right(si_date, 8), mid(si_date, 3 , 8)) wdate from t_service_info " + where + " order by si_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		
		List<ServiceChartInfo> serviceChartInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceChartInfo si = new ServiceChartInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSi_person(rs.getInt("si_person"));
			si.setSi_acdate(rs.getString("si_acdate"));
			si.setSi_recruit(rs.getString("si_recruit"));
			si.setSi_is_recruit(rs.getString("si_is_recruit"));
			si.setSi_title(rs.getString("si_title"));
			si.setSi_place(rs.getString("si_place"));
			si.setSi_date(rs.getString("wdate").replace("-", "."));
			String title = "";	int cnt = 30;
			if (rs.getString("si_title").length() > cnt)
				title = rs.getString("si_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("si_title") + title;	
			si.setSi_title(title);
			return si;
		});
		return serviceChartInfo;
	}
}
