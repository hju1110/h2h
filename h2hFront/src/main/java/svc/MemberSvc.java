package svc;

import dao.*;
import vo.*;

public class MemberSvc {
	private MemberDao memberDao;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	public int memberInsert(MemberInfo mi) {
		int result = memberDao.memberInsert(mi);
		
		return result;
	}
	
	public int chkDupEmail(String email) {
		int result = memberDao.chkDupEmail(email);
		
		return result;
	}

	public int memberAddrInsert(MemberAddr2 ma) {
		int result = memberDao.memberAddrInsert(ma);
		
		return result;
	}

	public String findId(String name, String email) {
		String result = memberDao.findId(name, email);
		
		return result;
	}

	public int findPw(String id, String name, String email) {
		int result = memberDao.findPw(id, name, email);
		
		return result;
	}

	public int chgPw(String id, String pw) {
		int result = memberDao.findPw(id, pw);
		return result;
	}

	public int chkPw(String id, String pw) {
		int result = memberDao.chkPw(id, pw);
		
		return result;
	}

	public int chgMemberInfo(MemberInfo mi) {
		int result = memberDao.chgMemberInfo(mi);
		
		return result;
	}
}
