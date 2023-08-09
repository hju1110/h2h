package svc;

import java.util.List;

import dao.MemberInfoDao;
import vo.MemberManagementInfo;

public class MemberInfoSvc {
	private MemberInfoDao memberInfoDao;
	
	public void setMemberInfoDao(MemberInfoDao memberInfoDao) {
		this.memberInfoDao = memberInfoDao;
	}

	public List<MemberManagementInfo> getMemberManagementInfo(String where, int cpage, int psize) {
		List<MemberManagementInfo> memberManagementInfo = memberInfoDao.getMemberManagementInfo(where, cpage, psize);
		
		return memberManagementInfo;
	}

	public int getMemberListCount(String where) {
		int rcnt = memberInfoDao.getMemberListCount(where);
		
		return rcnt;
	}

}
