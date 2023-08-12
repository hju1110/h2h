package svc;

import java.util.*;
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
	
	public List<ServiceInfo> getServiceList(String where, int cpage, int psize) {
		List<ServiceInfo> serviceInfo = serviceDao.getServiceList(where,cpage, psize);
		return serviceInfo;
	}
	
	public int getAccept(int siidx) {
		int result = serviceDao.getAccept(siidx);
		return result;
	}
	
	public int serviceStop(int si_idx) {
		int result = serviceDao.serviceStop(si_idx);
		return result;
	}
	
	
	public ServiceInfo getServiceView(int si_idx) {
		ServiceInfo si = serviceDao.getServiceView(si_idx);
		return si;
	}
	
	public List<ServiceInfo> getServiceMember(int si_idx) {
		List<ServiceInfo> ml = serviceDao.getServiceMember(si_idx);
		return ml;
	}
	public ServiceInfo getServiceViewx(int siidx) {
		ServiceInfo si = serviceDao.getServiceViewx(siidx);
		return si;
	}
	
	
	////////// 아래부터는 미완성 부분 /////
	public int serviceMemNO(String where) {
		int result = serviceDao.serviceMemNO(where);
		return result;
	}

	public int serviceMemOk(String where) {
		int result = serviceDao.serviceMemOk(where);
		return result;
	}

}
