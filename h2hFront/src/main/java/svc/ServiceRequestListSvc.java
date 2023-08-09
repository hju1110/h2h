package svc;

import java.util.*;
import dao.*;
import vo.*;

public class ServiceRequestListSvc {
		private ServiceRequestListDao serviceRequestListDao;
		
		public void setServiceRequestListDao(ServiceRequestListDao serviceRequestListDao) {
			this.serviceRequestListDao = serviceRequestListDao;
		}

		public int getServiceInfoCount(String where) {
			int rcnt = serviceRequestListDao.getServiceRequestListDao(where);
			return rcnt;
		}

		public List<ServiceRequestListInfo> getServiceRequestListInfo(String where, String miid,int cpage, int psize) {
			List<ServiceRequestListInfo> serviceRequestListInfo = serviceRequestListDao.getServiceRequestListInfo(where, miid, cpage, psize);
			return serviceRequestListInfo;
		}
	}

