package svc;

import java.util.*;
import dao.*;
import vo.*;

public class DonationSvc {
	private DonationDao donationDao;

	public void setDonationDao(DonationDao donationDao) {
		this.donationDao = donationDao;
	}

	public int getDonaMemListCount(String where) {
		int rcnt = donationDao.getDonaMemListCount(where);
		return rcnt;
	}

	public List<DonationInfo> getDonaMemList(String where, int cpage, int psize) {
		List<DonationInfo> dl = donationDao.getDonaMemList(where, cpage, psize);
		return dl;
	}
	
	public DonationInfo getDonaTotal() {
		DonationInfo di = donationDao.getDonaTotal();
		return di;
	}

	public String getDonaTotalPrice(String where) {
		String total = donationDao.getDonaTotalPrice(where);
		return total;
	}

	public List<DonationInfo> getDonaStatistics() {
		List<DonationInfo> donationList = donationDao.getDonaStatistics();
		return donationList;
	}
}
