package svc;

import java.sql.SQLException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

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



	public ParcelInfo getParcelView(String miid, String pi_id, String oi_id) {
		ParcelInfo parcelInfo = parcelProcDao.getParcelView(miid, pi_id, oi_id);
		return parcelInfo;
	}

	public int orderProcUp(ParcelInfo pi) {
		int result = parcelProcDao.orderProcUp(pi);
		return result;
	}

	public int orderProcB(String oi_id, String mi_id, String oi_status) {
		int result = parcelProcDao.orderProcB(oi_id, mi_id, oi_status);
		return result;
	}

	public int orderProcC(String oi_id, String mi_id, String oi_status) {
		int result = parcelProcDao.orderProcC(oi_id, mi_id, oi_status);
		return result;
	}

	@Transactional(rollbackFor = SQLException.class)
	public int orderProcD(String oi_id, String mi_id, String pi_id, int oi_pay) {
		int result = parcelProcDao.orderProcD(oi_id, mi_id, pi_id, oi_pay);
		return result;
	}

	public int getParcelListCount(String where) {
		int rcnt = parcelProcDao.getParcelListCount(where);
		return rcnt;
	}

	public List<OrderProcInCtrl> getParcelList(String where, int cpage, int psize, String miid) {
		List<OrderProcInCtrl> parcelList = parcelProcDao.getParcelList(where, cpage, psize, miid);
		return parcelList;
	}

}
