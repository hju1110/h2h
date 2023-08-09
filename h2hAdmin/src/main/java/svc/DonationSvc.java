package svc;

import java.util.*;
import dao.*;
import vo.*;

public class DonationSvc {
	private DonationDao donationDao;

	public void setDonationDao(DonationDao donationDao) {
		this.donationDao = donationDao;
	}

	public int getDonaMemListCount() {
		int rcnt = donationDao.getDonaMemListCount();
		return rcnt;
	}

	public List<DonationInfo> getDonaMemList(String where) {
		List<DonationInfo> dl = donationDao.getDonaMemList(where);
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




	/*public List<DonaTotalPrice> getDonaTotalPrice(int mdPrice, String mdCtgr, String diSponsor, String ydate, String mdate) {
		List<DonaTotalPrice> donaTPrice = donationDao.getDonaTotalPrice(mdPrice, mdCtgr, diSponsor, ydate, mdate);
		return donaTPrice;
	}*/
}
