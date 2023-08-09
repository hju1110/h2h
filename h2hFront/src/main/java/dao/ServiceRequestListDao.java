package dao;

import java.sql.ResultSet;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import vo.ServiceAcceptInfo;
import vo.ServiceRequestListInfo;

public class ServiceRequestListDao {
	private JdbcTemplate jdbc;

	public ServiceRequestListDao (DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getServiceRequestListDao(String where) {
		// 검색된(검색어가 있을경우) 게시글의 총 개수를 리턴하는 메소드 여기서 작업
			String sql = "select count(*) from t_service_info " + where;
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}

	public List<ServiceRequestListInfo> getServiceRequestListInfo(String where, int cpage, int psize) {
		String sql = "SELECT a.si_acname, b.ms_sdate, a.si_acdate FROM t_service_info a, t_member_service b";
		//System.out.println(sql);
		
		List<ServiceRequestListInfo> serviceRequestListInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceRequestListInfo sc = new ServiceRequestListInfo();
			sc.setSi_acname(rs.getString("si_acname"));
			sc.setMs_sdate(rs.getString("ms_sdate"));
			sc.setSi_acdate(rs.getString("si_acdate"));
		
			return sc;
		});
		return serviceRequestListInfo;
		
	}
}