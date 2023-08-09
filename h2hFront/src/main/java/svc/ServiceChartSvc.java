package svc;

import java.util.*;
import dao.*;
import vo.*;

public class ServiceChartSvc {
	private ServiceChartDao serviceChartDao;
	
	public void setServiceChartDao(ServiceChartDao serviceChartDao) {
		this.serviceChartDao = serviceChartDao;
	}

	public int getServiceInfoCount(String where) {
		int rcnt = serviceChartDao.getServiceChartInfoCount(where);
		return rcnt;
	}

	public List<ServiceChartInfo> getServiceChartInfo(String where, int cpage, int psize) {
		List<ServiceChartInfo> serviceChartInfo = serviceChartDao.getServiceChartInfo(where,cpage, psize);
		return serviceChartInfo;
	}
}
