package dao;

import java.sql.*;
import javax.sql.*;
import java.util.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ServiceDao {
private JdbcTemplate jdbc;
	
	public ServiceDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getServiceInfoCount(String where) {
		// 검색된(검색어가 있을경우) 게시글의 총 개수를 리턴하는 메소드 여기서 작업
			String sql = "select count(*) from t_service_info " + where;
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}
	
	public List<ServiceInfo> getServiceInfo(String where, int cpage, int psize) {
		String sql = "select si_idx, si_view, CASE WHEN si_view = 'y' THEN '게시' WHEN si_view = 'n' THEN '미게시' ELSE '대기'  END AS si_is_view,si_title, si_person, si_acdate, si_place , "
				+ "if(curdate() = date(si_date), right(si_date, 8), mid(si_date, 3 , 8)) wdate from t_service_info " + where + " order by si_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		
		List<ServiceInfo> serviceInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceInfo si = new ServiceInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSi_person(rs.getInt("si_person"));
			si.setSi_acdate(rs.getString("si_acdate"));
			si.setSi_view(rs.getString("si_view"));
			si.setSi_is_view(rs.getString("si_is_view"));
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
		return serviceInfo;
	}
	
	public int readUpdate(int siidx) {
	// 지정한 게시글의 조회수를 1 증가시키는 메소드
		String sql = "update t_service_Info set si_read = si_read + 1 where si_idx = " + siidx;
		int result = jdbc.update(sql);
		return result;
	}

	public ServiceInfo getServiceList(int siidx) {
		int result = readUpdate(siidx);
		
		String sql = "select * from t_service_info where si_idx = " + siidx;
		
		ServiceInfo si = jdbc.queryForObject(sql, new RowMapper<ServiceInfo>() {
            @Override
            public ServiceInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
            	ServiceInfo si = new ServiceInfo();
            	si.setSi_idx(rs.getInt("si_idx"));
            	si.setSi_title(rs.getString("si_title"));
            	si.setSi_content(rs.getString("si_content"));
    			si.setSi_acname(rs.getString("si_acname"));
    			si.setSi_acdate(rs.getString("si_acdate"));
    			si.setSi_sdate(rs.getString("si_sdate"));
    			si.setSi_edate(rs.getString("si_edate"));
    			si.setSi_view(rs.getString("si_view"));
    			si.setSi_person(rs.getInt("si_person"));
    			si.setSi_origine(rs.getString("si_origine"));
    			si.setSi_name(rs.getString("si_name"));	
    			si.setSi_place(rs.getString("si_place"));
    			si.setSi_accept(rs.getString("si_accept"));
    			si.setSi_point(rs.getInt("si_point"));
    			si.setSi_type(rs.getString("si_type"));
    			si.setSi_read(rs.getInt("si_read"));
    			si.setSi_date(rs.getString("si_date"));
               
               return si;
            }
         });
		return si;
	}

	public int getAccept(int siidx) {
		String sql = "UPDATE t_service_info SET si_view = 'y' WHERE si_idx = " + siidx;
		int result = jdbc.update(sql);
		return result;
	}
}