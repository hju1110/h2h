package svc;

import java.sql.SQLException;
import java.util.*;

import org.springframework.transaction.annotation.Transactional;

import dao.*;
import vo.*;

import dao.DonationDao;

public class DonationSvc {
	private DonationDao donationDao;

	public void setDonationDao(DonationDao donationDao) {
		this.donationDao = donationDao;
	}
	
	public int getDonaMemListCount(String miid) {
		int rcnt = donationDao.getDonaMemListCount(miid);
		return rcnt;
	}

	public List<DonationInfo> getDonaMemList(String miid, int cpage, int psize) {
		List<DonationInfo> dl = donationDao.getDonaMemList(miid, cpage, psize);
		return dl;
	}


	public String getDonaTotalPrice(String where) {
		String total = donationDao.getDonaTotalPrice(where);
		return total;
	}

	public int donaDel(String miid, int di_idx, int md_idx, int md_price) {
		int result = donationDao.donaDel(miid, di_idx, md_idx, md_price);
		return result;
	}

	public int getDonaMemInfo(MemberInfo mi) {
		int result = donationDao.getDonaMemInfo(mi);
		return result;
	}

	@Transactional(rollbackFor = SQLException.class)
	public int donaInsert(MemberInfo mi, DonationInfo di) {
		int result = donationDao.donaInsert(mi, di);
		return result;
	}
}
