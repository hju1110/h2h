package svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용(마치 상속받듯이)
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginProcSvc {
//로그인에 필요한 아이디와 암호를 받아 비즈니스 로직을 처리(쿼리 작업 제외)하는 클래스
	public MemberInfo getLoginInfo(String uid, String pwd) {
		MemberInfo loginInfo = null;
		Connection conn = getConnection();
		LoginProcDao loginProcDao = LoginProcDao.getInstance();
		loginProcDao.setConnection(conn);
		
		loginInfo = loginProcDao.getLoginInfo(uid, pwd);
		close(conn);
		
		return loginInfo;
	}	
}
