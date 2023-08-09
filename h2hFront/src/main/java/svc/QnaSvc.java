package svc;

import java.util.*;
import org.springframework.stereotype.*;
import dao.*;
import vo.*;

@Service
public class QnaSvc {
    private QnaDao qnaDao;

    
    public void setQnaDao(QnaDao qnaDao) {
        this.qnaDao = qnaDao;
    }
    
    public List<QnaList> getQnaList(String where, int cpage, int psize) {
        List<QnaList> qnaList = qnaDao.getQnaList(where, cpage, psize);
        return qnaList;
    }

    public int getQnaListCount(String where) {
        int rcnt = qnaDao.getQnaListCount(where);
        return rcnt;
    }
    
	public int qnaInsert(QnaList ql) {
		int result = qnaDao.qnaInsert(ql);
		return result;
	}

	public QnaList getQnaInfo(int qlidx) {
		QnaList ql = qnaDao.getQnaList(qlidx);
		return ql;
	}
}
