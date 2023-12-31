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
//			System.out.println(sql);
			int rcnt = jdbc.queryForObject(sql, Integer.class);	// 레코드가 하나일 때 queryForObject 사용
		return rcnt;
	}
	
	// 참여 눌렀을 때 보이는 봉사 등록된 리스트
	public List<ServiceInfo> getServiceInfo(String where, int cpage, int psize) {
		String sql = "SELECT si_idx, si_acname, si_acdate, si_sdate, si_edate, si_person, si_recruit, si_date " + 
				" FROM t_service_info "	+ where + " AND si_accept = 'y' ORDER BY si_idx DESC LIMIT " + ((cpage - 1) * psize) + ", " + psize;
//		System.out.println(sql);
		
		List<ServiceInfo> serviceInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceInfo si = new ServiceInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSi_acname(rs.getString("si_acname"));
			si.setSi_acdate(rs.getString("si_acdate").replace("-", "."));
			si.setSi_sdate(rs.getString("si_sdate").replace("-", "."));
			si.setSi_edate(rs.getString("si_edate").replace("-", "."));
			si.setSi_person(rs.getInt("si_person"));
			si.setSi_recruit(rs.getString("si_recruit"));
			si.setSi_date(rs.getString("si_date").replace("-", "."));
			return si;
		});
		return serviceInfo;
	}
	
	public int readUpdate(int siidx) {
	// 지정한 게시글의 조회수를 1 증가시키는 메소드
		String sql = "update t_service_Info set si_read = si_read + 1 where si_idx = " + siidx;
//		System.out.println(sql);
		int result = jdbc.update(sql);
		return result;
	}

	// 봉사 게시글 상세
	public ServiceInfo getServiceList(int siidx) {
		int result = readUpdate(siidx);
		
		String sql = "SELECT si_idx, si_acname, si_acdate, si_edate, si_person, si_content, si_point, si_recruit, " + 
				" IF(si_type = 'a', '청소년', '성인') sitype FROM t_service_info WHERE si_view = 'y' AND si_idx = " + siidx;
//		System.out.println(sql);
	
		ServiceInfo si = jdbc.queryForObject(sql, new RowMapper<ServiceInfo>() {
            @Override
            public ServiceInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
            	ServiceInfo si = new ServiceInfo();
            	si.setSi_idx(rs.getInt("si_idx"));
            	si.setSi_acname(rs.getString("si_acname"));
    			si.setSi_acdate(rs.getString("si_acdate").replace("-", "."));
    			si.setSi_edate(rs.getString("si_edate").replace("-", "."));
    			si.setSi_recruit(rs.getString("si_recruit"));
    			si.setSi_person(rs.getInt("si_person"));
            	si.setSi_content(rs.getString("si_content"));
            	si.setSi_point(rs.getInt("si_point"));
    			si.setSi_type(rs.getString("sitype"));
    			               
               return si;
            }
         });
		return si;
	}

	// 봉사 참여 신청 Insert문
	public int setFinish(ServiceMember sm) {
		String sql = "INSERT INTO t_service_join VALUES (NULL, ?, ?, ?, 'g', 0, 'n', NOW())";
		int result = jdbc.update(sql, sm.getSi_idx(), sm.getMi_id(), sm.getSi_acname());
		
		sql = "UPDATE t_service_info SET si_cnt = si_cnt + 1 WHERE si_idx = " + sm.getSi_idx();
		result += jdbc.update(sql);
		
		return result;
	}

	// 봉사 등록 Insert문
	public int setSvcProcIn(ServiceInfo si) {
		String sql = "INSERT INTO t_service_info (si_acname, si_acdate, si_sdate, si_edate, si_person, si_content, " + 
				" si_point, si_type) VALUES (?, ?, ?, ?, ?, ?, 2000, ?)";
		int result = jdbc.update(sql, si.getSi_acname(), si.getSi_acdate(), si.getSi_sdate(), si.getSi_edate(),
				si.getSi_person(), si.getSi_content(), si.getSi_type());
		return result;
	}

	// 나의 봉사 현황 목록 개수
	public int getServiceListCount(String where) {
		String sql = "SELECT COUNT(*) FROM t_service_info a, t_service_join b " + where + " AND a.si_idx = b.si_idx ";
		System.out.println(sql);
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	// 나의 봉사 현황 목록
	public List<ServiceInfo> getServiceMemList(int cpage, int psize, String where) {
		String sql = "SELECT a.si_idx, a.si_acname, a.si_acdate, a.si_recruit, b.sj_idx, b.sj_status, b.sj_date " + 
				" FROM t_service_info a, t_service_join b " + where + " AND a.si_idx = b.si_idx " + 
				" ORDER BY b.sj_date DESC LIMIT " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		List<ServiceInfo> results = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceInfo si = new ServiceInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSj_idx(rs.getInt("sj_idx"));
			si.setSi_acname(rs.getString("si_acname"));
			si.setSi_acdate(rs.getString("si_acdate").replace("-", "."));
			si.setSi_recruit(rs.getString("si_recruit"));
			si.setSj_date(rs.getString("sj_date").replace("-", "."));
			si.setSj_status(rs.getString("sj_status"));
			
			return si;
		});
		return results;
	}

	// 봉사 참여 신청 취소
	public int setSvcCancel(int sjidx, int siidx, String miid) {
		String sql = "DELETE FROM t_service_join WHERE mi_id = '" + miid + "' AND sj_idx = " + sjidx + " " + 
				" AND si_idx = " + siidx;
		System.out.println(sql);
		int result = jdbc.update(sql);
		
		sql = "UPDATE t_service_info SET si_cnt = si_cnt - 1 WHERE si_idx = " + siidx;
		result += jdbc.update(sql);
		System.out.println(sql);
		return result;
	}

//	public String getMySvcSch(String where) {
//		String sql = "SELECT COUNT(*) FROM t_service_info a, t_service_join b " + 
//					" WHERE a.si_idx = b.si_idx AND a.si_view = 'y' " + where;
//		System.out.println(sql);
//		String result = jdbc.queryForObject(sql, String.class);
//		return result;
//	}
}