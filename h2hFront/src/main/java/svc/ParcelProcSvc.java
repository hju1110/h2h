package svc;

import java.util.List;

import dao.OrderProcDao;
import dao.*;
import vo.OrderCart;
import vo.OrderProcInCtrl;
import vo.ParcelInfo;

public class ParcelProcSvc {
	private ParcelProcDao parcelProcDao;
	
	public void setParcelProcDao(ParcelProcDao parcelProcDao) {
		this.parcelProcDao = parcelProcDao;
	}

	public List<OrderProcInCtrl> getParcelList(String miid) {
		List<OrderProcInCtrl> parcelList = parcelProcDao.getParcelList(miid);
		return parcelList;
	}

	public ParcelInfo getParcelView(String miid, String pi_id, String oi_id) {
		ParcelInfo parcelInfo = parcelProcDao.getParcelView(miid, pi_id, oi_id);
		return parcelInfo;
	}

}
