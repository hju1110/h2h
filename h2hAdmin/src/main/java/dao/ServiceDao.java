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
	
	public List<ServiceInfo> getServiceList(String where, int cpage, int psize) {
		String sql = "select * from t_service_info " + where + " order by si_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		List<ServiceInfo> serviceInfo = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceInfo si = new ServiceInfo();
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSi_content(rs.getString("si_content"));
			si.setSi_cnt(rs.getInt("si_cnt"));
			si.setSi_acname(rs.getString("si_acname"));
			si.setSi_acdate(rs.getString("si_acdate"));
			si.setSi_recruit(rs.getString("si_recruit"));
			si.setSi_sdate(rs.getString("si_sdate"));
			si.setSi_edate(rs.getString("si_edate"));
			si.setSi_view(rs.getString("si_view"));
			si.setSi_accept(rs.getString("si_accept"));
			si.setSi_point(rs.getInt("si_point"));
			si.setSi_type(rs.getString("si_type"));
			si.setSi_read(rs.getInt("si_read"));
			si.setSi_date(rs.getString("si_date"));
			return si;
		});
		return serviceInfo;
	}
	public ServiceInfo getServiceViewx(int siidx) {
		int result = readUpdate(siidx);
		// 조회수 증가 메소드 호출
		String sql = "select * from t_service_Info where si_idx = " + siidx;
		ServiceInfo si = jdbc.queryForObject(sql, new RowMapper<ServiceInfo>() {
            @Override
            public ServiceInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
            	ServiceInfo si = new ServiceInfo();
            	si.setSi_idx(rs.getInt("si_idx"));
    			si.setSi_content(rs.getString("si_content"));
    			si.setSi_cnt(rs.getInt("si_cnt"));
    			si.setSi_acname(rs.getString("si_acname"));
    			si.setSi_acdate(rs.getString("si_acdate"));
    			si.setSi_recruit(rs.getString("si_recruit"));
    			si.setSi_sdate(rs.getString("si_sdate"));
    			si.setSi_edate(rs.getString("si_edate"));
    			si.setSi_view(rs.getString("si_view"));
    			si.setSi_person(rs.getInt("si_person"));
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
		String sql = "UPDATE t_service_info SET si_accept = 'y', si_view = 'y' WHERE si_idx = " + siidx;
		int result = jdbc.update(sql);
		return result;
	}
	
	public int serviceStop(int si_idx) {
		String sql = "update t_service_info set si_recruit = 'n' where si_accept = 'y' and  si_idx = '" + si_idx + "' ";
		System.out.println(sql);
		int result = jdbc.update(sql);		
		return result;
	}
	
	public int readUpdate(int siidx) {
		String sql = "update t_service_Info set si_read = si_read + 1 where si_idx = " + siidx;
		int result = jdbc.update(sql);
		return result;
	}
	
	public ServiceInfo getServiceView(int si_idx) {
		int result = readUpdate(si_idx);
		// 조회수 증가 메소드 호출
		String sql = "select * from t_service_Info where si_idx = " + si_idx;
		ServiceInfo si = jdbc.queryForObject(sql, new RowMapper<ServiceInfo>() {
            @Override
            public ServiceInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
            	ServiceInfo si = new ServiceInfo();
            	si.setSi_idx(rs.getInt("si_idx"));
    			si.setSi_content(rs.getString("si_content"));
    			si.setSi_cnt(rs.getInt("si_cnt"));
    			si.setSi_acname(rs.getString("si_acname"));
    			si.setSi_acdate(rs.getString("si_acdate"));
    			si.setSi_recruit(rs.getString("si_recruit"));
    			si.setSi_sdate(rs.getString("si_sdate"));
    			si.setSi_edate(rs.getString("si_edate"));
    			si.setSi_view(rs.getString("si_view"));
    			si.setSi_person(rs.getInt("si_person"));
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

	public List<ServiceInfo> getServiceMember(int si_idx) {
		String sql = "SELECT a.*, b.mi_name, b.mi_birth  FROM  t_serviece_join a, t_member_info b where a.si_idx = '" + si_idx + 
				"' and a.mi_id = b.mi_id";
		//System.out.println(sql);
		List<ServiceInfo> ml = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ServiceInfo si = new ServiceInfo();
			si.setSj_idx(rs.getInt("sj_idx"));
			si.setSi_idx(rs.getInt("si_idx"));
			si.setSj_date(rs.getString("sj_date"));
			si.setSj_point(rs.getInt("sj_point"));
			si.setSj_status(rs.getString("sj_status"));
			si.setMi_id(rs.getString("mi_id"));
			si.setMi_birth(rs.getString("mi_birth"));
			si.setMi_name(rs.getString("mi_name"));
			return si;
		});
		return ml;
	}
	
	///// 아래부터는 미완성 부분 /////
	public int serviceMemNO(String where) {
		String sql = "update t_serviece_join set sj_status = 'n' " + where;
		System.out.println(sql);
		int result = jdbc.update(sql);
		return result;
	}

	public int serviceMemOk(String where) {
		String sql = "update t_serviece_join set sj_status = 'y' " + where;
		System.out.println(sql);
		int result = jdbc.update(sql);
		return result;
	}
}