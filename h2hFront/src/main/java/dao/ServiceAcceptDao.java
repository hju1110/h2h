package dao;

import java.sql.*;
import javax.sql.*;
import java.util.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ServiceAcceptDao {
	private JdbcTemplate jdbc;
	
	public ServiceAcceptDao (DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getServiceAcceptInfoCount(String where) {
		// 검색된(검색어가 있을경우) 게시글의 총 개수를 리턴하는 메소드 여기서 작업
			String sql = "select count(*) from t_service_info " + where;
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}

	public List<ServiceAcceptInfo> getServiceAcceptInfo(String where, int cpage, int psize) {
		String sql = "select si_idx, si_accept, CASE WHEN si_accept = 'y' THEN '참여승인' WHEN si_accept = 'n' THEN '참여 미승인' ELSE '대기'  END AS si_is_accept, si_title, si_person, si_acdate, si_place , "
				+ "if(curdate() = date(si_date), right(si_date, 8), mid(si_date, 3 , 8)) wdate from t_service_info " + where + " order by si_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		//System.out.println(sql);
		
		List<ServiceAcceptInfo> serviceAcceptInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceAcceptInfo sc = new ServiceAcceptInfo();
			sc.setSi_idx(rs.getInt("si_idx"));
			sc.setSi_person(rs.getInt("si_person"));
			sc.setSi_acdate(rs.getString("si_acdate"));
			sc.setSi_accept(rs.getString("si_accept"));
			sc.setSi_is_accept(rs.getString("si_is_accept"));
			sc.setSi_title(rs.getString("si_title"));
			sc.setSi_place(rs.getString("si_place"));
			sc.setSi_date(rs.getString("wdate").replace("-", "."));
			String title = "";	int cnt = 30;
			if (rs.getString("si_title").length() > cnt)
				title = rs.getString("si_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("si_title") + title;	
			sc.setSi_title(title);
			return sc;
		});
		return serviceAcceptInfo;
		
	}

		public List<ServiceAcceptInfo> getServiceAccept(int siidx) {
		String sql = "select a.mi_name, a.mi_birth, b.si_accept, b.si_point " + 
		" from t_member_info a, t_service_info b where b.si_idx = " + siidx;
		System.out.println(sql);
	
		List<ServiceAcceptInfo> scList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceAcceptInfo sc = new ServiceAcceptInfo();
			sc.setSi_idx(siidx);
			sc.setMi_name(rs.getString("mi_name"));
			sc.setMi_birth(rs.getString("mi_birth"));
			sc.setSi_accept(rs.getString("si_accept"));
			sc.setSi_point(rs.getInt("si_point"));
			return sc;
		});
		return scList;
	}
}
