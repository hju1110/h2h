package svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeReplyProcSvc {

	public ArrayList<FreeReply> getReplyList(int flidx) {
		ArrayList<FreeReply> replyList = new ArrayList<FreeReply>();		//ArrayList�� ���°� �˾Ƴ��� �����ϱ� �׳� �����ع��� 
		
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		replyList = freeReplyProcDao.getReplyList(flidx);
		close(conn);	
				
				
				
		return replyList;
	}

	public int replyInsert(FreeReply freeReply) {
		int result = 0;
		
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		result = freeReplyProcDao.replyInsert(freeReply);		
	    if (result == 1) 	commit(conn);
		else 			    rollback(conn);
	    close(conn);
		
		
		return result;
	}

	public int replyGnb(FreeReplyGnb freeReplyGnb) {
		int result = 0;
		
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		result = freeReplyProcDao.replyGnb(freeReplyGnb);		
	    if (result == 2) 	commit(conn);
		else 			    rollback(conn);
	    close(conn);
	    
		return result;
	}

	public int replyDel(FreeReply freeReply) {
		int result = 0;
		
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		result = freeReplyProcDao.replyDel(freeReply);		
	    if (result > 0) 	commit(conn);
		else 			    rollback(conn);
	    close(conn);
	    
		return result;
	}

}
