package svc;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import dao.*;
import vo.*;

@Service
public class NoticeSvc {
	private NoticeDao noticeDao;

	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	/*
	public int noticeInsert(NoticeInfo nl) {
		int result = noticeDao.noticeInsert(nl);
		return result;
	}*/


	public List<NoticeList> getNoticeList(String where, int cpage, int psize) {
		List<NoticeList> noticeList = noticeDao.getNoticeList(where, cpage, psize);
		return noticeList;
	}

	public int getNoticeListCount(String where) {
		int rcnt = noticeDao.getNoticeListCount(where);
		return rcnt;
	}
	public NoticeList getNoticeInfo(int nlidx) {
		NoticeList nl = noticeDao.getNoticeInfo(nlidx);
		return nl;
	}


	public int noticeInsert(NoticeList nl) {
		int result = noticeDao.noticeInsert(nl);
		return result;
	}
	public int noticeUpdate(NoticeList nl) {
		int result = noticeDao.noticeUpdate(nl);
		return result;
	}/*
	public int noticedelete(int nlidx) {
	    // �����ͺ��̽����� nlidx�� �ش��ϴ� �������� ��ϱ� ����
	    int result = noticeDao.noticedelete(nlidx);
	    return result;
	}*/

}
	/*public int getNoticeListCount(String where) {
		rcnt = NoticeDao.getNoticeListCount(where);
		return rcnt;
	}*/
	
/*	public int noticeUpdate(NoticeInfo nl) {
		int result = noticeDao.noticeUpdate(nl);
		return result;
	} */

