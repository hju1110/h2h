package svc;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ���(��ġ ��ӹ޵���)
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginProcSvc {
//�α��ο� �ʿ��� ���̵�� ��ȣ�� �޾� ����Ͻ� ������ ó��(���� �۾� ����)�ϴ� Ŭ����
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
