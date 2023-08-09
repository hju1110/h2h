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
	}
	public void unpublishNotice(int nl_idx) {
        noticeDao.unpublishNotice(nl_idx);
    }
}

