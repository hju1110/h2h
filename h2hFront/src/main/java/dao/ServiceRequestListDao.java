package dao;

import java.sql.ResultSet;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import vo.ServiceAcceptInfo;
import vo.ServiceMember;

public class ServiceRequestListDao {
	private JdbcTemplate jdbc;

	public ServiceRequestListDao (DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public int getServiceRequestListDao(String where) {
			String sql = "SELECT a.*, b.* FROM t_service_info a JOIN t_serviece_join b ON a.si_idx = b.si_idx " + where;
			System.out.println(sql);
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}

	public List<ServiceMember> getServiceRequestListInfo(String where, String miid, int cpage, int psize) {
		String sql = "SELECT a.si_acname, b.sj_name, b.sj_birth, b.sj_status FROM t_service_info a " + 
				" JOIN t_serviece_join b ON a.si_idx = b.si_idx WHERE b.mi_id = '" + miid + "' " + 
				"  ORDER BY b.sj_idx DESC LIMIT " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		
		List<ServiceMember> serviceRequestListInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceMember sj = new ServiceMember();
			sj.setSi_acname(rs.getString("si_acname"));
			
			return sj;
		});
		return serviceRequestListInfo;
		
	}
}