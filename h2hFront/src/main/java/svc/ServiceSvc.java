package svc;

import java.sql.SQLException;
import java.util.*;

import org.springframework.transaction.annotation.Transactional;

import dao.*;
import vo.*;

public class ServiceSvc {
	private ServiceDao serviceDao;

	public void setServiceDao(ServiceDao serviceDao) {
		this.serviceDao = serviceDao;
	}
	
	public int getServiceInfoCount(String where) {
		int rcnt = serviceDao.getServiceInfoCount(where);
		return rcnt;
	}
	
	public List<ServiceInfo> getServiceInfo(String where, int cpage, int psize) {
		List<ServiceInfo> serviceInfo = serviceDao.getServiceInfo(where,cpage, psize);
		return serviceInfo;
	}
	
	
	public ServiceInfo getServiceList(int siidx) {
		ServiceInfo si = serviceDao.getServiceList(siidx);
		return si;
	}

	@Transactional(rollbackFor = SQLException.class)
	public int setFinish(ServiceMember sm) {
		int result = serviceDao.setFinish(sm);
		return result;
	}

	public int setSvcProcIn(ServiceInfo si) {
		int result = serviceDao.setSvcProcIn(si);
		return result;
	}

	public int getServiceListCount(String where) {
		int rcnt = serviceDao.getServiceListCount(where);
		return rcnt;
	}

	public List<ServiceInfo> getServiceMemList(int cpage, int psize, String where) {
		List<ServiceInfo> si = serviceDao.getServiceMemList(cpage, psize, where);
		return si;
	}

	@Transactional(rollbackFor = SQLException.class)
	public int setSvcCancel(int sjidx, int siidx, String miid) {
		int result = serviceDao.setSvcCancel(sjidx, siidx, miid);
		return result;
	}

//	public String getMySvcSch(String where) {
//		String result = serviceDao.getMySvcSch(where);
//		return result;
//	}
}
