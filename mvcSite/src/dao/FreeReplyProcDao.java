package dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ���(��ġ ��ӹ޵���)
import java.util.*;
import java.sql.*;
import vo.*;

public class FreeReplyProcDao {
	private static FreeReplyProcDao freeReplyProcDao;
	private Connection conn;
	private FreeReplyProcDao() {}		
	
	public static FreeReplyProcDao getInstance() {
		if (freeReplyProcDao == null) freeReplyProcDao = new FreeReplyProcDao();
		return freeReplyProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<FreeReply> getReplyList(int flidx) {
	// ������ �Խñۿ� ���ϴ� ��۵��� �����  ArrayList<FreeReply>������ �����ϴ� �޼ҵ� 
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<FreeReply> replyList = new ArrayList<FreeReply>();	
		// ��۵��� ����� ������ ArrayList ��ü
		FreeReply freeReply = null; 
		// replyList�� ������ �ϳ��� ��� ������ ���� �ν��Ͻ� 
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_free_reply where fr_isview = 'y' and fl_idx = " + flidx;
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {	//while�� ���� ������ rs���� �ִ��� ������ ���� �ñ����� �ʾƼ� 
				freeReply = new FreeReply();
				//�ϳ��� ��� �������� ������ FreeReply �� �ν��Ͻ� ���� 
				
				freeReply.setFr_idx(rs.getInt("fr_idx"));
				freeReply.setFl_idx(flidx);
				freeReply.setMi_id(rs.getString("mi_id"));
				freeReply.setFr_content(rs.getString("fr_content"));
				freeReply.setFr_good(rs.getInt("fr_good"));
				freeReply.setFr_bad(rs.getInt("fr_bad"));
				freeReply.setFr_ip(rs.getString("fr_ip"));
				freeReply.setFr_date(rs.getString("fr_date"));
				replyList.add(freeReply);
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ getFreeReplyList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		
		
		return replyList;
	}

	public int replyInsert(FreeReply freeReply) {
	// ����ڰ� �Է��� ����� ���̺� ���� ��Ű�� �޼ҵ� 
		int result = 0;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		
		try {
			String sql = "insert into t_free_reply (fl_idx, mi_id, fr_content, fr_ip) values (?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, freeReply.getFl_idx());		pstmt.setString(2, freeReply.getMi_id());
			pstmt.setString(3, freeReply.getFr_content());	pstmt.setString(4, freeReply.getFr_ip());
			result = pstmt.executeUpdate();	//��� ��� 
			
			stmt = conn.createStatement();//db����
			sql = "update t_free_list set fl_reply = fl_reply + 1 where fl_idx = " + freeReply.getFl_idx();
			stmt.executeUpdate(sql);		// ��� ���� ���� ���� ���� 
			
		}catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyInsert() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(pstmt); close(stmt);
		}		
		
		return result;
	}

	public int replyGnb(FreeReplyGnb freeReplyGnb) {
	// ������ ��ۿ� ���ƿ�/ �Ⱦ�並 ó���ϴ� �޼ҵ�
	// �̹� �����ߴ� ����� ��� -1, ���� ó�� ������ 2�� ó���� �ȵ����� 0�̳� 1 ���� 
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select frg_gnb from t_free_reply_gnb where mi_id = '" + freeReplyGnb.getMi_id() + "' and fr_idx = " 
			+ freeReplyGnb.getFr_idx();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {		// �̹� ���ƿ� �Ⱦ�信 ���� ������
				result = -1;
			} else {
				sql = "update t_free_reply set fr_" + freeReplyGnb.getFrg_gnb() + 
				" = fr_"+ freeReplyGnb.getFrg_gnb() + " + 1 where fr_idx = " + freeReplyGnb.getFr_idx();
				result = stmt.executeUpdate(sql);
				// ��ۿ� ���ƿ�/�Ⱦ�� ���� �߰� ���� ���� 
				
				sql = "insert into t_free_reply_gnb (mi_id,fr_idx,frg_gnb) value ('" + freeReplyGnb.getMi_id() + 
				"', " + freeReplyGnb.getFr_idx() + ", '" + freeReplyGnb.getFrg_gnb().charAt(0) + "')";
				result += stmt.executeUpdate(sql);
				//���ƿ�/�Ⱦ�� ���� �߰� ���� ���� 
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyGnb() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return result;
	}

	public int replyDel(FreeReply freeReply) {
	// ����ڰ� ������ ����� ���� ��Ű�� �޼ҵ�
		int result = 0;
		Statement stmt = null;
			
		try {
			stmt = conn.createStatement();
			String sql = "update t_free_reply set fr_isview = 'n' where mi_id = '" + freeReply.getMi_id() + "' and fr_idx = " 
			+ freeReply.getFr_idx();
			//System.out.println(sql); 
			result = stmt.executeUpdate(sql);
			
			sql = "update t_free_list set fl_reply = fl_reply - 1 where fl_idx = " + freeReply.getFl_idx();
			//System.out.println(sql); 					 
			result += stmt.executeUpdate(sql);
						
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyDel() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		
		return result;
	}
}
