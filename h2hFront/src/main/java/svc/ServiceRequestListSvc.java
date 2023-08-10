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

		public List<ServiceMember> getServiceRequestListInfo(String where, String miid,int cpage, int psize) {
			List<ServiceMember> serviceRequestListInfo = serviceRequestListDao.getServiceRequestListInfo(where, miid, cpage, psize);
			return serviceRequestListInfo;
		}
	}

