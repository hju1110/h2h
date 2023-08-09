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

	public List<ServiceRequestListInfo> getServiceRequestListInfo(String where, String miid, int cpage, int psize) {
		String sql = "SELECT a.si_acname, b.sj_name, b.sj_birth, b.sj_status FROM t_service_info a " + 
				" JOIN t_serviece_join b ON a.si_idx = b.si_idx WHERE b.mi_id = '" + miid + "'";
		System.out.println(sql);
		
		List<ServiceRequestListInfo> serviceRequestListInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceRequestListInfo sj = new ServiceRequestListInfo();
			sj.setSi_acname(rs.getString("si_acname"));
			sj.setSj_name(rs.getString("sj_name"));
			sj.setSj_birth(rs.getString("sj_birth"));
			sj.setSj_status(rs.getString("sj_status"));
			
			return sj;
		});
		return serviceRequestListInfo;
		
	}
}