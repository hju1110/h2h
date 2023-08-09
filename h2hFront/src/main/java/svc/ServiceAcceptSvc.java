package svc;

import java.util.*;
import dao.*;
import vo.*;


public class ServiceAcceptSvc {
	private ServiceAcceptDao serviceAcceptDao;
	
	public void setServiceAcceptDao(ServiceAcceptDao serviceAcceptDao) {
		this.serviceAcceptDao = serviceAcceptDao;
	}
	
	public int getServiceInfoCount(String where) {
		int rcnt = serviceAcceptDao.getServiceAcceptInfoCount(where);
		return rcnt;
	}

	public List<ServiceAcceptInfo> getServiceAcceptInfo(String where, int cpage, int psize) {
		List<ServiceAcceptInfo> serviceAcceptInfo = serviceAcceptDao.getServiceAcceptInfo(where,cpage, psize);
		return serviceAcceptInfo;
	}

	public List<ServiceAcceptInfo> getServiceAcceptList(int siidx) {
		List<ServiceAcceptInfo> scList = serviceAcceptDao.getServiceAccept(siidx);
		return scList;
	}
}
