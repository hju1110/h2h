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
	
	public List<ServiceInfo> getServiceInfo(String where, int cpage, int psize) {
		List<ServiceInfo> serviceInfo = serviceDao.getServiceInfo(where,cpage, psize);
		return serviceInfo;
	}
	
	
	public ServiceInfo getServiceInfo(int siidx) {
		ServiceInfo si = serviceDao.getServiceList(siidx);
		return si;
	}

}
